//
//  JFTools.m
//  Category
//
//  Created by JFYT on 2017/7/6.
//  Copyright © 2017年 F. All rights reserved.
//

#import "JFTools.h"
#import <CommonCrypto/CommonCryptor.h>
#import "sys/utsname.h"

@implementation JFTools

+ (NSString *)bundleID {
  NSString *identifier = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
  if (identifier.length == 0) {
    return @"";
  }
  
  return identifier;
}

// 个推上传clientId所需的标志
+ (NSString *)gexinIdentifier {
  
  NSString *identifier;
  
#ifdef TCPF
  //    identifier = @"com.sunday.newstore.tcs";
  //    identifier = @"com.sunday.newstore.appstore.tcs";
#else
  //    identifier = @"com.sunday.newstore.appstore.tcs";
#endif
  
  
  return identifier;
}

+ (NSInteger)bundleVersion {
  NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
  return version.integerValue;
}


+ (NSString *)shortVersion {
  NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
  return version;
}

+ (NSString *)getIphoneSystem {
  NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
  return phoneVersion;
}

+ (NSString *)getTimeStamp {
  NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
  NSTimeInterval a=[date timeIntervalSince1970]*1000;
  NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
  return timeString;
}

+ (NSString *)getDateChangeTimeStamp:(NSString *)date {
  NSDateFormatter *format = [[NSDateFormatter alloc] init];
  format.dateFormat = @"yyyy-MM-dd";
  NSDate *cdata = [format dateFromString:date];
  NSTimeInterval a=[cdata timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
  NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
  return timeString;
}

+ (NSString *)getTimeStampchangeDate:(NSString *)timStamp {
  NSTimeInterval time=[timStamp doubleValue];
  NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
  //实例化一个NSDateFormatter对象
  NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
  //设定时间格式,这里可以设置成自己需要的格式
  [dateFormatter setDateFormat:@"yyyy-M-d"];
  
  NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
  return currentDateStr;
}


+ (NSString *)deviceVersion {
  
  struct utsname systemInfo;
  uname(&systemInfo);
  NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
  //iPhone
  if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
  if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
  if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
  if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
  if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
  if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
  if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
  if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
  if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
  if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
  if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
  if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
  if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
  if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
  if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
  if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
  if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
  if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
  if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
  if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
  if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
  return deviceString;
}

+ (BOOL)isLowDevice {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return true;
    if ([deviceString isEqualToString:@"iPhone1,2"])    return true;
    if ([deviceString isEqualToString:@"iPhone2,1"])    return true;
    if ([deviceString isEqualToString:@"iPhone3,1"])    return true;
    if ([deviceString isEqualToString:@"iPhone3,2"])    return true;
    if ([deviceString isEqualToString:@"iPhone4,1"])    return true;
    if ([deviceString isEqualToString:@"iPhone5,1"])    return true;
    if ([deviceString isEqualToString:@"iPhone5,2"])    return true;
    if ([deviceString isEqualToString:@"iPhone5,3"])    return true;
    if ([deviceString isEqualToString:@"iPhone5,4"])    return true;
    if ([deviceString isEqualToString:@"iPhone6,1"])    return true;
    if ([deviceString isEqualToString:@"iPhone6,2"])    return true;
    if ([deviceString isEqualToString:@"iPhone7,1"])    return true;
    if ([deviceString isEqualToString:@"iPhone7,2"])    return true;
    if ([deviceString isEqualToString:@"iPhone8,1"])    return false;
    if ([deviceString isEqualToString:@"iPhone8,2"])    return false;
    if ([deviceString isEqualToString:@"iPhone8,4"])    return false;
    if ([deviceString isEqualToString:@"iPhone9,1"])    return false;
    if ([deviceString isEqualToString:@"iPhone9,3"])    return false;
    if ([deviceString isEqualToString:@"iPhone9,2"])    return false;
    if ([deviceString isEqualToString:@"iPhone9,4"])    return false;
    return false;
    
}

+ (NSString *)appName {
  
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSString *appName = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
  
  if (!appName) {
    appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
  }
  
  return appName;
}



+ (NSString *)ipAddressWIFI {
  return [[UIDevice currentDevice] ipAddressWIFI];
}


+ (BOOL)isZHLanguage {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
  NSString *currentLanguage = [languages objectAtIndex:0];
  return [currentLanguage rangeOfString:@"zh"].length > 0;
}


+ (void)handleURL:(NSString *)url {
  
  NSString *ipIdentifi = @"connecttcpf:";
  if ([url hasPrefix:ipIdentifi]) {
    NSString *ipAddress = [url substringFromIndex:ipIdentifi.length];
    [self setValue:ipAddress forKey:kIPAddress];
  }
}

+ (BOOL)ipChange:(NSString *)value {
  NSString *userName = value;
  
  BOOL isChangeIP = [userName hasSuffix:kIPIdentification];
  if (isChangeIP) {
    userName = [userName stringByReplacingOccurrencesOfString:kIPIdentification withString:@""];
    [self setValue:userName forKey:kIPAddress];
    
    return YES;
  }
  
  return NO;
}


+ (void)windowScreenShot:(UIImage **)destImg {
  UIWindow *window = [UIApplication sharedApplication].keyWindow;
  
  // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
  UIGraphicsBeginImageContextWithOptions(window.frame.size, YES, 0.0);
  
  // 将cutView的图层渲染到上下文中
  [window.layer renderInContext:UIGraphicsGetCurrentContext()];
  
  *destImg = UIGraphicsGetImageFromCurrentImageContext(); // 取出UIImage
  UIGraphicsEndImageContext();// 千万记得,结束上下文
}


+ (NSDictionary *)plistContentWithName:(NSString *)fileName {
  NSString *pathFile = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
  NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:pathFile];
  
  return dic;
}


