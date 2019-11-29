//
//  GHWXModel.h
//  掌上优医
//
//  Created by GH on 2018/11/2.
//  Copyright © 2018 GH. All rights reserved.
//
//  弃用

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHWXModel : JSONModel

/**
 接口调用凭证
 */
@property (nonatomic, copy) NSString<Optional> *access_token;

/**
 access_token接口调用凭证超时时间，单位（秒）
 */
@property (nonatomic, copy) NSString<Optional> *expires_in;

/**
 授权用户唯一标识
 */
@property (nonatomic, copy) NSString<Optional> *openid;

/**
 用户刷新access_token
 */
@property (nonatomic, copy) NSString<Optional> *refresh_token;

/**
 用户授权的作用域，使用逗号（,）分隔
 */
@property (nonatomic, copy) NSString<Optional> *scope;

@property (nonatomic, copy) NSString<Optional> *unionid;

@end

NS_ASSUME_NONNULL_END
