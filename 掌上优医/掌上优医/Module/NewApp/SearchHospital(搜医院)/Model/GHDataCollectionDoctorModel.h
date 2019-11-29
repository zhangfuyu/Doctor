//
//  GHDataCollectionDoctorModel.h
//  掌上优医
//
//  Created by GH on 2019/5/29.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHDataCollectionDoctorModel : JSONModel

/**
 审核结果
 */
@property (nonatomic, copy) NSString<Optional> *checkResult;

/**
 数据采集类型 1：报错 2：补全 3：新增
 */
@property (nonatomic, copy) NSString<Optional> *dataCollectionType;

/**
 医生职称 2-30位字符
 */
@property (nonatomic, copy) NSString<Optional> *doctorGrade;

/**
 医生信息 10-500位字符
 */
@property (nonatomic, copy) NSString<Optional> *doctorInfo;

/**
 医生姓名 2-20位字符
 */
@property (nonatomic, copy) NSString<Optional> *doctorName;

/**
 一级科室ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *firstDepartmentId;

/**
 一级科室名称 2-50位字符
 */
@property (nonatomic, copy) NSString<Optional> *firstDepartmentName;


@property (nonatomic, copy) NSString<Optional> *gmtCreate;

@property (nonatomic, copy) NSString<Optional> *gmtModified;

/**
 医院地址 5-400位字符
 */
@property (nonatomic, copy) NSString<Optional> *address;

/**
 医院ID 为正整数
 */
@property (nonatomic, copy) NSString<Optional> *hospitalId;

/**
 医院名称 5-200位字符
 */
@property (nonatomic, copy) NSString<Optional> *hospitalName;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 医学类型 ： 西医|中医|西医,中医
 */
@property (nonatomic, copy) NSString<Optional> *medicineType;

/**
 原医生ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *doctorId;

/**
 头像 5-200位字符
 */
@property (nonatomic, copy) NSString<Optional> *profilePhoto;

/**
 认证材料，JSON格式 {"medicalQualificationCertificate":"医师资格证书 - 照片URL",
 “medicalPracticeCertificate":"医师执业证书 - 照片URL”
 */
@property (nonatomic, copy) NSString<Optional> *qualityCertifyMaterials;

/**
 二级科室ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *secondDepartmentId;

/**
 二级科室名称 2-50位字符
 */
@property (nonatomic, copy) NSString<Optional> *secondDepartmentName;

/**
 擅长 5-400位字符
 */
@property (nonatomic, copy) NSString<Optional> *goodAt;

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

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *diagnosisTime;

/**
 职业生涯
 */
@property (nonatomic, copy) NSString<Optional> *careerExperience;

/**
 医生职称
 */
@property (nonatomic, copy) NSString<Optional> *doctorGradeNum;

/**
 医院
 */
@property (nonatomic, copy) NSString<Optional> *hospital;

/**
 医生照片
 */
@property (nonatomic, copy) NSString<Optional> *imageUrl;

/**
 医院经纬度
 */
@property (nonatomic, copy) NSString<Optional> *latitude;
@property (nonatomic, copy) NSString<Optional> *longitude;
/**
 出诊时间
 */
@property (nonatomic, copy) NSString<Optional> *visitTime;

/**
 出诊时间
 */
@property (nonatomic, copy) NSString<Optional> *createTime;
@end

NS_ASSUME_NONNULL_END
