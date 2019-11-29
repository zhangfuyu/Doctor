//
//  GHNBindPhoneView.m
//  掌上优医
//
//  Created by GH on 2019/2/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNBindPhoneView.h"

@interface GHNBindPhoneView ()

@property (nonatomic, assign) NSInteger countDown;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation GHNBindPhoneView

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-80);
    }];
    
    UILabel *phoneTitleLabel = [[UILabel alloc] init];
    phoneTitleLabel.font = H15;
    phoneTitleLabel.textColor = kDefaultGrayTextColor;
    phoneTitleLabel.text = @"手机号";
    [contentView addSubview:phoneTitleLabel];
    
    [phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(-34);
        make.height.mas_equalTo(HScaleHeight(37));
        make.top.mas_equalTo(HScaleHeight(38));
    }];
    
    GHTextField *phoneTextField = [[GHTextField alloc] init];
    phoneTextField.font = HScaleFont(15);
    phoneTextField.textColor = kDefaultBlackTextColor;
    phoneTextField.placeholder = @"请输入手机号";
    phoneTextField.backgroundColor = UIColorHex(0xF5F5F5);
    phoneTextField.layer.cornerRadius = HScaleHeight(25);
    phoneTextField.layer.masksToBounds = true;
    phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    phoneTextField.returnKeyType = UIReturnKeyDone;
    phoneTextField.maxInputDigit = 11;
    phoneTextField.endEditingDigit = 11;
    phoneTextField.rightSpace = HScaleHeight(29);
    [contentView addSubview:phoneTextField];
    
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(-34);
        make.height.mas_equalTo(HScaleHeight(50));
        make.top.mas_equalTo(phoneTitleLabel.mas_bottom);
    }];
    self.phoneTextField = phoneTextField;
    
    
    UIView *phoneLeftView = [[UIView alloc] init];
    phoneLeftView.backgroundColor = UIColorHex(0xF5F5F5);
    phoneLeftView.frame = CGRectMake(0, 0, HScaleHeight(86) ,HScaleHeight(50));
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = UIColorHex(0xCCCCCC);
    [phoneLeftView addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleHeight(70));
        make.top.mas_equalTo(8);
        make.bottom.mas_equalTo(-8);
        make.width.mas_equalTo(1);
    }];
    
    UILabel *phoneAreaCodeLabel = [[UILabel alloc] init];
    phoneAreaCodeLabel.textAlignment = NSTextAlignmentCenter;
    phoneAreaCodeLabel.text = @"+86";
    phoneAreaCodeLabel.font = HScaleFont(15);
    phoneAreaCodeLabel.textColor = UIColorHex(0x262628);
    [phoneLeftView addSubview:phoneAreaCodeLabel];
    
    [phoneAreaCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    phoneTextField.leftView = phoneLeftView;
    phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UILabel *verifyCodeTitleLabel = [[UILabel alloc] init];
    verifyCodeTitleLabel.font = H15;
    verifyCodeTitleLabel.textColor = kDefaultGrayTextColor;
    verifyCodeTitleLabel.text = @"验证码";
    [contentView addSubview:verifyCodeTitleLabel];
    
    [verifyCodeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(-34);
        make.height.mas_equalTo(HScaleHeight(37));
        make.top.mas_equalTo(phoneTextField.mas_bottom).offset(12);
    }];
    
    GHTextField *verifyCodeTextField = [[GHTextField alloc] init];
    verifyCodeTextField.font = HScaleFont(15);
    verifyCodeTextField.textColor = kDefaultBlackTextColor;
    verifyCodeTextField.placeholder = @"请输入手机验证码";
    verifyCodeTextField.backgroundColor = UIColorHex(0xF5F5F5);
    verifyCodeTextField.layer.cornerRadius = HScaleHeight(25);
    verifyCodeTextField.layer.masksToBounds = true;
    verifyCodeTextField.keyboardType = UIKeyboardTypePhonePad;
    verifyCodeTextField.returnKeyType = UIReturnKeyDone;
    verifyCodeTextField.maxInputDigit = 6;
    verifyCodeTextField.endEditingDigit = 6;
    verifyCodeTextField.leftSpace = HScaleHeight(29);
    [contentView addSubview:verifyCodeTextField];
    
    [verifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(-34);
        make.height.mas_equalTo(HScaleHeight(50));
        make.top.mas_equalTo(verifyCodeTitleLabel.mas_bottom);
    }];
    self.verifyTextField = verifyCodeTextField;
    
    UIView *verifyRightView = [[UIView alloc] init];
    verifyRightView.backgroundColor = UIColorHex(0xF5F5F5);
    verifyRightView.frame = CGRectMake(0, 0, HScaleHeight(110) ,HScaleHeight(50));
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = UIColorHex(0xCCCCCC);
    [verifyRightView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(8);
        make.bottom.mas_equalTo(-8);
        make.width.mas_equalTo(1);
    }];
    
    UIButton *verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    verifyButton.titleLabel.font = HScaleFont(15);
    [verifyButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verifyRightView addSubview:verifyButton];
    
    [verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.left.mas_equalTo(1);
    }];
    [verifyButton addTarget:self action:@selector(clickGetVerifyAction) forControlEvents:UIControlEventTouchUpInside];
    self.getVerifyCodeButton = verifyButton;
    
    verifyCodeTextField.rightView = verifyRightView;
    verifyCodeTextField.rightViewMode = UITextFieldViewModeAlways;
    
   
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = kDefaultBlueColor;
    loginButton.titleLabel.font = H18;
    loginButton.layer.cornerRadius = HScaleHeight(25);
    [loginButton setTitle:@"绑 定" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentView addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(-34);
        make.height.mas_equalTo(HScaleHeight(50));
        make.top.mas_equalTo(verifyCodeTextField.mas_bottom).offset(47);
    }];
    [loginButton addTarget:self action:@selector(clickLoginAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickGetVerifyAction {
    
    if ([self.delegate respondsToSelector:@selector(bindPhoneViewClickGetVerifyAction)]) {
        [self.delegate bindPhoneViewClickGetVerifyAction];
    }
    
}

- (void)clickLoginAction {
    
    if ([self.delegate respondsToSelector:@selector(bindPhoneViewClickLoginAction)]) {
        [self.delegate bindPhoneViewClickLoginAction];
    }
    
}

- (void)changeVerifyButtonState {
    
    self.countDown = 60;
    
    self.getVerifyCodeButton.enabled = false;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerCountDown) userInfo:nil repeats:true];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)timerCountDown {
    
    if (self.countDown <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self.getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getVerifyCodeButton.enabled = true;
        [self.getVerifyCodeButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    } else {
        [self.getVerifyCodeButton setTitle:[NSString stringWithFormat:@"重新发送(%ld)", self.countDown] forState:UIControlStateNormal];
        [self.getVerifyCodeButton setTitleColor:UIColorHex(0xCCCCCC) forState:UIControlStateNormal];
    }
    
    self.countDown --;
    
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end
