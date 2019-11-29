//
//  GHDoctorMorePopView.m
//  掌上优医
//
//  Created by GH on 2018/11/17.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHDoctorMorePopView.h"



@interface GHDoctorMorePopView ()


@end

@implementation GHDoctorMorePopView

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = RGBACOLOR(51, 51, 51, 0);
    
    UIButton *tapView = [UIButton buttonWithType:UIButtonTypeCustom];
    tapView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
    [tapView addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tapView];
    
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.contentMode = UIViewContentModeScaleToFill;
    bgImageView.userInteractionEnabled = true;
    bgImageView.image = [UIImage imageNamed:@"doctorMoreBg"];
    [self addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(141);
        make.height.mas_equalTo(103);
    }];
    
    UIView *popView = [[UIView alloc] init];
    popView.backgroundColor = [UIColor whiteColor];
    [bgImageView addSubview:popView];
    
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(121);
        make.height.mas_equalTo(90);
        make.centerX.mas_equalTo(bgImageView);
        make.top.mas_equalTo(13);
    }];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOtherAction)];
    [popView addGestureRecognizer:tapGR];
    
    
    NSArray *titleArray = @[@"分享", @"信息报错"];
    NSArray *imageNameArray = @[@"ic_yishengjieshao_fenxiang_presed", @"ic_yishengjieshao_baocuo_presed"];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.image = [UIImage imageNamed:ISNIL([imageNameArray objectOrNilAtIndex:index])];
        [popView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(22);
            make.left.mas_equalTo(8);
            make.top.mas_equalTo(41 * index + 9.5);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = H15;
        titleLabel.textColor = kDefaultBlackTextColor;
        titleLabel.text = ISNIL([titleArray objectOrNilAtIndex:index]);
        [popView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).offset(8);
            make.top.bottom.mas_equalTo(imageView);
            make.right.mas_equalTo(-8);
        }];
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        [popView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.mas_equalTo(2);
            make.right.mas_equalTo(-2);
            make.top.mas_equalTo(41 * (index + 1));
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        [popView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(41);
            make.top.mas_equalTo(41 * index);
        }];
        
        if (index == 0) {
            self.shareButton = button;
        } else if (index == 1) {
            self.errorButton = button;
        }
        
    }
    
}

- (void)clickOtherAction {
    
}

- (void)clickCancelAction {
    
    self.hidden = true;
    
}

@end
