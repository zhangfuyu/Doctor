//
//  GHFullRecommendCodeView.h
//  掌上优医
//
//  Created by GH on 2019/2/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHFullRecommendCodeView : GHBaseView

@property (weak, nonatomic) UITextField *textfield01;
@property (weak, nonatomic) UITextField *textfield02;
@property (weak, nonatomic) UITextField *textfield03;
@property (weak, nonatomic) UITextField *textfield04;
@property (weak, nonatomic) UITextField *textfield05;
@property (weak, nonatomic) UITextField *textfield06;

/**
 获取邀请码

 @return <#return value description#>
 */
- (NSString *)getFullRecommendCode;

@end

NS_ASSUME_NONNULL_END
