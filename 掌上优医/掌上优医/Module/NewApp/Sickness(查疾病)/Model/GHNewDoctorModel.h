//
//  GHNewDoctorModel.h
//  掌上优医
//
//  Created by apple on 2019/8/27.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNewDoctorModel : JSONModel


/**
 医生id
 */
@property (nonatomic, copy) NSString<Optional> *doctorId;

/**
 医生姓名
 */
@property (nonatomic, copy) NSString<Optional> *doctorName;


/**
 职称
 */
@property (nonatomic, copy) NSString<Optional> *doctorGrade;

/**
 职称
 */
@property (nonatomic, copy) NSString<Optional> *doctorGradeNum;


/**
 医生介绍
 */
@property (nonatomic, copy) NSString<Optional> *doctorInfo;


/**
 擅长领域描述
 */
@property (nonatomic, copy) NSString<Optional> *specialize;


/**
 医生头像
 */
@property (nonatomic, copy) NSString<Optional> *headImgUrl;


/**
 医生评分 100分制,可以除10显示
 */
@property (nonatomic, copy) NSString<Optional> *commentScore;


/**
 资质认证 0：待提交 1：待审核 2：审核不通过 3：审核通过
 */
@property (nonatomic, copy) NSString<Optional> *qualityCertifyFlag;


/**
 医学类型 ： 西医 中医 .中西医结合
 */
@property (nonatomic, copy) NSString<Optional> *medicineType;

/**
 医学类型 ： 西医 中医 .中西医结合
 */
@property (nonatomic, copy) NSString<Optional> *medicineName;


/**
 医院id
 */
@property (nonatomic, copy) NSString<Optional> *hospitalId;


/**
 医院名称
 */
@property (nonatomic, copy) NSString<Optional> *hospitalName;


/**
 二级科室id
 */
@property (nonatomic, copy) NSString<Optional> *secondDepartmentId;


/**
 二级科室名称
 */
@property (nonatomic, copy) NSString<Optional> *secondDepartmentName;


/**
 医生推荐疾病
 */
@property (nonatomic, copy) NSString<Optional> *doctorRecommendedDisease;


/**
 医生推荐d第二疾病
 */
@property (nonatomic, copy) NSString<Optional> *doctorSecondDisease;

/**
 第一部门id
 */
@property (nonatomic, copy) NSString<Optional> *firstDepartmentId;

/**
 第一部门名字
 */
@property (nonatomic, copy) NSString<Optional> *firstDepartmentName;

/**
 入住 是否入驻 0 否 1入驻
 */
@property (nonatomic, copy) NSString<Optional> *isInPlatform;


/**
 
 */
@property (nonatomic, copy) NSString<Optional> *mainHospital;

@property (nonatomic, copy) NSString<Optional> *lat;

@property (nonatomic, copy) NSString<Optional> *lng;

/**
 w评分
 */
@property (nonatomic, copy) NSString<Optional> *myScore;

/**
 创建时间
 */
@property (nonatomic, copy) NSString<Optional> *createTime;

/**
 更新时间
 */
@property (nonatomic, copy) NSString<Optional> *updateTime;

@property (nonatomic, copy) NSString<Optional> *hospitalGrade;

/**
 距离
 */
@property (nonatomic, copy) NSString<Optional> *distance;
@end

NS_ASSUME_NONNULL_END
