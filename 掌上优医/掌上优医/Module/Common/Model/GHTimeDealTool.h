//
//  GHTimeDealTool.h
//  掌上优医
//
//  Created by GH on 2018/11/12.
//  Copyright © 2018 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHTimeDealTool : NSObject

+ (NSString *)getUTCFormateLocalDate:(NSString *)localDate;


+ (NSString *)getShowTimeWithTimeStr:(NSString *)str;

+ (NSString *)getShowQuestionTimeWithTimeStr:(NSString *)str;

/**
 获取圈子的模型

 @param modelId <#modelId description#>
 @return <#return value description#>
 */
+ (id)getCircleNameWithId:(NSString *)modelId;

@end

NS_ASSUME_NONNULL_END
