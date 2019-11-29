//
//  GHUserModelTool.m
//  掌上优医
//
//  Created by GH on 2018/10/24.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHUserModelTool.h"


NSString *const kUserDefault_Account = @"kUserDefault_Account";
NSString *const kUserDefault_Token = @"kUserDefault_Token";

@implementation GHUserModelTool

+ (instancetype)shareInstance {
    
    static GHUserModelTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[GHUserModelTool alloc] init];
        _tool.isHaveNetwork = true;
    });
    return _tool;
    
}

//- (void)setIsHaveNetwork:(BOOL)isHaveNetwork {
//    
//    if (isHaveNetwork == true) {
//        
//        if (isHaveNetwork != _isHaveNetwork) {
//            
//            if ([GHUserModelTool shareInstance].isLogin == true) {
//                
//                // 如果已经登录
//                
//                if ([GHUserModelTool shareInstance].userInfoModel == nil) {
//                    
//                    // 但是没有用户信息
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        
//                        if ([GHUserModelTool shareInstance].userInfoModel == nil) {
//                        
//                            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiUserMe withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
//                                
//                                if (isSuccess) {
//                                    
//                                    [GHUserModelTool shareInstance].userInfoModel = [[GHUserInfoModel alloc] initWithDictionary:response error:nil];
//                                    
//                                    if ([GHUserModelTool shareInstance].userInfoModel == nil || [[GHUserModelTool shareInstance].userInfoModel.status intValue] == 2) {
//                                        
//                                        [[GHUserModelTool shareInstance] removeAllProperty];
//                                        
//                                        [GHUserModelTool shareInstance].isLogin = false;
//                                        
//                                        [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
//                                        
//                                        [[GHSaveDataTool shareInstance] userLogoutRemoveAllNotice];
//                                        
//                                    }
//                                    
//                                    
//                                } else {
//                                    
//                                }
//                                
//                            }];
//                            
//                        }
//                        
//                    });
//                    
//                }
//                
//            }
//            
//        }
//        
//    }
//    
//    _isHaveNetwork = isHaveNetwork;
//    
//}

- (void)loadUserDefaultToSandBox {
    
    self.account = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefault_Account];
    self.token = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefault_Token];
    
    if (self.token.length > 0) {
        [GHUserModelTool shareInstance].isLogin = true;
    }
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiGetUserMe withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        
        if (isSuccess) {
            
            [GHUserModelTool shareInstance].userInfoModel = [[GHUserInfoModel alloc] initWithDictionary:response[@"data"] error:nil];
            
    
            [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
            
            [[GHSaveDataTool shareInstance] userLogoutRemoveAllNotice];
        }
    }];
    
    
    
}

- (void)saveUserDefaultToSandBox {
    
    [[NSUserDefaults standardUserDefaults] setObject:ISNIL([GHUserModelTool shareInstance].account) forKey:kUserDefault_Account];
    
    [[NSUserDefaults standardUserDefaults] setObject:ISNIL([GHUserModelTool shareInstance].token) forKey:kUserDefault_Token];
    
}

- (void)removeAllProperty {
    
    self.account = nil;
    self.token = nil;
    
    self.userInfoModel = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefault_Account];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefault_Token];
    
}

- (void)setToken:(NSString *)token {
    
    _token = token;
    
    self.isLogin = token.length;
    
}

- (void)setRegisterId:(NSString *)registerId {
    
    _registerId = registerId;
    
    if (registerId.length > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self bindingPushDevAction];
        });
    }
    
}

- (void)bindingPushDevAction {
    
    if ([GHUserModelTool shareInstance].registerId.length) {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"devId"] = [GHUserModelTool shareInstance].registerId;
        
        // 上报设备 ID
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiPushDev withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            //            if (isSuccess) {
            
            if ([GHUserModelTool shareInstance].isLogin) {
                [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiPushDevUser withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
                    
                    if (isSuccess) {
                        
                        NSLog(@"设备 ID 绑定成功");
                        
                    } else {
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_DELETE withUrl:kApiPushDevUser withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                                
                                if (isSuccess) {
                                    
                                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiPushDevUser withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                                        
                                        if (isSuccess) {
                                            NSLog(@"设备 ID 绑定成功");
                                        }
                                        
                                    }];
                                    
                                }
                                
                            }];
                            
                        });
                        
                    }
                    
                }];
            }
            

            
            //            }
            
        }];
        
    }
    
}
- (void)kApiAddEquipmentCode
{
    NSString *oneUdid = UDID;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiAddEquipmentCode withParameter:@{@"equipmentCode":UDID} withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        if (isSuccess) {
            
            NSLog(@"设备ID上传成功");
        }
    }];
    
}

@end
