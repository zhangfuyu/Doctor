//
//  GHNetworkTool.m
//  掌上优医
//
//  Created by GH on 2018/10/23.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHNetworkTool.h"
#import <SVProgressHUD.h>
#import <AFNetworkActivityIndicatorManager.h>
#import <ASIHTTPRequest.h>

// 开发环境

//static const NSString *ipAddress = @"http://apidev.zsu1.com";
//static const NSString *htmlAddress = @"http://apidev.zsu1.com/";

//static const NSString *ipAddress = @"https://apidev.zsu1.com";
//static const NSString *htmlAddress = @"https://apidev.zsu1.com/";

// 线上环境
//
//static const NSString *ipAddress = @"http://dzxyapi.zsu1.com/";
//static const NSString *htmlAddress = @"http://share.zsu1.com/";

// 对接环境
//
//static const NSString *ipAddress = @"http://192.168.77.198:8000/";
//
//static const NSString *htmlAddress = @"http://192.168.77.198:8082/";

// 测试环境
////
static const NSString *ipAddress = @"http://121.40.223.138:8000/";
//////static const NSString *ipAddress = @"http://192.168.0.115:8080";
static const NSString *htmlAddress = @"http://121.40.223.138:8080/";



@interface GHNetworkTool ()<ASIHTTPRequestDelegate>


@property (nonatomic, copy) completionBlock uploadBlock;

@property (nonatomic, assign) BOOL isStop;

/**
 时间戳
 */
@property (nonatomic, strong) NSString *timeStamp;

@end

@implementation GHNetworkTool

+ (instancetype)shareInstance {
    
    static GHNetworkTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[GHNetworkTool alloc] init];
        [_tool setupSessionManage];
    });
    return _tool;
    
}

/**
 设置请求基本信息
 */
- (void)setupSessionManage {
    
    self.isStop = false;
    
    self.sessionManager = [AFHTTPSessionManager manager];
    self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.sessionManager.requestSerializer.timeoutInterval = 20;
    
    self.sessionManager.operationQueue.maxConcurrentOperationCount = 1;
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
   
    
}

