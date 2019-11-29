//
//  GHTabBar.h
//  掌上优医
//
//  Created by GH on 2019/2/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GHTabBarDelegate <NSObject>

-(void)addButtonClickAction;

@end

NS_ASSUME_NONNULL_BEGIN

@interface GHTabBar : UITabBar

//指向MyTabBar的代理
@property (nonatomic, weak) id<GHTabBarDelegate> myTabBarDelegate;

@end

NS_ASSUME_NONNULL_END
