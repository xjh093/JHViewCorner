# UIView-JHViewCorner
Set view's corner with one code! & 1 行代码设置圆角

## What is it?

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/JHViewCorner/Images/image1.png)

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/JHViewCorner/Images/image2.png)

## Notice

If you use it in "UITableViewCell"

you should override the blow methods:

```

// you have a image like this:
[_image1 jh_setCornerRadius:H*0.5
                      color:self.contentView.backgroundColor
                 rectCorner:UIRectCornerAllCorners
           highlightedColor:UIColorFromRGB(0xd9d9d9)];

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    _image1.jh_highlightedMaskView.hidden = !selected;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];

    _image1.jh_highlightedMaskView.hidden = !highlighted;
}

```

## Logs:

#### 4.add heart border mask. (2018-6-15)

#### 3.add heart mask. (2018-5-25)

#### 2.update. (2018-5-8)

#### 1.upload. (2018-5-7)

---

## API

```
@interface UIView (JHViewCorner)


- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner highlightedColor:(UIColor *)highlightedColor;

- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width highlightedColor:(UIColor *)highlightedColor;

@property (nonatomic,  strong,  readonly) UIImageView *jh_maskView;

/// Default is hidden.
@property (nonatomic,  strong,  readonly) UIImageView *jh_highlightedMaskView;

- (void)jh_setHeartMask:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;

- (void)jh_setHeartMask:(UIColor *)color borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width highlightedColor:(UIColor *)highlightedColor;

@property (nonatomic,  strong,  readonly) UIImageView *jh_heartBorderMaskView;

@end
```

## Something About More
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