- (void)requestUploadTokenWithUrl:(NSString *)url withParameter:(NSDictionary *)parameter withLoadingType:(GHLoadingType)loadingType withShouldHaveToken:(BOOL)shouldHaveToken completionBlock:(completionBlock)completionBlock {
    
    NSString *realUrl = [NSString stringWithFormat:@"%@%@", ipAddress, url];
    
    self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [self.sessionManager GET:realUrl parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
            [self requestSuccessWithUrl:url withResponseObject:str completionBlock:completionBlock];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestFailureWithMethod:GHRequestMethod_GET withUrl:url withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:GHContentType_JSON withError:error withTask:task withCompletionBlock:completionBlock];
        
    }];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    NSLog(@"完成");
    
    if (request.responseStatusCode == 200) {
        self.uploadBlock(true, nil, nil);
    } else {
        [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    
    NSLog(@"失败");
    
    [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
    
}

//- (void)requestUploadWithUrl:(NSString *)url withParameter:(NSDictionary *)parameter withData:(NSData *)data completionBlock:(completionBlock)completionBlock {
//
//    ASIHTTPRequest * fileUpRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//
//    fileUpRequest.delegate = self;
//    //设置请求超时时间为60秒
//    [fileUpRequest setTimeOutSeconds:60.f];
//    //设置请求超时时间后再次尝试请求的次数
//    [fileUpRequest setNumberOfTimesToRetryOnTimeout:2];
//    //将data拼接进去
//    [fileUpRequest appendPostData:data];
//
//    [fileUpRequest setRequestHeaders:[@{@"Content-Type" : @"application/octet-stream"} mutableCopy]];
//    //设置请求方式为PUT
//    [fileUpRequest setRequestMethod:@"POST"];
//    //显示精确的上传进度
//    fileUpRequest.showAccurateProgress = false;
//    //开始异步请求
//    [fileUpRequest startAsynchronous];
//
//    self.uploadBlock = completionBlock;
//
//}
- (void)requestUploadWithUrl:(NSString *)url withParameter:(NSDictionary *)parameter withData:(NSData *)data completionBlock:(completionBlock)completionBlock {
    
    NSString *realUrl;
    
    if ([url hasPrefix:@"http"]) {
        realUrl = url;
    } else {
        realUrl = [NSString stringWithFormat:@"%@%@", ipAddress, url];
    }
    if ([GHUserModelTool shareInstance].isLogin == true) {
        [self.sessionManager.requestSerializer setValue:ISNIL([GHUserModelTool shareInstance].token)
                                     forHTTPHeaderField:@"Authorization"];
        NSLog(@"------->%@",[GHUserModelTool shareInstance].token);
    }
    
    [self.sessionManager POST:realUrl parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        
        //                NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
        /*
         *该方法的参数
         1. appendPartWithFileData：要上传的照片[二进制流]
         2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
         3. fileName：要保存在服务器上的文件名
         4. mimeType：上传的文件的类型
         */
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"]; //
    }progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"progress is %@",uploadProgress);
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        id jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
            
            if (jsonDic) {
                [self requestSuccessWithUrl:url withResponseObject:jsonDic completionBlock:completionBlock];
            } else {
                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                
                if (str.length) {
                    [self requestSuccessWithUrl:url withResponseObject:ISNIL(str) completionBlock:completionBlock];
                } else {
                    [self requestSuccessWithUrl:url withResponseObject:nil completionBlock:completionBlock];
                }
                
                
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
     [self requestFailureWithMethod:GHRequestMethod_GET withUrl:url withParameter:parameter withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_JSON withError:error withTask:task withCompletionBlock:completionBlock];
        
    }];
    

    
}
- (void)requestWithMethod:(GHRequestMethod)method withUrl:(NSString *)url withParameter:(NSDictionary *)parameter withLoadingType:(GHLoadingType)loadingType withShouldHaveToken:(BOOL)shouldHaveToken withContentType:(GHContentType)contentType completionBlock:(completionBlock)completionBlock {
    
    NSString *realUrl;
    
    if ([url hasPrefix:@"http"]) {
        realUrl = url;
    } else {
        realUrl = [NSString stringWithFormat:@"%@%@", ipAddress, url];
    }
    
    if (contentType == GHContentType_JSON) {
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    } else if (contentType == GHContentType_Formdata) {
        self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [self.sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    }
    
    if (shouldHaveToken == true && [GHUserModelTool shareInstance].isLogin == true) {
        [self.sessionManager.requestSerializer setValue:ISNIL([GHUserModelTool shareInstance].token)
                                     forHTTPHeaderField:@"Authorization"];
        NSLog(@"------->%@",[GHUserModelTool shareInstance].token);
    }
    
    [self.sessionManager.requestSerializer setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
    
    self.sessionManager.requestSerializer.timeoutInterval = 20;
    
    NSLog(@"---------------duoshaoge");
    
    if (method == GHRequestMethod_GET) {
        
        [self requestGETWithUrl:realUrl withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType completionBlock:completionBlock];
        
    } else if (method == GHRequestMethod_POST) {
        
        [self requestPOSTWithUrl:realUrl withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType completionBlock:completionBlock];
        
    } else if (method == GHRequestMethod_PUT) {

        [self requestPUTWithUrl:realUrl withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType completionBlock:completionBlock];
        
    } else if (method == GHRequestMethod_DELETE) {

        [self requestDELETEWithUrl:realUrl withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType completionBlock:completionBlock];
        
    }
    
}

- (void)requestGETWithUrl:(NSString *)url withParameter:(NSDictionary *)parameter withLoadingType:(GHLoadingType)loadingType withShouldHaveToken:(BOOL)shouldHaveToken withContentType:(GHContentType)contentType  completionBlock:(completionBlock)completionBlock {

    [self.sessionManager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        id jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
 
        if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
            
            if (jsonDic) {
                [self requestSuccessWithUrl:url withResponseObject:jsonDic completionBlock:completionBlock];
            } else {
                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                
                if (str.length) {
                    [self requestSuccessWithUrl:url withResponseObject:ISNIL(str) completionBlock:completionBlock];
                } else {
                    [self requestSuccessWithUrl:url withResponseObject:nil completionBlock:completionBlock];
                }
                
                
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestFailureWithMethod:GHRequestMethod_GET withUrl:url withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType withError:error withTask:task withCompletionBlock:completionBlock];
        
    }];

}

- (void)requestPOSTWithUrl:(NSString *)url withParameter:(NSDictionary *)parameter withLoadingType:(GHLoadingType)loadingType withShouldHaveToken:(BOOL)shouldHaveToken withContentType:(GHContentType)contentType  completionBlock:(completionBlock)completionBlock {
    
    [self.sessionManager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
            [self requestSuccessWithUrl:url withResponseObject:jsonDic completionBlock:completionBlock];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [self requestFailureWithMethod:GHRequestMethod_POST withUrl:url withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType withError:error withTask:task withCompletionBlock:completionBlock];
        
    }];
    
}

