//
//  UIView+JHViewCorner.m
//  JHKit
//
//  Created by HaoCold on 2018/3/27.
//  Copyright © 2018年 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2018 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "UIView+JHViewCorner.h"
#import <objc/runtime.h>

#if 0
#define kCGPath kCGPathEOFillStroke
#else
#define kCGPath kCGPathEOFill
#endif

// kCGPathEOFill 比 kCGPathEOFillStroke 的半径要大一点

static CGFloat _padding;

@implementation UIView (JHViewCorner)

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _padding = 1.0/[UIScreen mainScreen].scale;
    });
}

// + (void)initialize{
//     _padding = 1.0/[UIScreen mainScreen].scale;
// }

#pragma mark - public

- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner highlightedColor:(UIColor *)highlightedColor{
#if 1
    [self jh_setCornerRadius:radius color:color rectCorner:corner borderColor:nil borderWidth:0 highlightedColor:highlightedColor];
#else
    UIImage *image = [self imageWithCornerRadius:radius color:color rectCorner:corner borderColor:nil borderWidth:0];
    if (image) {
        [self addMaskImage:image offset:-_padding];

        UIImage *highlightedImage = [self imageWithCornerRadius:radius color:highlightedColor rectCorner:corner borderColor:nil borderWidth:0];
        if (highlightedImage) {
            [self addHighlightedMaskImage:highlightedImage offset:-_padding];
        }
    }
#endif
}

- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width highlightedColor:(UIColor *)highlightedColor{
    UIImage *image = [self imageWithCornerRadius:radius color:color rectCorner:corner borderColor:borderColor borderWidth:width];
    if (image) {
        [self addMaskImage:image offset:-_padding];
    }
    
    UIImage *highlightedImage = [self imageWithCornerRadius:radius color:highlightedColor rectCorner:corner borderColor:borderColor borderWidth:width];
    if (highlightedImage) {
        [self addHighlightedMaskImage:highlightedImage offset:-_padding];
    }
}

- (UIImageView *)jh_maskView{
    return [self getImageMaskView];
}

- (UIImageView *)jh_highlightedMaskView{
    return [self getHighlightedMaskView];
}

- (void)jh_setHeartMask:(UIColor *)color highlightedColor:(UIColor *)highlightedColor{
#if 1
    [self jh_setHeartMask:color borderColor:nil borderWidth:0 highlightedColor:highlightedColor];
#else
    UIImage *image = [self heartImageWithColor:color offset:0];
    if (image) {
        [self addMaskImage:image offset:0];
        
        UIImage *highlightedImage = [self heartImageWithColor:highlightedColor offset:0];
        if (highlightedImage) {
            [self addHighlightedMaskImage:highlightedImage offset:0];
        }
    }
#endif
}

- (void)jh_setHeartMask:(UIColor *)color borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width highlightedColor:(UIColor *)highlightedColor{
    UIImage *image = [self heartImageWithColor:color offset:0];
    UIImage *highlightedImage = [self heartImageWithColor:highlightedColor offset:0];
    UIImage *borderImage;
    
    // border
    if (width > 0) {
        borderImage = [self heartImageWithColor:borderColor offset:width];
    }
    
    if (borderImage) {
        CGFloat scale = [UIScreen mainScreen].scale;
        CGFloat W = ceil(CGRectGetWidth(self.bounds)*scale)/scale;
        CGFloat H = ceil(CGRectGetHeight(self.bounds)*scale)/scale;
        CGRect rect = CGRectMake(0, 0, W, H);
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, scale);
        
        if (image) {
            [borderImage drawInRect:rect];
            [image drawInRect:rect];
            image = UIGraphicsGetImageFromCurrentImageContext();
            [self addMaskImage:image offset:0];
        }
        
        if (highlightedImage) {
            [highlightedImage drawInRect:rect];
            highlightedImage = UIGraphicsGetImageFromCurrentImageContext();
            [self addHighlightedMaskImage:highlightedImage offset:0];
        }
        
        UIGraphicsEndImageContext();
    }else{
        if (image) {
            [self addMaskImage:image offset:0];
        }
        if (highlightedImage) {
            [self addHighlightedMaskImage:highlightedImage offset:0];
        }
    }
}

- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner{
    UIImage *image = [self imageWithCornerRadius:radius color:color rectCorner:corner borderColor:nil borderWidth:0];
    
    CGFloat offset = -_padding;
    UIImageView *maskView = [[UIImageView alloc] init];
    maskView.frame = CGRectInset(self.bounds, offset, offset);
    maskView.image = image;
    maskView.hidden = YES;
    [self addSubview:maskView];
    [self addMaskView:maskView];
}

- (NSArray *)jh_maskViewArray{
    return [[self getMaskViewArray] copy];
}

#pragma mark - private

