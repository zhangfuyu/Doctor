//
//  GHUploadPhotoTool.m
//  掌上优医
//
//  Created by GH on 2018/11/10.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHUploadPhotoTool.h"
#import <AliyunOSSiOS.h>
#import <CommonCrypto/CommonDigest.h>



@interface GHUploadPhotoTool ()

@property (nonatomic, strong) OSSClient *client;

@property (nonatomic, copy) NSString *ossAccessKeyId;

@property (nonatomic, copy) NSString *signature;

@end

@implementation GHUploadPhotoTool

+ (instancetype)shareInstance {
    
    static GHUploadPhotoTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[GHUploadPhotoTool alloc] init];
    });
    return _tool;
    
}

- (void)uploadVideoWithData:(NSData *)data completion:(uploadFinishBlock)completion {
    
    [SVProgressHUD showWithStatus:@"视频正在上传,请稍候..."];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"md5"] = [data md5String];
        
        [[GHNetworkTool shareInstance] requestUploadTokenWithUrl:kApiFileVideoName withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, NSString * _Nonnull response) {
            
            if (isSuccess && response.length > 0) {
                
                NSArray *array = [self getParamsWithUrlString:response];
                
                [[GHNetworkTool shareInstance] requestUploadWithUrl:response withParameter:nil withData:data completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull resp) {
                    
                    [SVProgressHUD dismiss];
                    
                    if (isSuccess) {
                        completion([array firstObject], nil);
                    }
                    
                }];

            }
            
        }];
        
        
    });
    
}

- (void)uploadImageWithImage:(UIImage *)image withMaxCapture:(NSUInteger)maxCapture type:(NSString *)type completion:(uploadFinishBlock)completion{

    [SVProgressHUD showWithStatus:@"图片正在上传,请稍候..."];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSData *data = [self compressWithMaxLength:(maxCapture * 1024) withImage:image];
        
        UIImage *thumbImage = [UIImage imageWithData:data];
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//        params[@"md5"] = [data md5String];
        
        NSMutableString *string = [[NSMutableString alloc]     initWithData:data encoding:NSUTF8StringEncoding];
        if (!string) {
            string = [[NSMutableString alloc]initWithData:[self cleanUTF8:data] encoding:NSUTF8StringEncoding];
        }
        params[@"file"] = data;
        
        params[@"fileType"] = type;
        
        [[GHNetworkTool shareInstance] requestUploadWithUrl:kApiProfilePicture withParameter:params withData:data completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
            if (isSuccess) {
                
                NSLog(@"------->%@",response);
                if (completion) {
                    completion(response[@"data"], thumbImage);
                }
            }
        }];
        
        


//        
//        [[GHNetworkTool shareInstance] requestUploadWithUrl:realUrl withParameter:nil withData:data completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull resp) {
//
//            [SVProgressHUD dismiss];
//
//            if (isSuccess) {
//
//                NSLog(@"---->");
//            }
//
//        }];

        
        
//        [[GHNetworkTool shareInstance] requestUploadTokenWithUrl:kApiProfilePicture withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, NSString * _Nonnull response) {
//
//            if (isSuccess && response.length > 0) {
//
//
//                completion(response, thumbImage);
//
//
//                NSArray *array = [self getParamsWithUrlString:response];
//
//                [[GHNetworkTool shareInstance] requestUploadWithUrl:response withParameter:nil withData:data completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull resp) {
//
//                    [SVProgressHUD dismiss];
//
//                    if (isSuccess) {
//                        completion([array firstObject], thumbImage);
//                    }
//
//                }];
//
//            }
//
//        }];


    });
    

}

- (NSData *)compressWithMaxLength:(NSUInteger)maxLength withImage:(UIImage *)image{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}


/**
 
 获取url中的参数并返回
 
 
 
 @param urlString 带参数的url
 
 @return @[NSString:无参数url, NSDictionary:参数字典]
 
 */

