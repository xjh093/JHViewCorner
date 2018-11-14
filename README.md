# UIView-JHViewCorner
Set view's corner with one code! & 1 行代码设置圆角

## Version 
[Release](https://github.com/xjh093/JHViewCorner/releases)

### 1.2.3 (2018-11-14)
### 1.2.2 (2018-8-16)
### 1.2.0 (2018-7-3)
### 1.1.0 (2018-6-19)
### 1.0.0 (2018-6-15)

## Pod
``` pod 'JHViewCorner'```

## What is it?

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/image1.png)

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/image2.png)

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

#### 7.fix a small bugs.(2018-11-14)

#### 6.add property 'jh_maskViewArray'.(2018-7-3)

#### 5.remove property 'jh_heartBorderMaskView'. (2018-6-19)

#### 4.add heart border mask. (2018-6-15)

#### 3.add heart mask. (2018-5-25)

#### 2.update. (2018-5-8)

#### 1.upload. (2018-5-7)

---

## GIF

### Can reach 60FPS!

![image](https://github.com/xjh093/GIF/blob/master/gif/Jun-19-2018%2018-10-07.gif)

## API

```
@interface UIView (JHViewCorner)

#pragma mark - v1.0.0
- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner highlightedColor:(UIColor *)highlightedColor;

- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width highlightedColor:(UIColor *)highlightedColor;

@property (nonatomic,  strong,  readonly) UIImageView *jh_maskView;

/// Default is hidden.
@property (nonatomic,  strong,  readonly) UIImageView *jh_highlightedMaskView;

#pragma mark - v1.1.0
- (void)jh_setHeartMask:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;

- (void)jh_setHeartMask:(UIColor *)color borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width highlightedColor:(UIColor *)highlightedColor;

#pragma mark - v1.2.0
- (void)jh_setCornerRadius:(CGFloat)radius color:(UIColor *)color rectCorner:(UIRectCorner)corner;

@property (nonatomic,  strong,  readonly) NSArray *jh_maskViewArray;

@end
```

## Something About More
## CGPathDrawingMode

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/%E5%9C%86%E8%A7%92.png)

## BorderColor & BorderWidth

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/%E8%BE%B9%E6%A1%86.png)

# More Details

Not Good!🤔

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/002.png)

Not Good!🤔

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/001.png)

Not Good!🤔

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/004.png)

Good!👍👍👍

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/003.png)



