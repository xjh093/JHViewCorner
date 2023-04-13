# JHViewCorner
Set view's corner with one code! 
- 1 行代码设置圆角

---

# Version 
Latest release version:
- [1.2.4](https://github.com/xjh093/JHViewCorner/releases)

---

# Cocoapods
`pod "JHViewCorner"`

---

# What

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/image1.png)

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/image2.png)

---

# Usage
```
// corner
[_imageView jh_setCornerRadius:H*0.5
                         color:self.superview.backgroundColor
                    rectCorner:UIRectCornerAllCorners
              highlightedColor:nil];

// corner and border
[_imageView jh_setCornerRadius:H*0.5
                         color:self.superview.backgroundColor
                    rectCorner:UIRectCornerAllCorners
                    borderColor:borderColor 
                    borderWidth:width
              highlightedColor:nil];

// heart
[_imageView jh_setHeartMask:color 
           highlightedColor:highlightedColor];
           
// heart and border
[_imageView jh_setHeartMask:color 
                borderColor:borderColor 
                borderWidth:width 
           highlightedColor:highlightedColor];

```
---

# Logs
### 2023-4-13
- fix bug in iOS16.

### 2020-09-15
- fix a small bugs.

### 2018-11-14
- fix a small bugs.

### 2018-7-3
- add property 'jh_maskViewArray'.

### 2018-6-19
- remove property 'jh_heartBorderMaskView'.

### 2018-6-15
- add heart border mask.

### 2018-5-25
- add heart mask.

### 2018-5-8
- update.

#### 2018-5-7
- upload.

---

# Notice

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

---

## GIF

### Can reach 60FPS!

![image](https://github.com/xjh093/GIF/blob/master/gif/Jun-19-2018%2018-10-07.gif)

---

# More
## CGPathDrawingMode

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/%E5%9C%86%E8%A7%92.png)

## BorderColor & BorderWidth

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/%E8%BE%B9%E6%A1%86.png)

## More Details

Not Good!🤔

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/002.png)

Not Good!🤔

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/001.png)

Not Good!🤔

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/004.png)

Good!👍👍👍

![image](https://github.com/xjh093/UIView-JHViewCorner/blob/master/Images/003.png)



