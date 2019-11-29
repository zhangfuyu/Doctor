//
//  GHCommentTypeView.m
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHCommentTypeView.h"

@interface GHCommentTypeView ()

/**
 <#Description#>
 */
@property (nonatomic, strong) UIImageView *iconImageView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation GHCommentTypeView

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(45);
        make.left.mas_equalTo(24);
        make.top.mas_equalTo(0);
    }];
    self.iconImageView = iconImageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = HM17;
    
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImageView.mas_right).offset(18);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(0);
    }];
    self.titleLabel = titleLabel;
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = H13;
    descLabel.textColor = kDefaultBlackTextColor;
    
    [self addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(titleLabel);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
    }];
    self.descLabel = descLabel;
    
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    actionButton.backgroundColor = [UIColor clearColor];
    [self addSubview:actionButton];
    
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    self.actionButton = actionButton;
    
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.titleLabel.text = ISNIL(title);
    
}

- (void)setDesc:(NSString *)desc {
    
    _desc = desc;
    
    self.descLabel.text = ISNIL(desc);
    
}

- (void)setIconImage:(UIImage *)iconImage {
    
    _iconImage = iconImage;
    
    self.iconImageView.image = iconImage;
    
}

@end