- (void)requestPUTWithUrl:(NSString *)url withParameter:(NSDictionary *)parameter withLoadingType:(GHLoadingType)loadingType withShouldHaveToken:(BOOL)shouldHaveToken withContentType:(GHContentType)contentType  completionBlock:(completionBlock)completionBlock {
    
    [self.sessionManager PUT:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
            [self requestSuccessWithUrl:url withResponseObject:jsonDic completionBlock:completionBlock];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestFailureWithMethod:GHRequestMethod_PUT withUrl:url withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType withError:error withTask:task withCompletionBlock:completionBlock];

    }];
    
}

- (void)requestDELETEWithUrl:(NSString *)url withParameter:(NSDictionary *)parameter withLoadingType:(GHLoadingType)loadingType withShouldHaveToken:(BOOL)shouldHaveToken withContentType:(GHContentType)contentType  completionBlock:(completionBlock)completionBlock {
    
    [self.sessionManager DELETE:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
            [self requestSuccessWithUrl:url withResponseObject:jsonDic completionBlock:completionBlock];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestFailureWithMethod:GHRequestMethod_DELETE withUrl:url withParameter:parameter withLoadingType:loadingType withShouldHaveToken:shouldHaveToken withContentType:contentType withError:error withTask:task withCompletionBlock:completionBlock];
        
    }];
    
}

/**
 连接服务器成功

 @param url <#url description#>
 @param responseObject <#responseObject description#>
 */
- (void)requestSuccessWithUrl:(NSString *)url withResponseObject:(id)responseObject  completionBlock:(completionBlock)completionBlock{
    
    completionBlock(true, @"成功" , responseObject);
    
}
//
/**
 连接服务器失败

 @param url <#url description#>
 @param error <#error description#>
 */
