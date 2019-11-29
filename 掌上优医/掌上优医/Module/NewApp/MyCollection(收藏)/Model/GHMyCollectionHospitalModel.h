//
//  GHMyCollectionHospitalModel.h
//  掌上优医
//
//  Created by GH on 2019/2/21.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHMyCollectionHospitalModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *modelId;

@property (nonatomic, copy) NSString<Optional> *contentInfo;

@property (nonatomic, copy) NSString<Optional> *contentType;

@property (nonatomic, copy) NSString<Optional> *contentId;


/**
 医院类型：综合医院 中医医院 儿童医院 妇产医院 皮肤病医院 整形医院 口腔医院
 */
@property (nonatomic, copy) NSString<Optional> *category;

/**
 string
 特色科室，按分隔符分割多个科室名
 */
@property (nonatomic, copy) NSString<Optional> *choiceDepartments;

/**
 市编码
 */
@property (nonatomic, copy) NSString<Optional> *city;

/**
 联系电话
 */
@property (nonatomic, copy) NSString<Optional> *contactNumber;

/**
 区县编码
 */
@property (nonatomic, copy) NSString<Optional> *county;

/**
 所属国家编码
 */
@property (nonatomic, copy) NSString<Optional> *country;

/**
 距离 用户到医院的距离,单位是米
 */
@property (nonatomic, copy) NSString<Optional> *distance;

/**
 string
 创建时间
 */
@property (nonatomic, copy) NSString<Optional> *gmtCreate;

/**
 
 */
@property (nonatomic, copy) NSString<Optional> *gmtModified;

/**
 string
 医院等级 2-30字符
 */
@property (nonatomic, copy) NSString<Optional> *grade;

/**
 医院地址
 */
@property (nonatomic, copy) NSString<Optional> *hospitalAddress;

/**
 医院名称
 */
@property (nonatomic, copy) NSString<Optional> *hospitalName;

/**
 医院介绍
 */
@property (nonatomic, copy) NSString<Optional> *introduction;

/**
 医院所在位置纬度 高德地图 格式 -10.238776
 */
@property (nonatomic, copy) NSString<Optional> *lat;

/**
 医院所在位置经度 高德地图 格式 120.234576
 */
@property (nonatomic, copy) NSString<Optional> *lng;

/**
 是否医保 0：否 1：是
 */
@property (nonatomic, copy) NSString<Optional> *medicalInsuranceFlag;

/**
 医院相册
 */
@property (nonatomic, copy) NSString<Optional> *pictures;

/**
 医院头像
 */
@property (nonatomic, copy) NSString<Optional> *profilePhoto;

/**
 省编码
 */
@property (nonatomic, copy) NSString<Optional> *province;

@property (nonatomic, copy) NSString<Optional> *totalCount;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *collectionId;


@end

NS_ASSUME_NONNULL_END
