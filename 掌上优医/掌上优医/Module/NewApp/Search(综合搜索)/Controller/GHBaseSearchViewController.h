//
//  GHBaseSearchViewController.h
//  掌上优医
//
//  Created by apple on 2019/8/6.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHBaseSearchViewController : GHBaseViewController


@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) UITextField *searchTextField;

- (void)clickSearchAction;

@end

NS_ASSUME_NONNULL_END
