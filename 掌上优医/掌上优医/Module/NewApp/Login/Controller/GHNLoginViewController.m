//
//  GHNLoginViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNLoginViewController.h"

#import "UIButton+touch.h"
#import "WXApi.h"

#import "GHWXTool.h"
#import "GHLoginPasswordViewController.h"
#import "GHNavigationViewController.h"
#import "GHNBindPhoneViewController.h"

#import <MSAuthSDK/MSAuthVCFactory.h>
#import <SecurityGuardSDK/JAQ/SecurityVerification.h>
#import <SecurityGuardSDK/Open/OpenSecurityGuardManager.h>
#import <SecurityGuardSDK/Open/OpenSecurityBody/IOpenSecurityBodyComponent.h>
#import <SecurityGuardSDK/Open/OpenSecurityBody/OpenSecurityBodyDefine.h>
#import <SecurityGuardSDK/Open/OpenSecurityBody/IOpenSecurityBodyComponent.h>

#import <SecurityGuardSDK/JAQ/SecuritySignature.h>

#import "GHNLoginView.h"
#import "GHNFullRecommendCodeViewController.h"

@interface GHNLoginViewController ()<MSAuthProtocol, GHNLoginViewDelegate>

/**
 安全验证的 VC, 需要在该界面 Dismiss 掉, 所以要指向他
 */
@property (nonatomic, strong) UIViewController *verifyVC;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHNLoginView *loginView;

@end

@implementation GHNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    // 微信授权成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatAuthSuccess:) name:kNotificationWeChatAuthSuccess object:nil];
    
    // 微信授权失败
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatAuthFailed) name:kNotificationWeChatAuthFailed object:nil];

}

- (void)setupUI {
    
    GHNLoginView *loginView = [[GHNLoginView alloc] init];
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
    
//    if ([GHUserModelTool shareInstance].isZheng) {
//        
//        UIButton *passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        passwordButton.titleLabel.font = H15;
//        [passwordButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
//        [passwordButton setTitle:@"密码登录" forState:UIControlStateNormal];
//        [self.view addSubview:passwordButton];
//        
//        [passwordButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(44);
//            make.width.mas_equalTo(100);
//            make.right.mas_equalTo(0);
//            make.top.mas_equalTo(Height_StatusBar + 5);
//        }];
//        [passwordButton addTarget:self action:@selector(clickPasswordAction) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
    
}

- (void)loginViewClickGetVerifyAction {
    
    [self getVerifyCodeAction];
    
}

