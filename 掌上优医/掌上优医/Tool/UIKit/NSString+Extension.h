//
//  NSString+Extension.h
//  Category
//
//  Created by JFYT on 2017/7/6.
//  Copyright © 2017年 F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kRSAPublicKEY @"MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAIoMX3O9cxCUkJnUz1X6CN1TwFJBu6TFCTuHjxe8mMSN1VipeT1CtZLvBI9En5LQWXZpj/mv+yCNhWot4yros3MCAwEAAQ=="

@interface NSString (Extension)


/**
 判断字符串，给予单位万元或者十万元

 @return <#return value description#>
 */
-(NSString *)getStringValue;

/**
 获取临时存放路径(app 退出会删除该路径下的文件)

 @return <#return value description#>
 */
+ (NSString *)tmpPath;


/**
 设备唯一标识
 UUID 存放到系统, APP 卸载后再次安装也能获取到此 UUID

 @return <#return value description#>
 */
//+ (NSString *)deviceUUID;


/**
 随机生成一个 UUID

 @return <#return value description#>
 */
+ (NSString *)stringWithUUID;


/**
 将字符串 MD5加密

 @return <#return value description#>
 */
- (NSString *)md5String;


/**
 AES256加密

 @param key <#key description#>
 @return <#return value description#>
 */
- (NSString *)aes256Encrypt:(NSString *)key;


/**
 AES256解密

 @param key <#key description#>
 @return <#return value description#>
 */
- (NSString *)aes256Decrypt:(NSString *)key;


/**
 RSA 加密

 @param key <#key description#>
 @return <#return value description#>
 */
- (NSString *)rsaEncrypt:(NSString *)key;


/**
 RSA 解密

 @param key <#key description#>
 @return <#return value description#>
 */
- (NSString *)rsaDecrypt:(NSString *)key;

/**
 将字符串进行 base64编码

 @return <#return value description#>
 */
- (NSString *)base64Encoding;


/**
 将 base64编码格式的字符串还原成明文字符串

 @param base64String <#base64String description#>
 @return <#return value description#>
 */
+ (NSString *)base64Decode:(NSString *)base64String;


/**
 将字符串以 URL 编码,编码格式为 UTF8

 @return <#return value description#>
 */
- (NSString *)stringByURLEncode;


/**
 将字符串以 URL 编码

 @param encoding <#encoding description#>
 @return <#return value description#>
 */
- (NSString *)stringByURLEncode:(NSStringEncoding)encoding;


/**
 字符串添加千位分隔符

 @param digitString <#digitString description#>
 @return <#return value description#>
 */
- (NSString *)separatedDigitStringWithStr:(NSString *)digitString;


/**
 根据字符串内容,字体大小,视图最大范围, lineBreakMode 计算出当前字符串所对应的视图大小

 @param font 字体大小
 @param size 视图最大范围
 @param lineBreakMode NSLineBreakByCharWrapping; 以字符为显示单位显示，后面部分省略不显示。
                      NSLineBreakByClipping; 剪切与文本宽度相同的内容长度，后半部分被删除。
                      NSLineBreakByTruncatingHead; 前面部分文字以……方式省略，显示尾部文字内容。
                      NSLineBreakByTruncatingMiddle; 中间的内容以……方式省略，显示头尾的文字内容。
                      NSLineBreakByTruncatingTail; 结尾部分的内容以……方式省略，显示头的文字内容。
                      NSLineBreakByWordWrapping; 以单词为显示单位显示，后面部分省略不显示。
 @return <#return value description#>
 */
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;


/**
 根据字体大小计算出视图宽度

 @param font <#font description#>
 @return <#return value description#>
 */
- (CGFloat)widthForFont:(UIFont *)font;


/**
 根据字体大小,宽度 计算出视图高度

 @param font <#font description#>
 @param width <#width description#>
 @return <#return value description#>
 */
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;


/**
 正则匹配

 @param regex <#regex description#>
 @return <#return value description#>
 */
- (BOOL)matchesRegex:(NSString *)regex;


/**
 将字符串过滤空格

 @return <#return value description#>
 */
- (NSString *)stringByTrim;


/**
 去除一个 string 里面的空格跟换行

 @return <#return value description#>
 */
- (NSString *)clearWhiteSpaceAndNewLine;


/**
 判断是否包含某个字符串

 @param string <#string description#>
 @return <#return value description#>
 */
- (BOOL)containsString:(NSString *)string;


/**
 判断是否包含某个字符串

 @param set <#set description#>
 @return <#return value description#>
 */
- (BOOL)containsCharacterSet:(NSCharacterSet *)set;


/**
 将字符串转换成 NSNumber

 @return <#return value description#>
 */
- (NSNumber *)numberValue;


/**
 将字符串转换成 NSData

 @return <#return value description#>
 */
- (NSData *)dataValue;


/**
 将字符串转换成 json 对象

 @return <#return value description#>
 */
- (id)jsonValueDecoded;


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

/**
 米转千米

 @return <#return value description#>
 */
- (NSString *)getKillMeter;


+ (BOOL)locationIsNearbyWithValue1:(NSString *)value1 WithValue2:(NSString *)value2;

- (CGFloat)getShouldHeightWithContent:(NSString *)content withFont:(UIFont *)font withWidth:(CGFloat)width withLineHeight:(CGFloat)lineHeight;

@end