- (void)requestFailureWithMethod:(GHRequestMethod)method withUrl:(NSString *)url withParameter:(NSDictionary *)parameter withLoadingType:(GHLoadingType)type withShouldHaveToken:(BOOL)shouldHaveToken withContentType:(GHContentType)contentType withError:(NSError *)error withTask:(NSURLSessionDataTask *)task withCompletionBlock:(completionBlock)completionBlock {
    
    
    // 不需要弹出错误提示
    if (type == GHLoadingType_HideLoading) {

        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        completionBlock(false, [NSString stringWithFormat:@"%ld - %@", ((NSHTTPURLResponse *)task.response).statusCode, ISNIL(str)], nil);
        NSLog(@"%@---------%@", url, str);

        return;
    }
    
    
    completionBlock(false, [NSString stringWithFormat:@"%ld", ((NSHTTPURLResponse *)task.response).statusCode], nil);
    
    if ([url hasSuffix:kApiSystemparamVerStatus]) {
        [SVProgressHUD dismiss];
        return;
    }
    
    if (((NSHTTPURLResponse *)task.response).statusCode == 401) {
        
        // 账号密码错误或登录已失效, 登录已失效则需要弹出登录页面
        
        UIViewController *vc = [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
        
        // 如果不是在登录页,在其他页面则代表登录失效
        if (![vc isKindOfClass:[GHNLoginViewController class]]) {
            
            [SVProgressHUD showErrorWithStatus:@"登录已失效,请重新登录"];
            
            [[GHUserModelTool shareInstance] removeAllProperty];
            
            [GHUserModelTool shareInstance].isLogin = false;
            
            [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
            
            [[GHSaveDataTool shareInstance] userLogoutRemoveAllNotice];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
            
            GHNLoginViewController *loginVC = [[GHNLoginViewController alloc] init];
            [vc presentViewController:loginVC animated:false completion:nil];
            
            self.isStop = true;
            
            if ([GHUserModelTool shareInstance].registerId.length) {
                
                NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                params[@"devId"] = [GHUserModelTool shareInstance].registerId;
                
                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_DELETE withUrl:kApiPushDevUser withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                    
                    if (isSuccess) {
                        
                        NSLog(@"设备 ID 解除绑定成功");
                        
                    }
                    
                }];
                
            }
            
            return;
            
        }
        
        if (self.isStop) {
            return;
        }
        
    } else if (((NSHTTPURLResponse *)task.response).statusCode == 403) {
        
        
        UIViewController *vc = [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
        
            
        [SVProgressHUD showErrorWithStatus:@"登录已失效,请重新登录"];
        
        [[GHUserModelTool shareInstance] removeAllProperty];
        
        [GHUserModelTool shareInstance].isLogin = false;
        
        [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
        
        [[GHSaveDataTool shareInstance] userLogoutRemoveAllNotice];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
        
        GHNLoginViewController *loginVC = [[GHNLoginViewController alloc] init];
        [vc presentViewController:loginVC animated:false completion:nil];
        
        self.isStop = true;
        
        if ([GHUserModelTool shareInstance].registerId.length) {
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"devId"] = [GHUserModelTool shareInstance].registerId;
            
            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_DELETE withUrl:kApiPushDevUser withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                
                if (isSuccess) {
                    
                    NSLog(@"设备 ID 解除绑定成功");
                    
                }
                
            }];
            
        }
        
        return;
        
    } else if (((NSHTTPURLResponse *)task.response).statusCode == 502) {
        
        self.isStop = false;
        
        [SVProgressHUD showErrorWithStatus:@"服务不可用,请稍候重试"];
        
        return;
        
    } else if (((NSHTTPURLResponse *)task.response).statusCode == 503) {
        
        // 错误码 503 重新发送请求
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[GHNetworkTool shareInstance] requestWithMethod:method withUrl:url withParameter:parameter withLoadingType:type withShouldHaveToken:shouldHaveToken withContentType:contentType completionBlock:completionBlock];
            
        });
        
    }
    
    self.isStop = false;
    
    NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    
    if (data) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        
        if (str.length) {
            
            if ([str isEqualToString:@"重复记录"] && ([url hasSuffix:kApiMyFavoriteDoctor] || [url hasSuffix:kApiMyFavoriteCircle])) {
                // 已经收藏过圈子/医生,请勿重复收藏
//                [SVProgressHUD showErrorWithStatus:@"您已收藏,请勿重复收藏"];
            } else {
                
                if ([str isEqualToString:@"访问太频繁"]) {
                    
                } else {
//                    [SVProgressHUD showErrorWithStatus:ISNIL(str)];
                }
                
            }
            
        } else {
            
//            [SVProgressHUD showErrorWithStatus:@"请检查您的网络设置"];
            NSLog(@"================%@=================",url);
            
        }
        
    } else {
        
//        [SVProgressHUD showErrorWithStatus:@"请检查您的网络设置"];
        NSLog(@"================%@=================",url);
        
    }
    
    

    
}

