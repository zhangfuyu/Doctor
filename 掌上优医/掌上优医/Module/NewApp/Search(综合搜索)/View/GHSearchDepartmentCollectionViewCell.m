//
//  GHSearchDepartmentCollectionViewCell.m
//  掌上优医
//
//  Created by GH on 2018/10/29.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHSearchDepartmentCollectionViewCell.h"

@interface GHSearchDepartmentCollectionViewCell ()



@end

@implementation GHSearchDepartmentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    iconImageView.layer.masksToBounds = true;
    [self.contentView addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(25);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(-8);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    self.iconImageView = iconImageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = HScaleFont(12);
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(iconImageView.mas_bottom);
    }];
    self.titleLabel = titleLabel;
}

@end
