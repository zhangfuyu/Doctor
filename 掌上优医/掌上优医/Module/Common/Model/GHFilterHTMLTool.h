//
//  GHFilterHTMLTool.h
//  掌上优医
//
//  Created by GH on 2018/11/24.
//  Copyright © 2018 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHFilterHTMLTool : NSObject

//过滤
/**
 * 过滤标签
 */
+(NSString *)filterHTML:(NSString *)str;

+(NSString *)filterHTMLEMTag:(NSString *)str;

/**
 过滤掉 P标签

 @param str <#str description#>
 @return <#return value description#>
 */
+(NSString *)filterHTMLPTag:(NSString *)str;



+(NSString *)filterHTMLImage:(NSString *)str;
/**
 * 替换部分标签
 */
+ (NSString *)filterHTMLTag:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
