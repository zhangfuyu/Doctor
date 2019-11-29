//
//  GHChooseCommentTypeView.m
//  掌上优医
//
//  Created by GH on 2019/5/10.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHChooseCommentTypeView.h"
#import "GHCommentTypeView.h"

#import "GHCommentDoctorChooseRecordViewController.h"
#import "GHCommentHospitalChooseRecordViewController.h"

#import "GHTabBarControllerController.h"
#import "GHNavigationViewController.h"

@implementation GHChooseCommentTypeView

+ (instancetype)shareInstance {
    
    static GHChooseCommentTypeView *_view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _view = [[GHChooseCommentTypeView alloc] init];
    });
    return _view;
    
}

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
 
    self.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3;
    
    [self addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCloseAction)];
    [bgView addGestureRecognizer:tapGR];
    
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.mas_equalTo(0);
        
        make.height.mas_equalTo(281 - kBottomSafeSpace);
        
    }];
    
    UITapGestureRecognizer *tapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneAction)];
    [contentView addGestureRecognizer:tapGR2];
 
    
    GHCommentTypeView *hospitalView = [[GHCommentTypeView alloc] init];
    hospitalView.title = @"评价医院";
    hospitalView.desc = @"说说医院给你的整体感受";
    hospitalView.iconImage = [UIImage imageNamed:@"btn_dianping_pingjiayiyuan"];
    [contentView addSubview:hospitalView];
    
    [hospitalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(44);
        make.height.mas_equalTo(45);
    }];
    [hospitalView.actionButton addTarget:self action:@selector(clickCommentHospitalAction) forControlEvents:UIControlEventTouchUpInside];
    
    GHCommentTypeView *doctorView = [[GHCommentTypeView alloc] init];
    doctorView.title = @"评价医生";
    doctorView.desc = @"评价医生对你的质量效果";
    doctorView.iconImage = [UIImage imageNamed:@"btn_diangping_pingjiayisheng"];
    [contentView addSubview:doctorView];
    
    [doctorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(hospitalView.mas_bottom).offset(55);
        make.height.mas_equalTo(45);
    }];
    [doctorView.actionButton addTarget:self action:@selector(clickCommentDoctorAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"ic_pingjia_close"] forState:UIControlStateNormal];
    
    [contentView addSubview:closeButton];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(73);
        make.top.mas_equalTo(doctorView.mas_bottom).offset(19);
    }];
    [closeButton addTarget:self action:@selector(clickCloseAction) forControlEvents:UIControlEventTouchUpInside];
    
    closeButton.backgroundColor = [UIColor whiteColor];
    
}

- (void)clickCommentHospitalAction {
    NSLog(@"评价医院");
    
    [self clickCloseAction];
    
    GHCommentHospitalChooseRecordViewController *vc = [[GHCommentHospitalChooseRecordViewController alloc] init];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    GHTabBarControllerController *tabbarVC = (GHTabBarControllerController *)window.rootViewController;
    GHNavigationViewController *nav = [tabbarVC.viewControllers objectOrNilAtIndex:tabbarVC.selectedIndex];
    
    [nav pushViewController:vc animated:true];
    
}

- (void)clickCommentDoctorAction {
    NSLog(@"评价医生");
    
    [self clickCloseAction];
    
    GHCommentDoctorChooseRecordViewController *vc = [[GHCommentDoctorChooseRecordViewController alloc] init];

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    GHTabBarControllerController *tabbarVC = (GHTabBarControllerController *)window.rootViewController;
    GHNavigationViewController *nav = [tabbarVC.viewControllers objectOrNilAtIndex:tabbarVC.selectedIndex];
    
    [nav pushViewController:vc animated:true];
    
}

- (void)clickNoneAction {
    
}

- (void)clickCloseAction {
    
    [self removeFromSuperview];
    
}

@end
