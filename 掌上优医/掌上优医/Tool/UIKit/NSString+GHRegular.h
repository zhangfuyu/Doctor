//
//  NSString+GHRegular.h
//  掌上优医
//
//  Created by GH on 2018/10/29.
//  Copyright © 2018 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (GHRegular)




/**
 验证邮箱
 
 @return <#return value description#>
 */
- (BOOL)isValidateEmail;


/**
 验证身份证格式
 
 @return <#return value description#>
 */
- (BOOL)isValidateIDCard;


/**
 验证手机号码
 
 @return <#return value description#>
 */
- (BOOL)isMobileNumber;

- (BOOL)isValidPhone;


/**
 验证是否纯数字
 
 @return <#return value description#>
 */
- (BOOL)isNumber;


/**
 验证是否存在特殊字符
 
 @return <#return value description#>
 */
- (BOOL)isNormalString;

- (BOOL)isTelNum;

/**
 验证是否包含 emoji 表情
 
 @param string <#string description#>
 @return <#return value description#>
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;


/**
 验证是否为中文
 
 @return <#return value description#>
 */
- (BOOL)isChineseString;

- (BOOL)isEnglishString;

/**
 验证是否只包含中英文
 
 @return <#return value description#>
 */
-(BOOL)isHaveNumber;

/**
 验证是否为字符和数字的结合
 
 @return <#return value description#>
 */
- (BOOL)isCodeAndNumber;



/**
 将 Unicode 编码格式字符串的转换成中文
 
 @return <#return value description#>
 */
- (NSString *)replaceUnicode;


///**
// 将固定的表情格式转换成文字展现
//
// @param string <#string description#>
// @return <#return value description#>
// */
//- (NSString *)replaceExpression:(NSString *)string;


/**
 验证只可输入中文 数字
 
 @return <#return value description#>
 */
- (BOOL)isAlphString;

/**
 验证只可输入英文 数字
 
 @return <#return value description#>
 */
- (BOOL)isNumberAndEnglish;


/**
 根据相对路径得到绝对路径
 
 @return <#return value description#>
 */
- (NSString *)absolutePath;


/**
 验证车牌
 
 @return <#return value description#>
 */
- (BOOL)isCarNumber;

- (BOOL)isMacAddress;



/**
 验证 URL
 
 @return <#return value description#>
 */
- (BOOL)isValidUrl;


/**
 验证邮编
 
 @return <#return value description#>
 */
- (BOOL)isValidPostalcode;


/**
 验证 IP
 
 @return <#return value description#>
 */
- (BOOL)isIPAddress;

- (BOOL)isValidTaxNo;


/**
 验证是否是正确格式的密码
 
 @return <#return value description#>
 */
- (BOOL)isConnetPassword;

/**
 验证银行卡号
 
 @return <#return value description#>
 */
- (BOOL)bankCardluhmCheck;

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

+ (BOOL)isEmpty:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
