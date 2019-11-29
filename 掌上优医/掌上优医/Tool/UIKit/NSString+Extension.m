//
//  NSString+Extension.m
//  Category
//
//  Created by JFYT on 2017/7/6.
//  Copyright © 2017年 F. All rights reserved.
//

#import "NSString+Extension.h"
//#import "NSData+Extension.h"
//#import "NSNumber+Extension.h"
//#import "HBRSAHandler.h"


@implementation NSString (Extension)

#define kDeviceUUID @"DeviceUUID"         // 设备序列号

+ (NSString *)tmpPath{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}

//+ (NSString *)deviceUUID {
//    NSString * bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
//    
//    NSString *UUID = [[NSUserDefaults standardUserDefaults] stringForKey:kDeviceUUID];
//    NSString *string = [self p_returnDeviceID:UUID bundleId:bundleIdentifier];
//    
//    return string;
//}
//
//+ (NSString *)p_returnDeviceID:(NSString *)deviceID bundleId:(NSString *)bundleIdentifier {
//    
//    NSString *device = deviceID;
//    if(device.length == 0) {
//        
//        device = [SSKeychain passwordForService:bundleIdentifier account:bundleIdentifier];
//        
//        if(device.length == 0) {
//            NSString *UUID = [self stringWithUUID];
//            device = [[NSString stringWithFormat:@"%@%@",UUID, bundleIdentifier] md5String];
//            [SSKeychain setPassword:device forService:bundleIdentifier account:bundleIdentifier];
//        }
//        
//        [[NSUserDefaults standardUserDefaults] setObject:device forKey:kDeviceUUID];
//    }
//    
//    return device;
//}
-(NSString *)getStringValue{
  
  if ([self containsString:@"-"]) {
    if (self.floatValue <= -10000){
       return [NSString stringWithFormat:@"%.2f万元",[self floatValue]/10000];
    }
    else{
       return [NSString stringWithFormat:@"%.2f元",[self floatValue]];
    }
  }
  else{
    if (self.floatValue >= 10000) {
      return [NSString stringWithFormat:@"%.2f万元",[self floatValue]/10000];
    }
    else{
      return [NSString stringWithFormat:@"%.2f元",[self floatValue]];
    }
  }
  
}


+ (NSString *)stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

- (NSString *)md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}

//- (NSString *)aes256Encrypt:(NSString *)key {
//    NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] aes256Encrypt:key];
//    return [data utf8String];
//}
//
//- (NSString *)aes256Decrypt:(NSString *)key {
//    NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] aes256Decrypt:key];
//    return [data utf8String];
//}

- (NSString *)base64Encoding {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
}

//+ (NSString *)base64Decode:(NSString *)base64String {
//    NSData *data = [NSData dataWithBase64Encoding:base64String];
//    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//}


- (NSString *)stringByURLEncode {
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                       (__bridge CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    
    return outputStr;
}


- (NSString *)stringByURLEncode:(NSStringEncoding)encoding {
    
    NSString *encoded = (__bridge_transfer NSString *)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CFURLCreateStringByAddingPercentEscapes(
                                            NULL,
                                            (__bridge CFStringRef)self,
                                            NULL,
                                            CFSTR("!#$&'()*+,/:;=?@[]"),
                                            (CFStringEncoding)encoding);
#pragma clang diagnostic pop
    return encoded;
}



- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = @{}.mutableCopy;
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return CGSizeMake(ceil(result.width), ceil(result.height));
}


- (CGFloat)widthForFont:(UIFont *)font {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}


- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}



- (BOOL)matchesRegex:(NSString *)regex {
    NSError *error = nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionAnchorsMatchLines error:&error];
    if (error) {
        NSLog(@"NSString+YYAdd create regex error: %@", error);
        return NO;
    }
    return ([pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)] > 0);
}


- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

/**
 *  去除一个String里面的空格跟换行
 *
 *  @return
 */
- (NSString *)clearWhiteSpaceAndNewLine {
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
            componentsJoinedByString:@""];
}

- (BOOL)containsString:(NSString *)string {
    if (string == nil) return NO;
    return [self rangeOfString:string].location != NSNotFound;
}

- (BOOL)containsCharacterSet:(NSCharacterSet *)set {
    if (set == nil) return NO;
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}

- (NSNumber *)numberValue {
    return [NSNumber numberWithString:self];
}

- (NSData *)dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)jsonValueDecoded {
    return [[self dataValue] jsonValueDecoded];
}


- (BOOL)isValidateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}


- (BOOL)isValidateIDCard {
    NSString *regex = @"(\\d{14}[0-9a-zA-Z])|(\\d{17}[0-9a-zA-Z])";
    NSPredicate *idCardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [idCardTest evaluateWithObject:self];
}


