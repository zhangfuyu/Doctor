//
//  GHNChangePasswordView.h
//  掌上优医
//
//  Created by GH on 2019/3/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"
#import "GHTextField.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHNChangePasswordViewDelegate <NSObject>

@optional

/**
 获取验证码
 */
- (void)changePasswordViewClickGetVerifyAction;

/**
 点击登录
 */
- (void)changePasswordViewClickLoginAction;

@end

@interface GHNChangePasswordView : GHBaseView

/**
 <#Description#>
 */
@property (nonatomic, weak) id<GHNChangePasswordViewDelegate> delegate;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHTextField *phoneTextField;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHTextField *verifyTextField;

@property (nonatomic, strong) GHTextField *passwordTextField;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *getVerifyCodeButton;

- (void)changeVerifyButtonState;

@end

NS_ASSUME_NONNULL_END
