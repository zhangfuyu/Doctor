//
//  GHNHospitalRecordModel.h
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNHospitalRecordModel : JSONModel <NSCoding>

/**
 医院类型：综合医院 中医医院 儿童医院 妇产医院 皮肤病医院 整形医院 口腔医院
 */
@property (nonatomic, copy) NSString *category;

/**
 string
 特色科室，按分隔符分割多个科室名
 */
@property (nonatomic, copy) NSString *choiceDepartments;

/**
 联系电话
 */
@property (nonatomic, copy) NSString *contactNumber;

/**
 string
 医院等级 2-30字符
 */
@property (nonatomic, copy) NSString *grade;

/**
 医院地址
 */
@property (nonatomic, copy) NSString *hospitalAddress;

/**
 医院名称
 */
@property (nonatomic, copy) NSString *hospitalName;

/**
 医院ID
 */
@property (nonatomic, copy) NSString *modelId;

/**
 医院介绍
 */
@property (nonatomic, copy) NSString *introduction;

/**
 是否医保 0：否 1：是
 */
@property (nonatomic, copy) NSString *medicalInsuranceFlag;

/**
 医院相册
 */
@property (nonatomic, copy) NSString *pictures;

/**
 医院头像
 */
@property (nonatomic, copy) NSString *profilePhoto;

@property (nonatomic, copy) NSString *score;

/**
 医学类型 ： 西医|中医|西医,中医
 */
@property (nonatomic, copy) NSString<Optional> *medicineType;

/**
 公立医院标志 0：私立医院 1：公立医院
 */
@property (nonatomic, copy) NSString<Optional> *governmentalHospitalFlag;

@end

NS_ASSUME_NONNULL_END
