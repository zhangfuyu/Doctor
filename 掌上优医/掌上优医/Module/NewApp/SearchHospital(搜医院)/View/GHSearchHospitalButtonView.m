//
//  GHSearchHospitalButtonView.m
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHSearchHospitalButtonView.h"

@interface GHSearchHospitalButtonView ()

/**
 <#Description#>
 */
@property (nonatomic, strong) UIImageView *imageView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GHSearchHospitalButtonView

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(HScaleHeight(34));
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
    }];
    self.imageView = imageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HScaleFont(13);
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom).offset(HScaleHeight(9));
        make.height.mas_equalTo(HScaleHeight(13));
    }];
    self.titleLabel = titleLabel;
    
    imageView.backgroundColor = [UIColor whiteColor];
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:actionButton];
    
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.actionButton = actionButton;
    
}

- (void)setModel:(GHHospitalSpecialDepartmentModel *)model {
    
    _model = model;
    
    self.titleLabel.text = ISNIL(model.name);
    
//    [self.imageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.iconUrl))];
    
    self.imageView.image = [UIImage imageNamed:model.iconUrl];
    
}

@end
