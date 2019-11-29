//
//  GHNLoginPasswordView.h
//  掌上优医
//
//  Created by GH on 2019/3/4.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"
#import "GHTextField.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHNLoginPasswordViewDelegate <NSObject>

@optional

/**
 点击登录
 */
- (void)loginPasswordViewClickLoginAction;

@end

@interface GHNLoginPasswordView : GHBaseView

@property (nonatomic, weak) id<GHNLoginPasswordViewDelegate> delegate;

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
@property (nonatomic, strong) UIButton *agreeButton;

@end

NS_ASSUME_NONNULL_END
