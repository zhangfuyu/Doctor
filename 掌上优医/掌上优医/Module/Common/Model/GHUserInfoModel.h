//
//  GHUserInfoModel.h
//  掌上优医
//
//  Created by GH on 2018/11/12.
//  Copyright © 2018 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHUserInfoModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *gmtCreate;

@property (nonatomic, copy) NSString<Optional> *gmtLastLogin;

@property (nonatomic, copy) NSString<Optional> *gmtModified;

@property (nonatomic, copy) NSString<Optional> *modelId;


@property (nonatomic, copy) NSString<Optional> *status;//身高

@property (nonatomic, copy) NSString<Optional> *userType;

@property (nonatomic, copy) NSString<Optional> *wxId;

/**
 余额
 */
@property (nonatomic, copy) NSString<Optional> *virtualCoinBalance;

/**
 体重（千克）
 */
@property (nonatomic, copy) NSString<Optional> *avoirdupois;

/**
 出生日期
 */
@property (nonatomic, copy) NSString<Optional> *birthday;

/**
 邀请人数
 */
@property (nonatomic, copy) NSString<Optional> *inviteeCount;

/**
 手机号
 */
@property (nonatomic, copy) NSString<Optional> *phoneNum;

@property (nonatomic, copy) NSString<Optional> *showPhoneNum;

@property (nonatomic, copy) NSString<Optional> *nickName;

@property (nonatomic, copy) NSString<Optional> *profilePhoto;

/**
 性别 0：未知 1：女 2：男
 */
@property (nonatomic, copy) NSString<Optional> *sex;


/**
 身高（厘米）
 */
@property (nonatomic, copy) NSString<Optional> *stature;



/***************add by zhangfuy*************/

/**
头像地址
 */
@property (nonatomic, copy) NSString<Optional> *avatar;

/**
 体重
 */
@property (nonatomic, copy) NSString<Optional> *weight;


/**
生日 日期型格式
 */

@end

NS_ASSUME_NONNULL_END
