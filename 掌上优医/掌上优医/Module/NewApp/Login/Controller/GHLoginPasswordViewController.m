//
//  GHLoginViewController.m
//  掌上优医
//
//  Created by GH on 2018/10/24.
//  Copyright © 2018 GH. All rights reserved.
//
//  账号密码登录

#import "GHLoginPasswordViewController.h"
#import "GHNLoginPasswordView.h"

#import "UIButton+touch.h"

@interface GHLoginPasswordViewController ()<GHNLoginPasswordViewDelegate>

/**
 <#Description#>
 */
@property (nonatomic, strong) GHNLoginPasswordView *loginView;

@end

@implementation GHLoginPasswordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    
    GHNLoginPasswordView *loginView = [[GHNLoginPasswordView alloc] init];
    loginView.delegate = self;
    [self.view addSubview:loginView];
    
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.loginView = loginView;
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    [self.view addSubview:closeButton];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(44);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(Height_StatusBar + 0);
    }];
    [closeButton addTarget:self action:@selector(clickCloseAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)loginPasswordViewClickLoginAction {
    
    NSLog(@"用户名登录");
    
    if (self.loginView.phoneTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的手机号"];
        return;
    }
    
    if (self.loginView.verifyTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的密码"];
        return;
    }
    
    if (self.loginView.agreeButton.isSelected == false) {
        [SVProgressHUD showErrorWithStatus:@"请同意用户服务协议"];
        return;
    }
    
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = ISNIL(self.loginView.phoneTextField.text);
    params[@"verificationCode"] = ISNIL(self.loginView.verifyTextField.text);
    
    [SVProgressHUD showWithStatus:kDefaultLoginTipsText];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiSessionPhone withParameter:params withLoadingType:GHLoadingType_ShowLoading  withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            NSString *token = response[@"data"];
            
            [GHUserModelTool shareInstance].account = ISNIL(self.loginView.phoneTextField.text);
            
            [GHUserModelTool shareInstance].token = ISNIL(token);
            
            [GHUserModelTool shareInstance].isLogin = YES;
            
            [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
            
            [SVProgressHUD showSuccessWithStatus:@"恭喜您,登录成功"];
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
            
            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:true completion:nil];
            
        }
        
    }];
    
    
}

- (void)clickPhoneLoginAction:(UIButton *)sender {
    
  
}


- (void)clickCloseAction {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}


@end
