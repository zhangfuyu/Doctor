//
//  GHNewSubView.m
//  掌上优医
//
//  Created by apple on 2019/8/13.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewSubView.h"
@interface GHNewSubView()

@property (nonatomic , strong)UILabel *titleLabel;

@property (nonatomic , strong)UIImageView *leftImage;

@end

@implementation GHNewSubView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        
        [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftImage.mas_right).offset(5);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    self.titleLabel.text = titleText;
}




- (UIImageView *)leftImage
{
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc]init];
        _leftImage.image = [UIImage imageNamed:@"left_sub"];
        [self addSubview:_leftImage];
    }
    return _leftImage;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
@end
