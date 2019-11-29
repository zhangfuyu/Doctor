//
//  NSDictionary+Extension.h
//  Category
//
//  Created by JFYT on 2017/7/6.
//  Copyright © 2017年 F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)


/**
 Dictionary 中所有的 key

 @return <#return value description#>
 */
- (NSArray *)allKeysSorted;


/**
 Dictionary 中所有的 value

 @return <#return value description#>
 */
- (NSArray *)allValuesSortedByKeys;


/**
 Dictionary 中是否包含这个 key

 @param key <#key description#>
 @return <#return value description#>
 */
- (BOOL)containsObjectForKey:(id)key;


/**
 返回 keys 所对应的所有 value 的一个新的 Dictionary

 @param keys <#keys description#>
 @return <#return value description#>
 */
- (NSDictionary *)entriesForKeys:(NSArray *)keys;


/**
 Dictionary 转换为 json 字符串(一整行)

 @return <#return value description#>
 */
- (NSString *)jsonStringEncoded;


/**
 Dictionary 转换为格式化的 json 字符串

 @return <#return value description#>
 */
- (NSString *)jsonPrettyStringEncoded;


/**
 Json 字符串转换为 Dictionary

 @param jsonString <#jsonString description#>
 @return <#return value description#>
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/**
 XML 转换为 Dictionary

 @param xmlDataOrPath <#xmlDataOrPath description#>
 @return <#return value description#>
 */
+ (NSDictionary *)dictionaryWithXML:(id)xmlDataOrPath;

@end

@interface NSMutableDictionary (XSDExt)


/**
 移除 key 所对应的 value,并返回 value

 @param aKey <#aKey description#>
 @return <#return value description#>
 */
- (id)popObjectForKey:(id)aKey;

/**
移除 keys 所对应的所有 value,并返回一个新字典
 
 @param keys The keys.
 
 @return The entries for the keys.
 */
- (NSDictionary *)popEntriesForKeys:(NSArray *)keys;

@end
