//
//  GHChooseHospitalAuthenticationTimeView.m
//  掌上优医
//
//  Created by GH on 2019/6/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHChooseHospitalAuthenticationTimeView.h"
#import <NSDate+YYAdd.h>

@interface GHChooseHospitalAuthenticationTimeView ()

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation GHChooseHospitalAuthenticationTimeView

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = RGBACOLOR(51, 51, 51, 0.1);
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.cornerRadius = 4;
    bottomView.layer.masksToBounds = true;
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(10);
        make.height.mas_equalTo((220 - kBottomSafeSpace));
    }];
    
    UIButton *contentView = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addTarget:self action:@selector(clickNoneAction) forControlEvents:UIControlEventTouchUpInside];
    contentView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.titleLabel.font = H16;
    [cancelButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [bottomView addSubview:cancelButton];
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(56);
        make.width.mas_equalTo(83);
    }];
    [cancelButton addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.titleLabel.font = H16;
    [confirmButton setTitleColor: kDefaultBlueColor forState:UIControlStateNormal];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [bottomView addSubview:confirmButton];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.height.mas_equalTo(56);
        make.width.mas_equalTo(83);
    }];
    
    [confirmButton addTarget:self action:@selector(clickConfirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [bottomView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6);
        make.right.mas_equalTo(-6);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(56);
    }];
    
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HB18;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"有效期";
    [bottomView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cancelButton.mas_right);
        make.right.mas_equalTo(confirmButton.mas_left);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(56);
    }];
    
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    picker.backgroundColor = [UIColor whiteColor];
    picker.datePickerMode = UIDatePickerModeDate;
    [contentView addSubview:picker];
    
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(60);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
    self.datePicker = picker;
    
    picker.minimumDate = [[NSDate alloc] init];
    picker.maximumDate = [NSDate dateWithString:@"2050-01-01" format:@"yyyy-MM-dd"];
    
    
    UIButton *tapView = [UIButton buttonWithType:UIButtonTypeCustom];
    tapView.backgroundColor = [UIColor clearColor];
    [tapView addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tapView];
    
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomView.mas_top);
    }];
    
}

- (void)clickConfirmAction {
    
    self.hidden = true;
    
    if ([self.delegate respondsToSelector:@selector(chooseFinishWithHospitalAuthenticationTime:)]) {
        
        [self.delegate chooseFinishWithHospitalAuthenticationTime:[self.datePicker.date stringWithFormat:@"yyyy年MM月dd日"]];

    }
    
}

/**
 只是为了不做任何响应
 */
- (void)clickNoneAction {
    
}

- (void)clickCancelAction {
    
    self.hidden = true;
    
}



@end
