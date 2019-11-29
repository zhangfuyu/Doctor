//
//  GHNChangePasswordViewController.m
//  掌上优医
//
//  Created by GH on 2019/3/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNChangePasswordViewController.h"
#import "GHNChangePasswordView.h"

@interface GHNChangePasswordViewController ()<GHNChangePasswordViewDelegate>

/**
 <#Description#>
 */
@property (nonatomic, strong) GHNChangePasswordView *bindView;

@end

@implementation GHNChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"修改密码";
    
    [self setupUI];
}

- (void)setupUI {
    
    GHNChangePasswordView *bindView = [[GHNChangePasswordView alloc] init];
    bindView.delegate = self;
    [self.view addSubview:bindView];
    
    [bindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.bindView = bindView;
    
}

- (void)changePasswordViewClickGetVerifyAction {
    
    if (self.bindView.phoneTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的手机号"];
        return;
    }
    
    if (![self.bindView.phoneTextField.text isMobileNumber]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phoneNum"] = ISNIL(self.bindView.phoneTextField.text);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiSmsCode withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            

            
        }
        
    }];
    
    [self.bindView changeVerifyButtonState];
    
    [self.bindView.verifyTextField becomeFirstResponder];
    
}

- (void)changePasswordViewClickLoginAction {
    
    
    if (self.bindView.phoneTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的手机号"];
        return;
    }
    
    if (![self.bindView.phoneTextField.text isMobileNumber]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    if (self.bindView.verifyTextField.text.length != 6) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的验证码"];
        return;
    }
    
    if (self.bindView.passwordTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的新密码"];
        return;
    }
    
    [SVProgressHUD showErrorWithStatus:@"请输入正确的验证码"];
    return;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phoneNum"] = ISNIL(self.bindView.phoneTextField.text);
    params[@"authCode"] = ISNIL(self.bindView.verifyTextField.text);
    
    [SVProgressHUD showWithStatus:kDefaultLoginTipsText];
    
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_PUT withUrl:kApiUserPhone withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            if (((NSString *)response[@"token"]).length) {
                [GHUserModelTool shareInstance].token = response[@"token"];
            }
            
            [GHUserModelTool shareInstance].account = ISNIL(self.bindView.phoneTextField.text);
            
            [GHUserModelTool shareInstance].isLogin = true;
            
            [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
            
            [SVProgressHUD showSuccessWithStatus:@"恭喜您,修改成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiUserInviter withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                    
                    if (isSuccess) {
                        
                        if (((NSString *)response).length == 0) {
//                            GHNFullRecommendCodeViewController *vc = [[GHNFullRecommendCodeViewController alloc] init];
//                            vc.type = GHNFullRecommendCodeViewController_BindPhone;
//                            [self.navigationController pushViewController:vc animated:true];
                        } else {
                            [self.navigationController.presentingViewController.presentingViewController dismissViewControllerAnimated:false completion:nil];
                        }
                        
                    }
                    
                }];
                
            });
            
            
            //            [self.navigationController.presentingViewController.presentingViewController dismissViewControllerAnimated:false completion:nil];
            
        } else {
            
            [GHUserModelTool shareInstance].token = nil;
            
        }
        
    }];
    
}

@end
