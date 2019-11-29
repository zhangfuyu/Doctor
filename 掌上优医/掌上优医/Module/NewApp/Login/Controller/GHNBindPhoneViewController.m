//
//  GHNBindPhoneViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNBindPhoneViewController.h"
#import "GHNBindPhoneView.h"

#import <MSAuthSDK/MSAuthVCFactory.h>
#import <SecurityGuardSDK/JAQ/SecurityVerification.h>
#import <SecurityGuardSDK/Open/OpenSecurityGuardManager.h>
#import <SecurityGuardSDK/Open/OpenSecurityBody/IOpenSecurityBodyComponent.h>
#import <SecurityGuardSDK/Open/OpenSecurityBody/OpenSecurityBodyDefine.h>
#import <SecurityGuardSDK/Open/OpenSecurityBody/IOpenSecurityBodyComponent.h>

#import <SecurityGuardSDK/JAQ/SecuritySignature.h>


#import "GHNFullRecommendCodeViewController.h"

@interface GHNBindPhoneViewController ()<MSAuthProtocol, GHNBindPhoneViewDelegate>

/**
 <#Description#>
 */
@property (nonatomic, strong) GHNBindPhoneView *bindView;

/**
 安全验证的 VC, 需要在该界面 Dismiss 掉, 所以要指向他
 */
@property (nonatomic, strong) UIViewController *verifyVC;

@end

@implementation GHNBindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"绑定手机号";
 
    [self addLeftButton:@selector(clickBackAction) image:[UIImage imageNamed:@"login_back"]];
    
    [self setupUI];
}

- (void)setupUI {
    
    GHNBindPhoneView *bindView = [[GHNBindPhoneView alloc] init];
    bindView.delegate = self;
    [self.view addSubview:bindView];
    
    [bindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.bindView = bindView;
    
}

- (void)clickBackAction {
    
    [self dismissViewControllerAnimated:false completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    ((UILabel *)self.navigationItem.titleView).textColor = UIColorHex(0x333333);
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//
//    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}

- (void)bindPhoneViewClickGetVerifyAction {
    
    if (self.bindView.phoneTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的手机号"];
        return;
    }
    
    if (![self.bindView.phoneTextField.text isMobileNumber]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = ISNIL(self.bindView.phoneTextField.text);
    //            params[@"sessionSig"] = sessionId;
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiSmsCode withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [self.bindView changeVerifyButtonState];
            
            [self.bindView.verifyTextField becomeFirstResponder];
            
        }
        
    }];
    return;
    
    // 请求验证码之前需要先进行阿里聚安全风险验证
    UIViewController *vc = [MSAuthVCFactory simapleVerifyWithType:MSAuthTypeSlide language:@"zh_CN" Delegate:self authCode:@"0335" appKey:nil];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Height_StatusBar, 44, 55)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickVerifyDismissAction) forControlEvents:UIControlEventTouchUpInside];
    
    [vc.view addSubview:backBtn];
    
    if (vc) {
        [self presentViewController:vc animated:true completion:nil];
        self.verifyVC = vc;
    }
    
}

- (void)clickVerifyDismissAction {
    
    [self.verifyVC dismissViewControllerAnimated:true completion:nil];
    
}

- (void)verifyDidFinishedWithResult:(t_verify_reuslt)code Error:(NSError *)error SessionId:(NSString *)sessionId {
    
    [self clickVerifyDismissAction];
    
    if (code == 0) {
        
        if (sessionId.length > 0) {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"phone"] = ISNIL(self.bindView.phoneTextField.text);
//            params[@"sessionSig"] = sessionId;
            
            [SVProgressHUD showWithStatus:kDefaultTipsText];
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiSmsCode withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                if (isSuccess) {
                    
                    [self.bindView changeVerifyButtonState];
                    
                    [self.bindView.verifyTextField becomeFirstResponder];
                    
                }
                
            }];
            
        }
        
        
        
    } else {
        
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSString* msg = [NSString stringWithFormat:@"Authentication passed! Session id: %@", sessionId];
            NSLog(@"%@",msg);
        }
        
    }
    
}

- (void)bindPhoneViewClickLoginAction {
    
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
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = ISNIL(self.bindView.phoneTextField.text);
    params[@"verificationCode"] = ISNIL(self.bindView.verifyTextField.text);
    
    [SVProgressHUD showWithStatus:kDefaultLoginTipsText];
    
    [GHUserModelTool shareInstance].token = self.token;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiSessionPhone withParameter:params withLoadingType:GHLoadingType_ShowLoading  withShouldHaveToken:NO withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            NSString *token = response[@"data"];
            
            [GHUserModelTool shareInstance].account = ISNIL(self.bindView.phoneTextField.text);
            
            [GHUserModelTool shareInstance].token = ISNIL(token);
            
            [GHUserModelTool shareInstance].isLogin = YES;
            
            [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
            

            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiUserNickname withParameter:@{@"wxOpenId":self.weixinID} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                
                [SVProgressHUD dismiss];
                if (isSuccess) {
                    [SVProgressHUD showSuccessWithStatus:@"恭喜您,登录成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
                    });
                    
                    [self.navigationController.presentingViewController.presentingViewController dismissViewControllerAnimated:false completion:nil];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:@"绑定失败"];
                }
                
            }];
            
            
            
           
            return;
            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiUserInviter withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
//                    
//                    if (isSuccess) {
//                        
//                        if (((NSString *)response).length == 0) {
//                            GHNFullRecommendCodeViewController *vc = [[GHNFullRecommendCodeViewController alloc] init];
//                            vc.type = GHNFullRecommendCodeViewController_BindPhone;
//                            [self.navigationController pushViewController:vc animated:true];
//                        } else {
//                        }
//                        
//                    }
//                    
//                }];
//                
//            });
            

//            [self.navigationController.presentingViewController.presentingViewController dismissViewControllerAnimated:false completion:nil];
            
        } else {
            
            [GHUserModelTool shareInstance].token = nil;
            
        }
        
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
