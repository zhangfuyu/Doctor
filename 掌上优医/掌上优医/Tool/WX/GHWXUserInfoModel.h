//
//  GHWXUserInfoModel.h
//  掌上优医
//
//  Created by GH on 2018/11/2.
//  Copyright © 2018 GH. All rights reserved.
//
//  弃用

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHWXUserInfoModel : JSONModel

/**
 普通用户的标识，对当前开发者帐号唯一
 */
@property (nonatomic, copy) NSString<Optional> *openid;

/**
 普通用户个人资料填写的城市
 */
@property (nonatomic, copy) NSString<Optional> *city;

/**
 国家，如中国为CN
 */
@property (nonatomic, copy) NSString<Optional> *country;

/**
 普通用户昵称
 */
@property (nonatomic, copy) NSString<Optional> *nickname;

/**
 用户特权信息，json数组，如微信沃卡用户为（chinaunicom）
 */
@property (nonatomic, strong) NSArray<Optional> *privilege;

@property (nonatomic, copy) NSString<Optional> *language;

@property (nonatomic, copy) NSString<Optional> *access_token;

/**
 用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空
 */
@property (nonatomic, copy) NSString<Optional> *headimgurl;

/**
 用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。
 */
@property (nonatomic, copy) NSString<Optional> *unionid;

/**
 普通用户性别，1为男性，2为女性
 */
@property (nonatomic, copy) NSString<Optional> *sex;

/**
 省份
 */
@property (nonatomic, copy) NSString<Optional> *province;

@end

NS_ASSUME_NONNULL_END
