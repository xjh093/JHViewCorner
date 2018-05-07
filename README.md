# UIView-JHViewCorner
Set view's corner with one code!


.h

```
@interface UIView (JHViewCorner)


- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner highlightedColor:(UIColor *)highlightedColor;

- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width highlightedColor:(UIColor *)highlightedColor;

@property (nonatomic,  strong,  readonly) UIImageView *jh_maskView;

/// Default is hidden.
@property (nonatomic,  strong,  readonly) UIImageView *jh_highlightedMaskView;

@end
```

## CGPathDrawingMode

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/JHViewCorner/Images/%E5%9C%86%E8%A7%92.png)

## BorderColor & BorderWidth

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/JHViewCorner/Images/%E8%BE%B9%E6%A1%86.png)

# More Details

Not Good!🤔

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/JHViewCorner/Images/002.png)

Not Good!🤔

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/JHViewCorner/Images/001.png)

Not Good!🤔

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/JHViewCorner/Images/004.png)

Good!👍👍👍

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/JHViewCorner/Images/003.png)



