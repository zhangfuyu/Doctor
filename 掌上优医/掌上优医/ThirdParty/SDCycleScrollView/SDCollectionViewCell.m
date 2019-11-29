//
//  SDCollectionViewCell.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//


/*
 
 *********************************************************************************
 *
 * 🌟🌟🌟 新建SDCycleScrollView交流QQ群：185534916 🌟🌟🌟
 *
 * 在您使用此自动轮播库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并
 * 帮您解决问题。
 * 新浪微博:GSD_iOS
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios
 *
 * 另（我的自动布局库SDAutoLayout）：
 *  一行代码搞定自动布局！支持Cell和Tableview高度自适应，Label和ScrollView内容自适应，致力于
 *  做最简单易用的AutoLayout库。
 * 视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * 用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 * GitHub：https://github.com/gsdios/SDAutoLayout
 *********************************************************************************
 
 */


#import "SDCollectionViewCell.h"
#import "UIView+SDExtension.h"

@implementation SDCollectionViewCell
{
    __weak UILabel *_titleLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupBgView];
        [self setupImageView];
        [self setupTitleLabel];
        [self setupSignButton];
    }
    
    return self;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    if (self.isCornerRadius) {
        imageView.layer.cornerRadius = HScaleHeight(5);

    }
    imageView.layer.masksToBounds = YES;
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)setupBgView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColorHex(0xEEEEEE);
    _bgView = view;
    if (self.isCornerRadius) {
        view.layer.cornerRadius = HScaleHeight(5);
    }
    [self.contentView addSubview:view];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    [self.contentView addSubview:titleLabel];
}

- (void)setupSignButton {
    
    UIButton *signButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _signButton = signButton;
    _signButton.hidden = YES;
    [self.contentView addSubview:signButton];
    
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
    if (_titleLabel.hidden) {
        _titleLabel.hidden = NO;
    }
}

-(void)setTitleLabelTextAlignment:(NSTextAlignment)titleLabelTextAlignment
{
    _titleLabelTextAlignment = titleLabelTextAlignment;
    _titleLabel.textAlignment = titleLabelTextAlignment;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.onlyDisplayText) {
        _titleLabel.frame = self.bounds;
    } else {
        
        if (self.imageSize.height > 0) {
            
            _bgView.frame = self.bounds;
            _imageView.frame = CGRectMake((self.bounds.size.width - self.imageSize.width) / 2.f, (self.bounds.size.height - self.imageSize.height) / 2.f, self.imageSize.width, self.imageSize.height);
            
            _imageView.layer.masksToBounds = true;
            CGFloat titleLabelW = self.sd_width;
            CGFloat titleLabelH = _titleLabelHeight;
            CGFloat titleLabelX = 0;
            CGFloat titleLabelY = self.sd_height - titleLabelH;
            _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
            
            _bgView.backgroundColor = [UIColor whiteColor];
            
            if (self.imageSize.height == HScaleHeight(160)) {
                _imageView.layer.cornerRadius = HScaleHeight(5);
            }
            
        } else {
            
            _imageView.frame = self.bounds;
            CGFloat titleLabelW = self.sd_width;
            CGFloat titleLabelH = _titleLabelHeight;
            CGFloat titleLabelX = 0;
            CGFloat titleLabelY = self.sd_height - titleLabelH;
            _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
            
        }
 
    }

    if (self.signImage) {
        self.signButton.hidden = false;
        
        
        self.signButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        self.signButton.titleLabel.font = H14;
        
        [self.signButton setImage:self.signImage forState:UIControlStateNormal];
        [self.signButton setTitle:[NSString stringWithFormat:@" %ld", self.imageCount] forState:UIControlStateNormal];
        
        self.signButton.layer.cornerRadius = 12.5;
        self.signButton.layer.masksToBounds = true;
        
        self.signButton.width = 50;
        self.signButton.height = 25;
        self.signButton.mj_y = MaxY(self.imageView) - 25 - 8;
        self.signButton.mj_x = MaxX(self.imageView) - 50 - 8;
        
    } else {
        self.signButton.hidden = true;
    }

}

@end
