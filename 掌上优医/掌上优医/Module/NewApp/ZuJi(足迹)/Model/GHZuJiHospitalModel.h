//
//  GHZuJiHospitalModel.h
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHZuJiHospitalModel : JSONModel <NSCoding>

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
 联系电话
 */
@property (nonatomic, copy) NSString<Optional> *contactNumber;

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
 医院ID
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 医院介绍
 */
@property (nonatomic, copy) NSString<Optional> *introduction;

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


@end

NS_ASSUME_NONNULL_END
