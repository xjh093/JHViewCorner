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

@implementation UIView (JHViewCorner)

#pragma mark - public

- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner highlightedColor:(UIColor *)highlightedColor{
    UIImage *image = [self imageWithCornerRadius:radius color:color rectCorner:corner];
    if (image) {
        UIImageView *maskView = [[UIImageView alloc] init];
        maskView.frame = CGRectInset(self.bounds, -0.3, -0.3);
        maskView.image = image;
        [self addSubview:maskView];
        [self setMaskView:maskView];

        if ([self colorJudge:highlightedColor]) {
            UIImageView *highlightedImageView = [[UIImageView alloc] init];
            highlightedImageView.frame = maskView.frame;
            highlightedImageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            highlightedImageView.tintColor = highlightedColor;
            highlightedImageView.hidden = YES;
            [self addSubview:highlightedImageView];
            [self setHighlightedMaskView:highlightedImageView];
        }
    }
}

- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width highlightedColor:(UIColor *)highlightedColor{
    UIImage *image = [self imageWithCornerRadius:radius color:color rectCorner:corner borderColor:borderColor borderWidth:width];
    if (image) {
        UIImageView *maskView = [[UIImageView alloc] init];
        maskView.frame = CGRectInset(self.bounds, -0.3, -0.3);
        maskView.image = image;
        [self addSubview:maskView];
        [self setMaskView:maskView];
    }
    
    UIImage *highlightedImage = [self imageWithCornerRadius:radius color:highlightedColor rectCorner:corner borderColor:borderColor borderWidth:width];
    if (highlightedImage) {
        UIImageView *highlightedImageView = [[UIImageView alloc] init];
        highlightedImageView.frame = CGRectInset(self.bounds, -0.3, -0.3);
        highlightedImageView.image = highlightedImage;
        highlightedImageView.hidden = YES;
        [self addSubview:highlightedImageView];
        [self setHighlightedMaskView:highlightedImageView];
    }
}

- (UIImageView *)jh_maskView{
    return [self getMaskView];
}

- (UIImageView *)jh_highlightedMaskView{
    return [self getHighlightedMaskView];
}

#pragma mark - private

- (UIImage *)imageWithCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner{
    if (![self colorJudge:color]) {
        return nil;
    }
    
    CGRect bounds = self.bounds;
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color set];
    
    // let rect a little big than bounds.
    CGRect bigRect = CGRectInset(bounds, -0.3, -0.3);
    CGRect smallRect = CGRectInset(bounds, 0.3, 0.3);
    UIBezierPath *rect = [UIBezierPath bezierPathWithRect:bigRect];
    UIBezierPath *round = [UIBezierPath bezierPathWithRoundedRect:smallRect byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    [rect appendPath:round];
    CGContextAddPath(context, rect.CGPath);
    CGContextDrawPath(context, kCGPath);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)imageWithCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width{

    if (![self colorJudge:color]) {
        return nil;
    }
    
    CGRect bounds = self.bounds;
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color set];
    
    // let rect a little big than bounds.
    CGRect bigRect = CGRectInset(bounds, -0.3, -0.3);
    CGRect smallRect = CGRectInset(bounds, 0.3, 0.3);
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

- (BOOL)colorJudge:(UIColor *)color
{
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

- (void)setMaskView:(UIImageView *)imageView{
    objc_setAssociatedObject(self, @selector(getMaskView), imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)getMaskView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHighlightedMaskView:(UIImageView *)imageView{
    objc_setAssociatedObject(self, @selector(getHighlightedMaskView), imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)getHighlightedMaskView{
    return objc_getAssociatedObject(self, _cmd);
}

@end