- (BOOL)isValidVerifyCode {
    BOOL isVerifyCode = NO;
    NSString *verifyRegex = @"\\d{6}";
    NSPredicate *verifyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verifyRegex];
    isVerifyCode = [verifyTest evaluateWithObject:self];
    return isVerifyCode;
}


- (BOOL)isMobileNumber{
    BOOL isPhone = NO;
    NSString *phoneNumber = @"^1[0123456789]\\d{9}$|^20000000\\d{3}$";
    NSPredicate *regextestphone = [NSPredicate predicateWithFormat:@"SELF  MATCHES %@",phoneNumber];
    if ([regextestphone evaluateWithObject:self]==YES)
    {
        isPhone = YES;
    }
    else
    {
        isPhone = NO;
    }
    
    return isPhone;
}
- (BOOL)isValidPhone
{
    NSString *phoneRegex1=@"1[3456789]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return [phoneTest1 evaluateWithObject:self];
}

- (BOOL)isTelNum{
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextesTel = [NSPredicate predicateWithFormat:@"SELF     MATCHES %@", PHS];
    if ([regextesTel evaluateWithObject:self]) {
        return YES;
    }else{
        return NO;
    }
}


- (BOOL)isAlphString {
    
    NSString *regex = @"^[a-zA-Z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isNumberAndEnglish {
    
    NSString *regex = @"^[0-9a-zA-Z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}


- (BOOL)isNumber {
    
    NSString *regex = @"(^[0-9]*$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isConnetPassword {
    
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![!#$%^&*]+$)[0-9a-zA-Z!#$%^&*]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}

+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                    
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }else if (hs == 0x200d){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

- (BOOL)isNormalString {
    //    NSString *regex = @"^([\u4e00-\u9fa5]+|[a-zA-Z]+)$";
//    NSString *regex = @"^([\u4e00-\u9fa5]+|[a-zA-Z]+)$";
    NSString *regex = @"^([a-zA-Z0-9\u4e00-\u9fa5]+)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isChineseString {
    
    NSString *regex = @"^([\u4e00-\u9fa5]+)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isEnglishString{
    NSString *regex = @"[a-zA-Z]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

-(BOOL)isHaveNumber{
  NSString *regex = @"[a-zA-Z\u4e00-\u9fa5]+";
  NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
  BOOL isMatch = [pred evaluateWithObject:self];
  return isMatch;
}


- (BOOL)isCodeAndNumber {
    
    NSString *regex = @"^(-)?+\\d+(\\.\\d+)?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (NSString *)absolutePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *popusPath = [documentsDirectory stringByAppendingFormat:@"/%@", self];
    
    return popusPath;
}

- (NSString *)replaceUnicode {
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnString = [NSPropertyListSerialization propertyListWithData:tempData
                                                                       options:NSPropertyListImmutable
                                                                        format:NULL
                                                                         error:NULL];
    
    return [returnString stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}


//- (NSString *)replaceExpression:(NSString *)string {
//    NSError* error = NULL;
//    
//    //分成三段来理解
//    /*
//     第一段:以某段字符做为起始 (\\{:) 括号内为实际内容
//     第二段:对于包含中的定义,参见正则.
//     第三段:再以某段字符做为收尾 (:\\})
//     注意，这里的 { 在正则里面是关键字，所以需要用到 \{ 来转义, oc里面 \ 需要用到 \\ 来转义
//     */
//    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"(\\{:)(\\d{3})+(:\\})"
//                                                                           options:0
//                                                                             error:&error];
//    NSString *sample = self;
//    
//    NSString *template = ISNILDefault(string, @"[表情]");
//    NSString* result = [regex stringByReplacingMatchesInString:sample
//                                                       options:0
//                                                         range:NSMakeRange(0, sample.length)
//                                                  withTemplate:template];
//    
//    return result;
//}



#pragma mark - 正则相关
- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)isValidPostalcode {
    NSString *postalRegex = @"^[0-8]\\d{5}(?!\\d)$";
    return [self isValidateByRegex:postalRegex];
}

//车牌
- (BOOL)isCarNumber {
    //车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
//    NSString *carRegex = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$";//其中\u4e00-\u9fa5表示unicode编码中汉字已编码部分，\u9fa5-\u9fff是保留部分，将来可能会添加
    NSString *carRegex = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$";
    BOOL result = true;
    
    if (result) {
        result = [self isValidateByRegex:carRegex];
    }
    
    if (result) {
        result = ![self containsString:@"O"];
    }
    
    if (result) {
        result = ![self containsString:@"I"];
    }
    
    if (result) {
        
        NSUInteger count = 0;
        NSArray *zimuArray = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
        
        for (NSUInteger index = 0; index < self.length; index++) {
            
            NSString *str = [self substringWithRange:NSMakeRange(index, 1)];
            if ([zimuArray containsObject:str]) {
                count ++;
            }
            
        }
        
        if (count > 3) {
            result = false;
        }
        
    }
    
    
    return result;
}

- (BOOL)isValidUrl {
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    return [self isValidateByRegex:regex];
}

- (BOOL)isMacAddress {
    NSString * macAddRegex = @"([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}";
    return  [self isValidateByRegex:macAddRegex];
}

- (BOOL)isValidTaxNo {
    NSString *taxNoRegex = @"[0-9]\\d{13}([0-9]|X)$";
    return [self isValidateByRegex:taxNoRegex];
}

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal {
    //  [\u4e00-\u9fa5A-Za-z0-9_]{4,20}
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    
    NSString *regex = [NSString stringWithFormat:@"%@[%@A-Za-z0-9_]{%d,%d}", first, hanzi, (int)(minLenth-1), (int)(maxLenth-1)];
    return [self isValidateByRegex:regex];
}

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal {
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    return [self isValidateByRegex:regex];
}


/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
- (BOOL)bankCardluhmCheck {
    NSString * lastNum = [[self substringFromIndex:(self.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[self substringToIndex:(self.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i< forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 ==0)?YES:NO;
}


- (BOOL)isIPAddress {
    NSString *regex = [NSString stringWithFormat:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL rc = [pre evaluateWithObject:self];
    
    if (rc) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        
        return v;
    }
    
    return NO;
}


- (NSString *)separatedDigitStringWithStr:(NSString *)digitString {
    if (digitString.length <= 3) {
        return digitString;
    } else {
        NSMutableString *processString = [NSMutableString stringWithString:digitString];
        NSInteger location = processString.length - 3;
        NSMutableArray *processArray = [NSMutableArray array];
        while (location >= 0) {
            NSString *temp = [processString substringWithRange:NSMakeRange(location, 3)];
            [processArray addObject:temp];
            if (location < 3 && location > 0) {
                NSString *t = [processString substringWithRange:NSMakeRange(0, location)];
                [processArray addObject:t];
            }
            location -= 3;
        }
        NSMutableArray *resultsArray = [NSMutableArray array];
        int k = 0;
        for (NSString *str in processArray) {
            k++;
            NSMutableString *tmp = [NSMutableString stringWithString:str];
            if (str.length > 2 && k < processArray.count ) {
                [tmp insertString:@"," atIndex:0];
                [resultsArray addObject:tmp];
            } else {
                [resultsArray addObject:tmp];
            }
        }
        NSMutableString *resultString = [NSMutableString string];
        for (int i = resultsArray.count - 1 ; i >= 0; i--) {
            NSString *tmp = [resultsArray objectAtIndex:i];
            [resultString appendString:tmp];
        }
        NSRange range = NSMakeRange(resultString.length - 4, 1);
        [resultString deleteCharactersInRange:range];
        return resultString;
    }
}


//- (NSString *)rsaEncrypt:(NSString *)key {
//
//    NSString *public_key_string = key;
//    HBRSAHandler *handler = [[HBRSAHandler alloc] init];
//    [handler importKeyWithType:KeyTypePublic andkeyString:public_key_string];
//    NSString *encryptStr = [handler encryptWithPublicKey:self];
//
//    return ISNIL(encryptStr);
//////    NSString* private_key_string = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALgv/syFH337KzC29KvR0p6cP+glRqjDYAQno5ifafXZjgf1EhBjZblKv+HiLAzNBOlYU1PnLuOOkZj6pg1A5HUZLpsbYa5Mwr1bUHALjXLaB3THCpZX51/b5L14erGo52Jv/j/63YljEtMm8ALmkY8S+3fPxFeY7ya+2VXMEtplAgMBAAECgYAguvauZWGpQ37zUy+7cLfa061PlYAu8TkYw+qAbqOnupdQtq4VF3S2LqBWhZiKVcxvovB70nM0oNsisjfb1xJBpyfDBFug7d+y2f8yr6aTOezoY5DBYEF3Svg9Kp9ra+vvAYX/7fh+tHCU0HOvp0z8ikZiRSWZaQ+3A2GiCIJrwQJBAPKVji89hGAMEWLJJFZaPiLBqZUwR2W/rp7Ely5ddKfjcosHhggHfOb71BnrMOm0h4S85Gx6a87n9R2To0c51q0CQQDCX6yYdt/9JGORyNSXfzMfSZyVOrMpIo77R0YwKa3UOwwLA56l2Lc4AYO10/lyAyZCKse2/5D9ZZUB7xoYEmGZAkB8MEJVPuoY/bSc3RqENrjetERsAwZaObJcx4oaC3AgTxmhwV1FmQfBfKTODBDDZE+Ijedm/ZlZmHhtBtstKJgVAkBKma/DgHRtUscIT90QHBjB3F3FhJb4pbPcyzksCQMXXmY73/LG0ktXqnUjlyy4zm6jnIm0OZgrOQ6chGkubfeZAkBMCGF2tPfEJh8XODOvlw5ADnUiq+Qe/abcpKowkiT9zP+rYT9XJAx7QxChjdwTZb6ahnJY1+ny1emEHUOs2fm8";
////
////    NSString* public_key_string = key;
//////    NSString *publicKeyFilePath = [[NSBundle mainBundle] pathForResource:@"rsa_public_key.pem" ofType:nil];
//////    NSString *privateKeyFilePath = [[NSBundle mainBundle] pathForResource:@"rsa_private_key.pem" ofType:nil];
////    HBRSAHandler *handler = [HBRSAHandler new];
////    //两种方式导入
//////     [handler importKeyWithType:KeyTypePublic andPath:publicKeyFilePath];
//////    [handler importKeyWithType:KeyTypePrivate andPath:privateKeyFilePath];
////    [handler importKeyWithType:KeyTypePrivate andkeyString:private_key_string];
////    [handler importKeyWithType:KeyTypePublic andkeyString:public_key_string];
////
////    NSString* sig = [handler signString:@"签名字符串"];
////    NSString* sigMd5 = [handler signMD5String:@"签名字符串"];
////    NSLog(@"%@      %@",sig,sigMd5);
////
////    BOOL isMatch = [handler verifyString:@"签名字符串" withSign:sig];
////    BOOL isMatchMd5 = [handler verifyMD5String:@"签名字符串
////                       NSLog(@"%d      %d",isMatch,isMatchMd5);
////
////                       NSString* enString = [handler encryptWithPublicKey:@"加密字符串"];
////                       NSString* deString = [handler decryptWithPrivatecKey:enString];
////                       NSLog(@"%@",deString);
////
//
//}
//
//- (NSString *)rsaDecrypt:(NSString *)key {
//
//    NSString *public_key_string = key;
//    HBRSAHandler *handler = [[HBRSAHandler alloc] init];
//    [handler importKeyWithType:KeyTypePublic andkeyString:public_key_string];
//    NSString *decryptStr = [handler decryptWithPrivatecKey:self];
//
//    return ISNIL(decryptStr);
//
//}
//

- (NSString *)getKillMeter {
    
    if ([GHUserModelTool shareInstance].locationLatitude == 0 && [GHUserModelTool shareInstance].locationLongitude == 0) {
        return @"";
    }
    
    NSUInteger meter = [self integerValue];
    
    if (meter == 0) {
        return @"";
    }
    
    if (meter < 1000) {
        return [NSString stringWithFormat:@"%ldm", meter];
    }
    
    CGFloat killMeter = meter / 1000.f;
    
    return [NSString stringWithFormat:@"%.1fkm", killMeter];
}

+ (BOOL)locationIsNearbyWithValue1:(NSString *)value1 WithValue2:(NSString *)value2 {
    
    if (value1.length > 0 && value2.length > 0) {
        
        double valueDouble1 = [value1 doubleValue];
        double valueDouble2 = [value2 doubleValue];
        
        if (valueDouble1 != 0 && valueDouble2 != 0) {
            
            double valueDouble = valueDouble1 - valueDouble2;
            
            if (valueDouble < 0.001 && valueDouble > -0.001) {
                return true;
            }
            
        }
        
//
//        NSRange dotValue1 = [value1 rangeOfString:@"."];
//        NSRange dotValue2 = [value2 rangeOfString:@"."];
//
//        if (dotValue1.location > 0 && dotValue2.location > 0 && dotValue1.location == dotValue2.location) {
//
//            NSInteger shouldCompareDigt = 0;
//
//            if (dotValue1.location == 1) {
//
//                shouldCompareDigt = 5;
//
//            } else if (dotValue1.location == 2) {
//
//                shouldCompareDigt = 6;
//
//            } else if (dotValue1.location == 3) {
//
//                shouldCompareDigt = 7;
//
//            }
//
//            if (shouldCompareDigt != 0 && value1.length > shouldCompareDigt && value2.length > shouldCompareDigt) {
//
//                if ([value2 hasPrefix:[value1 substringToIndex:shouldCompareDigt]]) {
//                    return true;
//                }
//
//            }
//
//        }
        
    }
    
    return false;
    
}

- (CGFloat)getShouldHeightWithContent:(NSString *)content withFont:(UIFont *)font withWidth:(CGFloat)width withLineHeight:(CGFloat)lineHeight {
    
    if (ISNIL(content).length == 0) {
        return 0.f;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = lineHeight;
    paragraphStyle.minimumLineHeight = lineHeight;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
    
    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, content.length)];
    [attr addAttributes:@{NSFontAttributeName: font} range:NSMakeRange(0, content.length)];
    
    CGSize size = [attr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    return size.height;
}



@end
