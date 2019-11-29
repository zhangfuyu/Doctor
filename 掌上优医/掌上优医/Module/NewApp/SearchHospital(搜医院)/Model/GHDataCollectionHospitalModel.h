//
//  GHDataCollectionHospitalModel.h
//  掌上优医
//
//  Created by GH on 2019/5/29.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHDataCollectionHospitalModel : JSONModel

/**
 医院类型：综合医院 中医医院 儿童医院 妇产医院 皮肤病医院 整形医院 口腔医院 诊所 中医诊所 西医诊所
 */
@property (nonatomic, copy) NSString<Optional> *category;

/**
 医院规模类型：综合医院|专科医院|诊所
 */
@property (nonatomic, copy) NSString<Optional> *categoryByScale;

/**
 审核结果
 */
@property (nonatomic, copy) NSString<Optional> *checkResult;

/**
 特色科室，按分隔符分割多个科室名
 */
@property (nonatomic, copy) NSString<Optional> *choiceDepartments;

/**
 市编码
 */
@property (nonatomic, copy) NSString<Optional> *city;

/**
 联系电话 长度范围 [5,100]
 */
@property (nonatomic, copy) NSString<Optional> *contactNumber;

/**
 门诊时间
 */
@property (nonatomic, copy) NSString<Optional> *outpatientDepartmentTime;

/**
 急诊时间
 */
@property (nonatomic, copy) NSString<Optional> *emergencyTreatmentTime;

/**
 所属国家编码
 */
@property (nonatomic, copy) NSString<Optional> *country;

/**
 区县编码
 */
@property (nonatomic, copy) NSString<Optional> *county;

/**
 数据采集类型 1：报错 2：补全 3：新增
 */
@property (nonatomic, copy) NSString<Optional> *dataCollectionType;


@property (nonatomic, copy) NSString<Optional> *gmtCreate;

@property (nonatomic, copy) NSString<Optional> *gmtModified;

/**
 公立医院标志 0：私立医院 1：公立医院
 */
@property (nonatomic, copy) NSString<Optional> *governmentalHospitalFlag;

/**
 医院等级 2-30字符
 */
@property (nonatomic, copy) NSString<Optional> *grade;

/**
 医院地址 5-400字符
 */
@property (nonatomic, copy) NSString<Optional> *hospitalAddress;

/**
 医院设施， 数组，逗号分隔
 */
@property (nonatomic, copy) NSString<Optional> *hospitalFacility;

/**
 医院名称 2-200字符
 */
@property (nonatomic, copy) NSString<Optional> *hospitalName;

/**
 医院标签， 数组，逗号分隔
 */
@property (nonatomic, copy) NSString<Optional> *hospitalTag;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 医院介绍 2-5120字符
 */
@property (nonatomic, copy) NSString<Optional> *introduction;

/**
 是否医保 0：否 1：是
 */
@property (nonatomic, copy) NSString<Optional> *medicalInsuranceFlag;

/**
 医学类型 ： 西医|中医|西医,中医
 */
@property (nonatomic, copy) NSString<Optional> *medicineType;

/**
 原医院ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *originHospitalId;

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

/**
 认证材料，JSON格式 ,{"idNumber":"证件号码",
 "certificateHospitalName":"医院名称",
 "certificateHospitalAddress":"医院地址",
 "legalRepresentative":"法人代表",
 "periodOfValidity":"有效期",
 "businessScope":"经营范围",
 "pics":[{"url":"照片URL"}, {"url":"照片2URL"}]}
 */
@property (nonatomic, copy) NSString<Optional> *qualityCertifyMaterials;

/**
 审核状态 0：未处理 1：通过 2：拒绝
 */
@property (nonatomic, copy) NSString<Optional> *status;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *userId;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *userNickName;

@property (nonatomic, copy) NSString<Optional> *hospitalLevel;

@property (nonatomic, copy) NSString<Optional> *createTime;

@property (nonatomic, copy) NSString<Optional> *doorPhotoUrl;

@property (nonatomic, copy) NSString<Optional> *emergencyTime;

@property (nonatomic, copy) NSString<Optional> *hospitalGrade;


@property (nonatomic, copy) NSString<Optional> *hospitalQualification;

@property (nonatomic, copy) NSString<Optional> *latitude;
@property (nonatomic, copy) NSString<Optional> *longitude;

@property (nonatomic, copy) NSString<Optional> *outpatientTime;


@property (nonatomic, copy) NSString<Optional> *qualificationId;

@property (nonatomic, copy) NSString<Optional> *surroundingsUrl;

@end

NS_ASSUME_NONNULL_END