//+ (void)settingAppStyle {
//    if (system >= 8) {
//        [[UINavigationBar appearance] setTranslucent:NO];
//    }
//
//    UIImage *image = [UIImage imageWithColor:kNavigationBarColor];
//    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
//
//    NSDictionary *attributes = @{NSForegroundColorAttributeName:kNavigationBarTitleColor};
//    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
//}

+ (void)callPhone:(NSString *)phone {
  
  if ([UIApplication instancesRespondToSelector:@selector(canOpenURL:)]) {
    
    NSString *telNumber = [NSString stringWithFormat:@"tel:%@",phone];
    NSURL *aURL = [NSURL URLWithString:telNumber];
    
//      NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNum];
      
      /// 解决iOS10及其以上系统弹出拨号框延迟的问题
      /// 方案一
      if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
          /// 10及其以上系统
          
          if ([[UIDevice currentDevice].systemVersion floatValue] > 10.2) {

              [[UIApplication sharedApplication] openURL:aURL options:@{} completionHandler:nil];

          } else {

              UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:ISNIL(phone) preferredStyle:UIAlertControllerStyleAlert];
              
              UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                  
              }];
              
              UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                  
                  [[UIApplication sharedApplication] openURL:aURL options:@{} completionHandler:nil];
                  
              }];
              
              [alertController addAction:cancelAction];
              [alertController addAction:confirmAction];
              
              [kWindow.rootViewController presentViewController:alertController animated:true completion:nil];
              
          }
      
          
      } else {
          /// 10以下系统
          
          
          UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:ISNIL(phone) preferredStyle:UIAlertControllerStyleAlert];
          
          UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
              
          }];
          
          UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              
              [[UIApplication sharedApplication] openURL:aURL];
              
          }];
          
          [alertController addAction:cancelAction];
          [alertController addAction:confirmAction];
          
          [kWindow.rootViewController presentViewController:alertController animated:true completion:nil];
          
      }

  }
}

+ (BOOL)isCurrentMobileSystem10_2 {
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    if ([systemVersion compare:@"10.2" options:NSNumericSearch] == NSOrderedDescending || [systemVersion compare:@"10.2" options:NSNumericSearch] == NSOrderedSame) {
        return YES;
    }
    return NO;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)takeCurrentVC {
  
  UIWindow *window = [[UIApplication sharedApplication] keyWindow];
  
  return window.rootViewController;
}




