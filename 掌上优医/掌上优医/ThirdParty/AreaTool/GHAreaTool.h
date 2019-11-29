//
//  GHAreaTool.h
//  掌上优医
//
//  Created by GH on 2018/10/26.
//  Copyright © 2018 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHAreaTool : NSObject

+ (instancetype)shareInstance;

/**
 省市区三级联动数据

 @return <#return value description#>
 */
- (NSArray *)getProvinceCityAreaArray;

/**
 省市二级联动数据

 @return <#return value description#>
 */
- (NSArray *)getProvinceCityArray;

/**
 获取城市排序数据

 @return <#return value description#>
 */
- (NSArray *)getSortCityArray;

@end

NS_ASSUME_NONNULL_END