- (void)getVerifyCodeAction {
    
    if (self.loginView.phoneTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的手机号"];
        return;
    }
 
    if (![self.loginView.phoneTextField.text isValidPhone]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = ISNIL(self.loginView.phoneTextField.text);
//    params[@"sessionSig"] = sessionId;
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiSmsCode withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [SVProgressHUD dismiss];
        if (isSuccess) {
            
            [self.loginView changeVerifyButtonState];
            
            [self.loginView.verifyTextField becomeFirstResponder];
            
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
    
    if (code != 0) {
        
        if (sessionId.length > 0) {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"phoneNum"] = ISNIL(self.loginView.phoneTextField.text);
            params[@"sessionSig"] = sessionId;

            [SVProgressHUD showWithStatus:kDefaultTipsText];

            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiSmsCode withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {

                if (isSuccess) {

                    [self.loginView changeVerifyButtonState];

                    [self.loginView.verifyTextField becomeFirstResponder];

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

- (void)loginViewClickLoginAction {

    if (self.loginView.phoneTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的手机号"];
        return;
    }

    if (![self.loginView.phoneTextField.text isValidPhone]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }

    if (self.loginView.verifyTextField.text.length != 6) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的验证码"];
        return;
    }

    if (self.loginView.agreeButton.isSelected == false) {
        [SVProgressHUD showErrorWithStatus:@"请同意用户服务协议"];
        return;
    }
    
    NSLog(@"手机号登录");
    
    
    
    
    
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"phone"] = ISNIL(self.loginView.phoneTextField.text);
        params[@"verificationCode"] = ISNIL(self.loginView.verifyTextField.text);
    
        [SVProgressHUD showWithStatus:kDefaultLoginTipsText];
    
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiSessionPhone withParameter:params withLoadingType:GHLoadingType_ShowLoading  withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
    
            if (isSuccess) {
    
//                NSString *token = response[@"token"];
                NSString *token = response[@"data"];
    
                [GHUserModelTool shareInstance].account = ISNIL(self.loginView.phoneTextField.text);
    
                [GHUserModelTool shareInstance].token = ISNIL(token);
    
                [GHUserModelTool shareInstance].isLogin = YES;
    
                [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
    
                [SVProgressHUD showSuccessWithStatus:@"恭喜您,登录成功"];
                
                
                
                NSMutableDictionary *parame = [@{@"Authorization":[GHUserModelTool shareInstance].token}copy];
                    
                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiGetUserMe withParameter:parame withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                        
                        
                        if (isSuccess) {
                            
                            [GHUserModelTool shareInstance].userInfoModel = [[GHUserInfoModel alloc] initWithDictionary:response[@"data"] error:nil];
                            
                                
                            [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
                            
                            [[GHSaveDataTool shareInstance] userLogoutRemoveAllNotice];
                                
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                              [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
                            });
                          
                            [self clickCloseAction];
                        }
                    }];
                
                
              
                
                return; //add change by zhangfuyu
    
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
                });
    
                
                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiUserLogincount withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                    
                    if (isSuccess) {
                        
                        NSLog(@"%@", response);
                        
                        if ([response integerValue] > 1) {
                            [self clickCloseAction];
                        } else {
                            
                            GHNFullRecommendCodeViewController *vc = [[GHNFullRecommendCodeViewController alloc] init];
                            vc.type = GHNFullRecommendCodeViewController_Register;
                            GHNavigationViewController *nav = [[GHNavigationViewController alloc] initWithRootViewController:vc];
                            
                            [self presentViewController:nav animated:false completion:nil];
                            
                        }
                        
                    }
                    
                }];

                
//
    
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"验证码错误"];
            }
    
        }];
    
    
}


- (void)loginViewClickWeChatAction {
    
    if (self.loginView.agreeButton.isSelected == false) {
        [SVProgressHUD showErrorWithStatus:@"请同意用户服务协议"];
        return;
    }
    
    NSLog(@"微信登录");
    
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"udoctor";
    
    [WXApi sendReq:req];
    
}

- (void)clickCloseAction {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}

- (void)clickPasswordAction {
    
    GHLoginPasswordViewController *vc = [[GHLoginPasswordViewController alloc] init];
    [self presentViewController:vc animated:true completion:nil];
    
}

/**
 微信授权失败
 */
- (void)wechatAuthFailed {
    
//    self.wechatLoginButton.selected = false;
//    self.phoneLoginButton.selected = true;
    
}

/**
 微信授权成功
 
 @param noti <#noti description#>
 */
- (void)wechatAuthSuccess:(NSNotification *)noti {
    
    NSString *code = noti.userInfo[@"code"];

    if (code.length > 0) {
        
        NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAppKey,AppSecret,code];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *zoneUrl = [NSURL URLWithString:url];
            NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
            NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSString *openId = dic[@"openid"];
                    
                    [self getWechatUserInfoWithopenId:openId];
                }
            });
        });
        
        
       

    }
    
}

- (void)getWechatUserInfoWithopenId:(NSString *)openId
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"wxOpenId"] = openId;
    
    [SVProgressHUD showWithStatus:kDefaultLoginTipsText];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiSessionWeChat withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            if (isSuccess) {
                
                NSString *token = response[@"data"];
                
                if (token.length > 0) {
                    [GHUserModelTool shareInstance].token = ISNIL(token);
                    
                    
                    [GHUserModelTool shareInstance].isLogin = true;
                    
                    [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
                    
                    [SVProgressHUD showSuccessWithStatus:@"恭喜您,登录成功"];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
                    });
                    
                    [self clickCloseAction];
                    
                }
                else
                {
                    GHNBindPhoneViewController *vc = [[GHNBindPhoneViewController alloc] init];
                    //                        vc.token = [[GHUserModelTool shareInstance].token copy];
                    vc.weixinID = openId;
                    GHNavigationViewController *nav = [[GHNavigationViewController alloc] initWithRootViewController:vc];
                    
                    [GHUserModelTool shareInstance].token = nil;
                    
                    [self presentViewController:nav animated:false completion:nil];
                }
                
                
                
                
                
            }
            
        }];
        
        
        
    });

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
