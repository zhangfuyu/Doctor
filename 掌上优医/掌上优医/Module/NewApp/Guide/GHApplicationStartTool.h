//
//  GHApplicationStartTool.h
//  掌上优医
//
//  Created by GH on 2018/10/24.
//  Copyright © 2018 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHApplicationStartTool : NSObject

+ (instancetype)shareInstance;

/**
 获取首先应该出现的界面

 @return <#return value description#>
 */
- (UIViewController *)getStartViewController;

@end

NS_ASSUME_NONNULL_END
