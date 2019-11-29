//
//  GHNBindPhoneView.h
//  掌上优医
//
//  Created by GH on 2019/2/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"
#import "GHTextField.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHNBindPhoneViewDelegate <NSObject>

@optional

/**
 获取验证码
 */
- (void)bindPhoneViewClickGetVerifyAction;

/**
 点击登录
 */
- (void)bindPhoneViewClickLoginAction;

@end

@interface GHNBindPhoneView : GHBaseView

/**
 <#Description#>
 */
@property (nonatomic, weak) id<GHNBindPhoneViewDelegate> delegate;

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

- (void)changeVerifyButtonState;

@end

NS_ASSUME_NONNULL_END
