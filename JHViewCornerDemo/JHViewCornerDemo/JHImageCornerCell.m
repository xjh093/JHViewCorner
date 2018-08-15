//
//  JHImageCornerCell.m
//  JHViewCornerDemo
//
//  Created by 薛精豪 on 2018/8/15.
//  Copyright © 2018年 HN. All rights reserved.
//

#import "JHImageCornerCell.h"
#import "UIView+JHViewCorner.h"

#define UIColorHexFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface JHImageCornerCell()
@property (nonatomic,  strong) UIImageView *image1;
@property (nonatomic,  strong) UIImageView *image2;
@property (nonatomic,  strong) UIImageView *image3;
@property (nonatomic,  strong) UIImageView *image4;
@end

@implementation JHImageCornerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *classStr = NSStringFromClass(self);
    NSString *ID = [NSString stringWithFormat:@"%@ID",classStr];
    JHImageCornerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self jhSetupViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    NSLog(@"setSelected:animated:");
    
    _image1.jh_highlightedMaskView.hidden = _image2.jh_highlightedMaskView.hidden = _image3.jh_highlightedMaskView.hidden = _image4.jh_highlightedMaskView.hidden = !selected;
}

- (void)setSelected:(BOOL)selected{
    NSLog(@"setSelected:");
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    NSLog(@"setHighlighted:animated:");
    
    _image1.jh_highlightedMaskView.hidden = _image2.jh_highlightedMaskView.hidden = _image3.jh_highlightedMaskView.hidden = _image4.jh_highlightedMaskView.hidden = !highlighted;
}

- (void)setHighlighted:(BOOL)highlighted{
    NSLog(@"setHighlighted:");
}

- (void)jhSetupViews{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _image1 = [self jhSetupImageView];
    _image2 = [self jhSetupImageView];
    _image3 = [self jhSetupImageView];
    _image4 = [self jhSetupImageView];
    
    CGFloat cellH = 60;
    CGFloat X = 15;
    CGFloat W = 45;
    CGFloat H = W;
    CGFloat Y = (cellH-H)*0.5;
    CGRect  frame = CGRectMake(X,Y,W,H);
    
    _image1.frame = frame;
    _image1.image = [UIImage imageNamed:@"head4"];

    X += W + 10;
    frame = CGRectMake(X,Y,W,H);
    _image2.frame = frame;
    _image2.image = [UIImage imageNamed:@"head4"];
    
    X += W + 10;
    frame = CGRectMake(X,Y,W,H);
    _image3.frame = frame;
    _image3.image = [UIImage imageNamed:@"head4"];
    
    X += W + 10;
    frame = CGRectMake(X,Y,W,H);
    _image4.frame = frame;
    _image4.image = [UIImage imageNamed:@"head4"];
    _image4.tag = 100;
    
    // 圆角
    [_image1 jh_setCornerRadius:H*0.5
                          color:self.contentView.backgroundColor
                     rectCorner:UIRectCornerAllCorners
               highlightedColor:UIColorHexFromRGB(0xd9d9d9)];
    
    // 圆角 + 边框
    [_image2 jh_setCornerRadius:H*0.5
                          color:self.contentView.backgroundColor
                     rectCorner:UIRectCornerAllCorners
                    borderColor:[UIColor redColor]
                    borderWidth:2
               highlightedColor:UIColorHexFromRGB(0xd9d9d9)];
    
    // 心形
    [_image3 jh_setHeartMask:self.contentView.backgroundColor
                 borderColor:nil
                 borderWidth:0
            highlightedColor:UIColorHexFromRGB(0xd9d9d9)];
    
    // 心形 + 边框
    [_image4 jh_setHeartMask:self.contentView.backgroundColor
                 borderColor:[UIColor redColor]
                 borderWidth:2
            highlightedColor:UIColorHexFromRGB(0xd9d9d9)];
}

- (UIImageView *)jhSetupImageView{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    return imageView;
}

@end
