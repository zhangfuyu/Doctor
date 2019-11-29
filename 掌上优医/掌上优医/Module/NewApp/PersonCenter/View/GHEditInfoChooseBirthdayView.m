//
//  GHEditInfoChooseBirthdayView.m
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHEditInfoChooseBirthdayView.h"
#import <NSDate+YYAdd.h>

@interface GHEditInfoChooseBirthdayView ()

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation GHEditInfoChooseBirthdayView

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = RGBACOLOR(51, 51, 51, 0.1);
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(206 - kBottomSafeSpace);
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = H16;
    [contentView addSubview:cancelButton];
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(60);
    }];
    [cancelButton addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    confirmButton.titleLabel.font = H16;
    [contentView addSubview:confirmButton];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(60);
    }];
    [confirmButton addTarget:self action:@selector(clickConfirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    picker.backgroundColor = [UIColor whiteColor];
    picker.datePickerMode = UIDatePickerModeDate;
    [contentView addSubview:picker];
    
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(45);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
    self.datePicker = picker;
    
    picker.minimumDate = [NSDate dateWithString:@"1920-01-01" format:@"yyyy-MM-dd"];
    picker.maximumDate = [[NSDate alloc] init];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor clearColor];
    [self addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(contentView.mas_top);
    }];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancelAction)];
    [topView addGestureRecognizer:tapGR];
    
}

- (void)clickCancelAction {
    
    self.hidden = true;
    
}

- (void)clickConfirmAction {
    
    self.hidden = true;
    
    if ([self.delegate respondsToSelector:@selector(finishEditBirthdayWithText:)]) {
        
        [self.delegate finishEditBirthdayWithText:[self.datePicker.date stringWithFormat:@"yyyy-MM-dd"]];
        
    }
    
}

@end
