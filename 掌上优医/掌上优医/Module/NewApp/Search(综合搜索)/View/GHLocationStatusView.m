//
//  GHLocationStatusView.m
//  掌上优医
//
//  Created by GH on 2019/3/11.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHLocationStatusView.h"

@implementation GHLocationStatusView

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.image = [UIImage imageNamed:@"location_status"];
    [self addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(20);
        make.left.mas_equalTo(8);
        make.top.mas_equalTo(16);
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *openSetupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    openSetupButton.layer.cornerRadius = 2;
    openSetupButton.titleLabel.font = H13;
    openSetupButton.layer.borderColor = UIColorHex(0xFEAE05).CGColor;
    openSetupButton.layer.borderWidth = 1;
    [openSetupButton setTitleColor:UIColorHex(0xFEAE05) forState:UIControlStateNormal];
    [openSetupButton setTitle:@"立即开启" forState:UIControlStateNormal];
    [self addSubview:openSetupButton];
    
    [openSetupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(27);
        make.width.mas_equalTo(66);
        make.top.mas_equalTo(13);
        make.right.mas_equalTo(-14);
    }];
    [openSetupButton addTarget:self action:@selector(clickOpenSetupAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HM13;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.text = @"定位服务未开启";
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImageView.mas_right).offset(8);
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(8);
        make.right.mas_equalTo(-90);
    }];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = H11;
    descLabel.textColor = kDefaultGrayTextColor;
    descLabel.text = @"开启定位可获得更精准医生/医院推荐";
    [self addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImageView.mas_right).offset(8);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(3);
        make.right.mas_equalTo(-90);
    }];
    
}

- (void)clickOpenSetupAction {
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if (@available(iOS 10.0, *)) {
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
        
    } else {
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
        
    }
    
}

@end
