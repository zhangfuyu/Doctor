//
//  GHNLoginView.h
//  掌上优医
//
//  Created by GH on 2019/2/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"
#import "GHTextField.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHNLoginViewDelegate <NSObject>

@optional

/**
  获取验证码
 */
- (void)loginViewClickGetVerifyAction;

/**
 点击登录
 */
- (void)loginViewClickLoginAction;

/**
 微信登录
 */
- (void)loginViewClickWeChatAction;

@end

@interface GHNLoginView : GHBaseView

/**
 <#Description#>
 */
@property (nonatomic, weak) id<GHNLoginViewDelegate> delegate;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHTextField *phoneTextField;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHTextField *verifyTextField;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *getVerifyCodeButton;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *agreeButton;

- (void)changeVerifyButtonState;


@end

NS_ASSUME_NONNULL_END
