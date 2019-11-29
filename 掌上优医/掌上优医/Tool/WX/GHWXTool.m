//
//  GHWXTool.m
//  掌上优医
//
//  Created by GH on 2018/11/2.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHWXTool.h"

@implementation GHWXTool

//+ (instancetype)shareInstance {
//
//    static GHWXTool *_tool;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _tool = [[GHWXTool alloc] init];
//    });
//    return _tool;
//
//}
//
//
////通过code获取access_token，openid，unionid
//- (void)getWeiXinOpenId:(NSString *)code{
//
//    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAppKey,kWXAppSecret,code];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL *zoneUrl = [NSURL URLWithString:url];
//        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
//        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (data){
//
//                GHWXModel *model = [[GHWXModel alloc] initWithData:data error:nil];
//
//                if (model.openid.length) {
//
//                    [GHUserModelTool shareInstance].wxAuthModel = model;
//
//                    [GHUserModelTool shareInstance].accessToken = model.access_token;
//
//                    [GHUserModelTool shareInstance].refreshToken = model.refresh_token;
//
//                    [GHUserModelTool shareInstance].openId = model.openid;
//
//                    [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
//
//                    [self getWeiXinUserInfo:model];
//
//                } else {
//
//                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//
//                    [SVProgressHUD showErrorWithStatus:ISNIL(dic[@"errmsg"])];
//
//                    NSLog(@"%@", dic);
//
//                }
//
//            }
//        });
//    });
//
//}
//
//
//- (void)getWeiXinUserInfo:(GHWXModel *)model {
//
//
//    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@&lang=zh_CN", ISNIL(model.access_token), ISNIL(model.openid)];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL *zoneUrl = [NSURL URLWithString:url];
//        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
//        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (data){
//
//                GHWXUserInfoModel *userInfoModel = [[GHWXUserInfoModel alloc] initWithData:data error:nil];
//
//                if (userInfoModel.openid.length) {
//
//                    // 微信登录成功, 应当去更新状态
//
//                    [GHUserModelTool shareInstance].wxUserInfoModel = userInfoModel;
//
//                    [GHUserModelTool shareInstance].isLogin = true;
//
//                    [GHUserModelTool shareInstance].isWechat = true;
//
//
//                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWeChatLoginSuccess object:nil];
//
//                } else {
//
//                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//
//                    if ([dic[@"errcode"] integerValue] == 40001 || [dic[@"errcode"] integerValue] == 42001 ) {
//                        //                    errcode = 40001,
//                        //                    errmsg =
//                        //
//                        // invalid credential, access_token is invalid or not latest, hints: [ req_id: IcQZ00442271 ]
//
//                        [self refreshAccessTokenWithRefreshToken:ISNIL(model.refresh_token)];
//
//                    } else {
//                        [SVProgressHUD showErrorWithStatus:ISNIL(dic[@"errmsg"])];
//                    }
//
//
//
//                    NSLog(@"%@", dic);
//
//
//                }
//
//            }
//        });
//    });
//
//}
//
//
//- (void)refreshAccessTokenWithRefreshToken:(NSString *)refreshToken {
//
//
//    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=%@&refresh_token=%@",kWXAppKey,@"refresh_token",refreshToken];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL *zoneUrl = [NSURL URLWithString:url];
//        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
//        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (data){
//
//                GHWXModel *model = [[GHWXModel alloc] initWithData:data error:nil];
//
//                if (model.openid.length) {
//
//                    [GHUserModelTool shareInstance].wxAuthModel = model;
//
//                    [GHUserModelTool shareInstance].accessToken = model.access_token;
//
//                    [GHUserModelTool shareInstance].refreshToken = model.refresh_token;
//
//                    [GHUserModelTool shareInstance].openId = model.openid;
//
//                    [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
//
//                    [self getWeiXinUserInfo:model];
//
//                } else {
//
//                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//
//                    [SVProgressHUD showErrorWithStatus:ISNIL(dic[@"errmsg"])];
//
//                    NSLog(@"%@", dic);
//
//                }
//
//            }
//        });
//    });
//
//
//}
//

@end
