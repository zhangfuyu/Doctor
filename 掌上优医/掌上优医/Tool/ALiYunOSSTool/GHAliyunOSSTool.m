//
//  GHAliyunOSSTool.m
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHAliyunOSSTool.h"
#import <AliyunOSSiOS.h>

@implementation GHAliyunOSSTool

+ (instancetype)shareInstance {
    
    static GHAliyunOSSTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[GHAliyunOSSTool alloc] init];
    });
    return _tool;
    
}

- (void)test {
    
    [OSSLog enableLog];     // 开启sdk的日志功能
    
    // 初始化
    
    NSString *endpoint = @"https://oss-cn-hangzhou.aliyuncs.com";
    
    // 移动端建议使用STS方式初始化OSSClient。可以通过sample中STS使用说明了解更多(https://github.com/aliyun/aliyun-oss-ios-sdk/tree/master/DemoByOC)
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:@"AccessKeyId" secretKeyId:@"AccessKeySecret" securityToken:@"SecurityToken"];
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    
    // 上传
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = @"<bucketName>";
    put.objectKey = @"<objectKey>";
    put.uploadingData = [NSData new]; // 直接上传NSData
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"upload object success!");
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    // 可以等待任务完成
    // [putTask waitUntilFinished];
    
    
}

@end
