//
//  UIView+JHViewCorner.h
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

#import <UIKit/UIKit.h>

@interface UIView (JHViewCorner)

#pragma mark - v1.0.0

/**
 This method will generate a imageView as a mask if 'color' is not nil and its alpha is 1.0.
 
 @param radius radius.
 @param color normal color.
 @param corner UIRectCorner.
 @param highlightedColor highlighted Color.
 */
- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner highlightedColor:(UIColor *)highlightedColor;

/**
 This method will generate a imageView as a mask if 'color' is not nil and its alpha is 1.0.
 
 @param radius radius.
 @param color normal color.
 @param corner UIRectCorner.
 @param borderColor borderColor.
 @param width borderWidth.
 @param highlightedColor highlighted Color.
 */
- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width highlightedColor:(UIColor *)highlightedColor;

///
@property (nonatomic,  strong,  readonly) UIImageView *jh_maskView;

/// Default is hidden.
@property (nonatomic,  strong,  readonly) UIImageView *jh_highlightedMaskView;

#pragma mark - v1.1.0
/**
 This method will generate a heart imageView as a mask if 'color' is not nil and its alpha is 1.0.
 
 @param color normal color.
 @param highlightedColor highlighted Color.
 */
- (void)jh_setHeartMask:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;

/**
 This method will generate a heart imageView as a mask if 'color' is not nil and its alpha is 1.0.
 
 @param color normal color.
 @param borderColor borderColor.
 @param width borderWidth.
 @param highlightedColor highlighted Color.
 */
- (void)jh_setHeartMask:(UIColor *)color borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width highlightedColor:(UIColor *)highlightedColor;

#pragma mark - v1.2.0
/**
 This method will generate a imageView as a mask if 'color' is not nil and its alpha is 1.0.
 The generate imageView is added in 'jh_maskViewArray'. All objects is hidden.
 
 @param radius radius.
 @param color normal color.
 @param corner UIRectCorner.
 */
- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner;

@property (nonatomic,  strong,  readonly) NSArray *jh_maskViewArray;

@end