+ (BOOL)hasCamera {
  
  return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
  [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

@end


@implementation JFTools (CCCUserDefaults)

+ (void)setValue:(id)value forKey:(NSString *)key {
  
  if (!value || key.length == 0) {
    NSLog(@"value or key is nil");
    //        DAssert(0);
    return;
  }
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setValue:value forKey:key];
  [defaults synchronize];
}

+ (id)objectForKey:(NSString *)key {
  
  if (key.length == 0) {
    NSLog(@"key is nil");
    //        DAssert(0);
    return nil;
  }
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  return ISNIL([defaults objectForKey:key]);
}

+(void)removeObjectForKey:(nonnull NSString *)key{
  if (key.length == 0) {
    NSLog(@"key is nil");
    //        DAssert(0);
    return ;
  }
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  [defaults removeObjectForKey:key];
  [defaults synchronize];
}
/************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 **********************************************************/
+ (NSData *)desEncrypt:(NSData *)data forKey:(NSString *)key {
  char keyPtr[kCCKeySizeAES256+1];
  bzero(keyPtr, sizeof(keyPtr));
  
  [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
  
  NSUInteger dataLength = [data length];
  
  size_t bufferSize = dataLength + kCCBlockSizeAES128;
  void *buffer = malloc(bufferSize);
  
  size_t numBytesEncrypted = 0;
  CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                        kCCOptionPKCS7Padding | kCCOptionECBMode,
                                        keyPtr, kCCBlockSizeDES,
                                        NULL,
                                        [data bytes], dataLength,
                                        buffer, bufferSize,
                                        &numBytesEncrypted);
  if (cryptStatus == kCCSuccess) {
    return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
  }
  
  free(buffer);
  return nil;
}

/************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 **********************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key {
  char keyPtr[kCCKeySizeAES256+1];
  bzero(keyPtr, sizeof(keyPtr));
  
  [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
  
  NSUInteger dataLength = [data length];
  
  size_t bufferSize = dataLength + kCCBlockSizeAES128;
  void *buffer = malloc(bufferSize);
  
  size_t numBytesDecrypted = 0;
  CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                        kCCOptionPKCS7Padding | kCCOptionECBMode,
                                        keyPtr, kCCBlockSizeDES,
                                        NULL,
                                        [data bytes], dataLength,
                                        buffer, bufferSize,
                                        &numBytesDecrypted);
  
  if (cryptStatus == kCCSuccess) {
    return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
  }
  
  free(buffer);
  return nil;
}


@end


@implementation JFTools (ChannelTools)

#define kKLShareToPlatFormUrl @"KLShareToPlatFormUrl"
#define kKLShareNet @"KLShareNet"
#define kKLChannel @"KLChannel"

+ (NSString *) shareToPlatFormURL {
  NSString *url = nil;
  
  NSDictionary *dic = [self channelFile];
  if (dic) {
    url = dic[kKLShareToPlatFormUrl];
  }
  
  return url;
}

+ (NSString *)shareAppURL {
  NSString *url = nil;
  
  NSDictionary *dic = [self channelFile];
  if (dic) {
    url = dic[kKLShareNet];
  }
  
  return url;
}


+ (NSArray *)channel {
  NSDictionary *dic = [self channelFile];
  NSArray *channel = dic[kKLChannel];
  return channel;
}


+ (NSDictionary *)channelFile {
  NSDictionary *dic = [self plistContentWithName:@"channel"];
  return dic;
}

@end


@implementation JFTools (UIViewTools)

+ (CGSize)autoCalculateRectWithTitle:(NSString*)title font:(CGFloat)font size:(CGSize)size;
{
  NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
  paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
  NSDictionary* attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font],
                               NSParagraphStyleAttributeName:paragraphStyle.copy};
  
  CGSize labelSize = [title boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                      attributes:attributes
                                         context:nil].size;
  labelSize.height = ceil(labelSize.height);
  labelSize.width = ceil(labelSize.width);
  return labelSize;
}


+ (CGSize)autoCalculateRectWithTitle:(NSString*)title
                                font:(CGFloat)font
                                size:(CGSize)size
                       lineBreakMode:(NSLineBreakMode)mode
{
  NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
  paragraphStyle.lineBreakMode = mode;
  NSDictionary* attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font],
                               NSParagraphStyleAttributeName:paragraphStyle.copy};
  
  CGSize labelSize = [title boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                      attributes:attributes
                                         context:nil].size;
  labelSize.height = ceil(labelSize.height);
  labelSize.width = ceil(labelSize.width);
  return labelSize;
}


@end

