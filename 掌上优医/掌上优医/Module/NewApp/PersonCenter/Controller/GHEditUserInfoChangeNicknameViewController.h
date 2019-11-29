//
//  GHEditUserInfoChangeNicknameViewController.h
//  掌上优医
//
//  Created by GH on 2018/11/2.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHEditUserInfoChangeNicknameViewControllerDelegate <NSObject>

@optional
- (void)finishEditNicknameWithText:(NSString *)str;

@end

@interface GHEditUserInfoChangeNicknameViewController : GHBaseViewController

@property (nonatomic, weak) id<GHEditUserInfoChangeNicknameViewControllerDelegate> delegate;

@property (nonatomic, copy) NSString *string;

@end

NS_ASSUME_NONNULL_END