- (UIImage *)imageWithCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width{
    if (![self colorJudge:color]) {
        return nil;
    }
    
    CGRect bounds = self.bounds;
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color set];
    
    // let rect a little big than bounds.
    CGRect bigRect = CGRectInset(bounds, -_padding, -_padding);
    CGRect smallRect = CGRectInset(bounds, _padding, _padding);
    UIBezierPath *rect = [UIBezierPath bezierPathWithRect:bigRect];
    UIBezierPath *round = [UIBezierPath bezierPathWithRoundedRect:smallRect byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    [rect appendPath:round];
    CGContextAddPath(context, rect.CGPath);
    CGContextDrawPath(context, kCGPath);
    
    // border
    if ([self colorJudge:borderColor] && width > 0) {
        [borderColor set];
        CGRect innerBounds = CGRectInset(smallRect, width, width);
        UIBezierPath *roundIn = [UIBezierPath bezierPathWithRoundedRect:innerBounds cornerRadius:radius];
        [round appendPath:roundIn];
        CGContextAddPath(context, round.CGPath);
        CGContextDrawPath(context, kCGPath);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)heartImageWithColor:(UIColor *)color offset:(CGFloat)offset{
    if (![self colorJudge:color]) {
        return nil;
    }
    
    CGFloat offset1 = offset + 0.5;
    CGFloat offset2 = 2*offset1;
    CGFloat w = CGRectGetWidth(self.bounds)-offset2*1.5;
    
    CGRect bounds = self.bounds;
    CGSize size = CGSizeMake(bounds.size.width-offset1, bounds.size.height-offset1);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color set];
    
    UIBezierPath *rect = [UIBezierPath bezierPathWithRect:bounds];
    [self heartPath:w offset:offset1 rect:rect context:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (BOOL)colorJudge:(UIColor *)color{
    if (color == nil) {
        return NO;
    }
    
    CGFloat a;
    [color getRed:NULL green:NULL blue:NULL alpha:&a];
    if (a < 1.0) {
        return NO;
    }
    
    return YES;
}

- (void)heartPath:(CGFloat)w offset:(CGFloat)offset rect:(UIBezierPath *)rect context:(CGContextRef)context{
    CGFloat radius = w*(7/24.0);
    CGFloat point = radius + offset;
    CGPoint leftPoint = CGPointMake(point,point);
    CGPoint rightPoint = CGPointMake(w-point+offset*2,point);
    
    // clockwise 顺时针
    UIBezierPath *leftArc = [UIBezierPath bezierPathWithArcCenter:leftPoint radius:radius startAngle:-M_PI_4 endAngle:M_PI_2+M_PI_4 clockwise:0];
    
    UIBezierPath *rightArc = [UIBezierPath bezierPathWithArcCenter:rightPoint radius:radius startAngle:-M_PI_2-M_PI_4 endAngle:M_PI_4 clockwise:1];
    
    UIBezierPath *line = [UIBezierPath bezierPath];
    
    [line moveToPoint:CGPointMake(w*0.5 + offset,w/12.0 + offset)];
    [line addLineToPoint:CGPointMake(w/12.0 + offset, w*0.5 + offset)];
    [line addLineToPoint:CGPointMake(w*0.5 + offset, w + offset)];
    [line addLineToPoint:CGPointMake(w*11/12.0 + offset, w*0.5 + offset)];
    
    [rect appendPath:leftArc];
    [rect appendPath:rightArc];
    [rect appendPath:line];
    
    CGContextAddPath(context, rect.CGPath);
    CGContextDrawPath(context, kCGPath);
}

- (void)addMaskImage:(UIImage *)image offset:(CGFloat)offset{
    UIImageView *maskView = [[UIImageView alloc] init];
    maskView.frame = CGRectInset(self.bounds, offset, offset);
    maskView.image = image;
    [self addSubview:maskView];
    [self setImageMaskView:maskView];
}

- (void)addHighlightedMaskImage:(UIImage *)highlightedImage offset:(CGFloat)offset{
    UIImageView *highlightedImageView = [[UIImageView alloc] init];
    highlightedImageView.frame = CGRectInset(self.bounds, offset, offset);
    highlightedImageView.image = highlightedImage;
    highlightedImageView.hidden = YES;
    [self addSubview:highlightedImageView];
    [self setHighlightedMaskView:highlightedImageView];
}

- (void)setImageMaskView:(UIImageView *)imageView{
    objc_setAssociatedObject(self, @selector(getImageMaskView), imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)getImageMaskView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHighlightedMaskView:(UIImageView *)imageView{
    objc_setAssociatedObject(self, @selector(getHighlightedMaskView), imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)getHighlightedMaskView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setMaskViewArray:(NSMutableArray *)maskViewArray{
    objc_setAssociatedObject(self, @selector(getMaskViewArray), maskViewArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)getMaskViewArray{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)addMaskView:(UIImageView *)maskView{
    NSMutableArray *marr = [self getMaskViewArray];
    if (!marr) {
        marr = @[].mutableCopy;
        [self setMaskViewArray:marr];
    }
    [marr addObject:maskView];
}

@end