/**
 取消所有网络请求
 */
- (void)cancelRequest{
    [[self.sessionManager operationQueue] cancelAllOperations];
}

/**
 监测网络
 */
+ (void)detectNetworkAction {
    
    [GHUserModelTool shareInstance].isHaveNetwork = false;
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                //未知网络
                NSLog(@"未知网络");
                [GHUserModelTool shareInstance].isHaveNetwork = true;
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                //无法联网
                NSLog(@"无法联网");
                [GHUserModelTool shareInstance].isHaveNetwork = false;
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //手机自带网络
                NSLog(@"当前使用的是2g/3g/4g网络");
                [GHUserModelTool shareInstance].isHaveNetwork = true;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //WIFI
                NSLog(@"当前在WIFI网络下");
                [GHUserModelTool shareInstance].isHaveNetwork = true;
            }
                
        }
    }];
    
}




- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

- (NSString *)getUserProtocolURL {
    return [NSString stringWithFormat:@"%@%@", htmlAddress, @"protocolInfo.html"];
}
- (NSString *)getGdisclaimerURL
{
    return [NSString stringWithFormat:@"%@%@", htmlAddress, @"relief.html"];

}
- (NSString *)getNewsArticlesURLisShareid:(NSString *)idStr share:(BOOL)isShare
{
    if (isShare) {
 
        return [NSString stringWithFormat:@"%@%@?id=%@&notApp=1", htmlAddress, @"articleInfo.html", idStr];
    }
    else
    {
         return [NSString stringWithFormat:@"%@%@?id=%@", htmlAddress, @"articleInfo.html", idStr];
    }
    return nil;
}
- (NSString *)getShareWebViewWith:(NSString *)text
{
    return [NSString stringWithFormat:@"%@%@", htmlAddress, text];

}
- (NSString *)getPrivacyPolicyURL {
    return [NSString stringWithFormat:@"%@%@", htmlAddress, @"privacyInfo.html"];
}

- (NSString *)getDoctorDetailURLWithDoctorId:(NSString *)doctorId {
    return [NSString stringWithFormat:@"%@%@?doctorId=%@", htmlAddress, @"doctorInfo.html", doctorId];
}

- (NSString *)getHospitalDetailURLWithHospitalId:(NSString *)hospitalId {
    return [NSString stringWithFormat:@"%@%@?hospitalId=%@", htmlAddress, @"hospitalInfo.html", hospitalId];
}

- (NSString *)getSicknessDetailURLWithSicknessId:(NSString *)sicknessId {
    return [NSString stringWithFormat:@"%@%@?diseaseId=%ld", htmlAddress, @"diseaseInfo.html", [sicknessId longValue]];
}

- (NSString *)getArticleDetailURLWithArticleId:(NSString *)articleId {
    return [NSString stringWithFormat:@"%@%@?articleId=%@", htmlAddress, @"articleInfo.html", articleId];
}

- (NSString *)getProductDetailURLWithProductId:(NSString *)productId {
    return [NSString stringWithFormat:@"%@%@?commodityId=%ld", htmlAddress, @"commodityInfo.html", [productId longValue]];
}

- (NSString *)getRecommendCodeURLWithCode:(NSString *)code {
    return [[NSString stringWithFormat:@"%@%@?code=%@&nickName=%@", htmlAddress, @"invitefriends.html", ISNIL(code), ISNIL([GHUserModelTool shareInstance].userInfoModel.nickName).length ? [GHUserModelTool shareInstance].userInfoModel.nickName : [NSString stringWithFormat:@"%@",ISNIL([GHUserModelTool shareInstance].userInfoModel.showPhoneNum)]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