- (NSArray *)getParamsWithUrlString:(NSString *)urlString {
    
    if(urlString.length==0) {
        
        NSLog(@"链接为空！");
        
        return @[@"",@{}];
        
    }
    
    
    
    //先截取问号
    
    NSArray *allElements = [urlString componentsSeparatedByString:@"?"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//待set的参数字典
    
    
    
    if(allElements.count==2) {
        
        //有参数或者?后面为空
        
        NSString*myUrlString = allElements[0];
        
        NSString*paramsString = allElements[1];
        
        
        
        //获取参数对
        
        NSArray*paramsArray = [paramsString componentsSeparatedByString:@"&"];
        
        
        
        if(paramsArray.count>=2) {
            
            
            
            for(NSInteger i =0; i < paramsArray.count; i++) {
                
                
                
                NSString*singleParamString = paramsArray[i];
                
                NSArray*singleParamSet = [singleParamString componentsSeparatedByString:@"="];
                
                
                
                if(singleParamSet.count==2) {
                    
                    NSString*key = singleParamSet[0];
                    
                    NSString*value = singleParamSet[1];
                    
                    
                    
                    if(key.length>0|| value.length>0) {
                        
                        [params setObject:value.length>0?value:@""forKey:key.length>0?key:@""];
                        
                    }
                    
                }
                
            }
            
        }else if(paramsArray.count==1) {
            
            //无 &。url只有?后一个参数
            
            NSString*singleParamString = paramsArray[0];
            
            NSArray*singleParamSet = [singleParamString componentsSeparatedByString:@"="];
            
            
            
            if(singleParamSet.count==2) {
                
                NSString*key = singleParamSet[0];
                
                NSString*value = singleParamSet[1];
                
                
                
                if(key.length>0|| value.length>0) {
                    
                    [params setObject:value.length>0?value:@""forKey:key.length>0?key:@""];
                    
                }
                
            }else{
                
                //问号后面啥也没有 xxxx?  无需处理
                
            }
            
        }
        
        
        
        //整合url及参数
        
        return@[myUrlString,params];
        
    }else if(allElements.count>2) {
        
        NSLog(@"链接不合法！链接包含多个\"?\"");
        
        return @[@"",@{}];
        
    }else{
        
        NSLog(@"链接不包含参数！");
        
        return@[urlString,@{}];
        
    }
    
    
    
}


- (NSData *)cleanUTF8:(NSData *)data {
    //保存结果
    NSMutableData *resData = [[NSMutableData alloc] initWithCapacity:data.length];
    
    NSData *replacement = [@"" dataUsingEncoding:NSUTF8StringEncoding]; //[NSString stringWithUTF8String:[dataa bytes]];
    
    uint64_t index = 0;
    const uint8_t *bytes = data.bytes;
    
    long dataLength = (long) data.length;
    
    while (index < dataLength) {
        uint8_t len = 0;
        uint8_t firstChar = bytes[index];
        
        // 1个字节
        if ((firstChar & 0x80) == 0 && (firstChar == 0x09 || firstChar == 0x0A || firstChar == 0x0D || (0x20 <= firstChar && firstChar <= 0x7E))) {
            len = 1;
        }
        // 2字节
        else if ((firstChar & 0xE0) == 0xC0 && (0xC2 <= firstChar && firstChar <= 0xDF)) {
            if (index + 1 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                if (0x80 <= secondChar && secondChar <= 0xBF) {
                    len = 2;
                }
            }
        }
        // 3字节
        else if ((firstChar & 0xF0) == 0xE0) {
            if (index + 2 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                uint8_t thirdChar = bytes[index + 2];
                
                if (firstChar == 0xE0 && (0xA0 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                } else if (((0xE1 <= firstChar && firstChar <= 0xEC) || firstChar == 0xEE || firstChar == 0xEF) && (0x80 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                } else if (firstChar == 0xED && (0x80 <= secondChar && secondChar <= 0x9F) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                }
            }
        }
        // 4字节
        else if ((firstChar & 0xF8) == 0xF0) {
            if (index + 3 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                uint8_t thirdChar = bytes[index + 2];
                uint8_t fourthChar = bytes[index + 3];
                
                if (firstChar == 0xF0) {
                    if ((0x90 <= secondChar & secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                } else if ((0xF1 <= firstChar && firstChar <= 0xF3)) {
                    if ((0x80 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                } else if (firstChar == 0xF3) {
                    if ((0x80 <= secondChar && secondChar <= 0x8F) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                }
            }
        }
        // 5个字节
        else if ((firstChar & 0xFC) == 0xF8) {
            len = 0;
        }
        // 6个字节
        else if ((firstChar & 0xFE) == 0xFC) {
            len = 0;
        }
        
        if (len == 0) {
            index++;
            [resData appendData:replacement];
        } else {
            [resData appendBytes:bytes + index length:len];
            index += len;
        }
    }
    
    return resData;
}



@end
