//
//  GHUserModelTool.h
//  掌上优医
//
//  Created by GH on 2018/10/24.
//  Copyright © 2018 GH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHUserModelTool : NSObject

/**
 账号
 */
@property (nullable, nonatomic, copy) NSString *account;

/**
 token
 */
@property (nullable, nonatomic, copy) NSString *token;

/**
 是否已经登录
 */
@property (nonatomic, assign) BOOL isLogin;

/**
 是否是微信登录
 */
//@property (nonatomic, assign) BOOL isWechat;

@property (nonatomic, assign) BOOL isZheng;

/**
 推送ID
 */
@property (nullable, nonatomic, copy) NSString *registerId;

/**
 当前定位省
 */
@property (nullable, nonatomic, copy) NSString *locationprovince;

/**
 当前定位城市
 */
@property (nullable, nonatomic, copy) NSString *locationCity;

/**
 当前定位城市邮编
 */
@property (nullable, nonatomic, copy) NSString *locationCityCode;

/**
 当前定位城市区县
 */
@property (nullable, nonatomic, copy) NSString *locationCityArea;

/**
 当前定位区县邮编
 */
@property (nullable, nonatomic, copy) NSString *locationCityAreaCode;

/**
 经度
 */
@property (nonatomic, assign) CGFloat locationLongitude;

/**
 纬度
 */
@property (nonatomic, assign) CGFloat locationLatitude;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSArray *topicModelArray;

/**
 是否有网络
 */
@property (nonatomic, assign) BOOL isHaveNetwork;

/**
  是否拥有定位权限
 */
@property (nonatomic, assign) BOOL isHaveLocation;

@property (nullable, nonatomic, strong) GHUserInfoModel *userInfoModel;


+ (instancetype)shareInstance;

/**
 保存用户基本信息到沙盒
 */
- (void)saveUserDefaultToSandBox;

/**
 加载用户基本信息到沙盒
 */
- (void)loadUserDefaultToSandBox;

/**
 退出登录,清除所有用户信息属性
 */
- (void)removeAllProperty;


/**
 添加设备号
 */
- (void)kApiAddEquipmentCode;
@end

NS_ASSUME_NONNULL_END
