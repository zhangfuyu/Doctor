//
//  GHNLoginView.m
//  掌上优医
//
//  Created by GH on 2019/2/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNLoginView.h"
#import "UIButton+touch.h"
#import "GHNavigationViewController.h"
#import "WXApi.h"

@interface GHNLoginView ()

@property (nonatomic, assign) NSInteger countDown;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation GHNLoginView

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"img_entry page_logo"];
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(HScaleHeight(80));
        make.left.mas_equalTo(SCREENWIDTH / 2.f - HScaleHeight(40));
        make.top.mas_equalTo(Height_StatusBar + HScaleHeight(42));
    }];
    
    
    UIView *tipsView = [[UIView alloc] init];
    tipsView.backgroundColor = [UIColor whiteColor];
    tipsView.layer.cornerRadius = 13;
    tipsView.layer.shadowColor = kDefaultBlackTextColor.CGColor;
    tipsView.layer.shadowOffset = CGSizeMake(0,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    tipsView.layer.shadowOpacity = 0.2;//阴影透明度，默认0
    tipsView.layer.shadowRadius = 5;//阴影半径，默认3
    [self addSubview:tipsView];
    
    [tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
        make.right.mas_equalTo(-26);
        make.bottom.mas_equalTo(-24);
        make.height.mas_equalTo(70);
    }];
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.font = HScaleFont(13);
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.textColor = UIColorHex(0x9B9B9B);
    tipsLabel.text = @"未注册大众星医的用户，初次登录时将完成注册";
    [tipsView addSubview:tipsLabel];
    
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(19);
        make.bottom.mas_equalTo(-15);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 13;
    contentView.layer.shadowColor = kDefaultBlackTextColor.CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,8);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    contentView.layer.shadowOpacity = 0.2;//阴影透明度，默认0
    contentView.layer.shadowRadius = 5;//阴影半径，默认3
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(imageView.mas_bottom).offset(HScaleHeight(35));
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
        make.top.mas_equalTo(HScaleHeight(28));
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
    phoneTextField.leftSpace = HScaleHeight(29);
    phoneTextField.rightSpace = HScaleHeight(29);
    [contentView addSubview:phoneTextField];
    
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(-34);
        make.height.mas_equalTo(HScaleHeight(50));
        make.top.mas_equalTo(phoneTitleLabel.mas_bottom);
    }];
    self.phoneTextField = phoneTextField;
    
    
    
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
    
    UIButton *protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
    protocolButton.titleLabel.font = H12;
    [protocolButton setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
    [protocolButton setTitle:@"我已阅读并同意用户服务协议" forState:UIControlStateNormal];
    [contentView addSubview:protocolButton];
    
    [protocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(HScaleHeight(42));
        make.top.mas_equalTo(verifyCodeTextField.mas_bottom).offset(8);
        make.width.mas_equalTo([protocolButton.currentTitle widthForFont:H12] + 2);
        make.centerX.mas_equalTo(contentView).offset(15);
    }];
    [protocolButton addTarget:self action:@selector(clickProtocolAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreeButton setImage:[UIImage imageNamed:@"login_agree_unselected"] forState:UIControlStateNormal];
    [agreeButton setImage:[UIImage imageNamed:@"login_agree_selected"] forState:UIControlStateSelected];
    agreeButton.selected = true;
    agreeButton.isIgnore = true;
    [contentView addSubview:agreeButton];
    
    [agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.centerY.mas_equalTo(protocolButton);
        make.right.mas_equalTo(protocolButton.mas_left);
    }];
    [agreeButton addTarget:self action:@selector(clickAgreeAction:) forControlEvents:UIControlEventTouchUpInside];
    self.agreeButton = agreeButton;
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = kDefaultBlueColor;
    loginButton.titleLabel.font = H18;
    loginButton.layer.cornerRadius = HScaleHeight(25);
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentView addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.right.mas_equalTo(-34);
        make.height.mas_equalTo(HScaleHeight(50));
        make.top.mas_equalTo(protocolButton.mas_bottom);
    }];
    [loginButton addTarget:self action:@selector(clickLoginAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *wechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [wechatButton setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
    [contentView addSubview:wechatButton];
    
    [wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(HScaleHeight(50));
        make.centerX.mas_equalTo(contentView);
        make.top.mas_equalTo(loginButton.mas_bottom).offset(HScaleHeight(20));
    }];
    [wechatButton addTarget:self action:@selector(clickWechatAction) forControlEvents:UIControlEventTouchUpInside];
    
    wechatButton.hidden = ![WXApi isWXAppInstalled];
    
    
    if (kiPhone5) {
        [wechatButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(loginButton.mas_bottom).offset(HScaleHeight(10));
        }];
    }
    
    if (kiPhone4 || iPad) {
        [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
        }];
        
        [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageView.mas_bottom).offset(10);
        }];
        
        [phoneTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
        }];
        
        [verifyCodeTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(phoneTextField.mas_bottom).offset(0);
        }];
        
        [protocolButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(verifyCodeTextField.mas_bottom);
        }];
        
        [wechatButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(loginButton.mas_bottom).offset(5);
        }];
        
    }
    
    
}

- (void)clickGetVerifyAction {
    
    if ([self.delegate respondsToSelector:@selector(loginViewClickGetVerifyAction)]) {
        [self.delegate loginViewClickGetVerifyAction];
    }
    
}

- (void)clickWechatAction {
    
    if ([self.delegate respondsToSelector:@selector(loginViewClickWeChatAction)]) {
        [self.delegate loginViewClickWeChatAction];
    }
    
}

- (void)clickLoginAction {
    
    if ([self.delegate respondsToSelector:@selector(loginViewClickLoginAction)]) {
        [self.delegate loginViewClickLoginAction];
    }
    
}

- (void)clickAgreeAction:(UIButton *)sender {
    
    self.agreeButton.selected = !self.agreeButton.selected;
    
}

- (void)clickProtocolAction {
    
    GHCommonWebViewController *vc = [[GHCommonWebViewController alloc] init];
    vc.navTitle = @"大众星医用户协议";
    vc.urlStr = [[GHNetworkTool shareInstance] getUserProtocolURL];
    
    GHNavigationViewController *nav = [[GHNavigationViewController alloc] initWithRootViewController:vc];
    
    [self.viewController presentViewController:nav animated:true completion:nil];
    
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
