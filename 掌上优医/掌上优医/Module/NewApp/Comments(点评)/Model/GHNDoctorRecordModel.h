//
//  GHNDoctorRecordModel.h
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNDoctorRecordModel : JSONModel <NSCoding>


@property (nonatomic, copy) NSString *modelId;

/**
 医生姓名
 */
@property (nonatomic, copy) NSString *doctorName;

/**
 医生职称
 */
@property (nonatomic, copy) NSString *doctorGrade;

/**
 医生头像
 */
@property (nonatomic, copy) NSString *profilePhoto;

@property (nonatomic, copy) NSString *firstDepartmentId;
@property (nonatomic, copy) NSString *firstDepartmentName;
@property (nonatomic, copy) NSString *secondDepartmentId;
@property (nonatomic, copy) NSString *secondDepartmentName;

@property (nonatomic, copy) NSString *score;

/**
 医生医院 ID
 */
@property (nonatomic, copy) NSString *hospitalId;

/**
 医生医院名字
 */
@property (nonatomic, copy) NSString *hospitalName;

/**
 医学类型 ： 西医|中医|西医,中医
 */
@property (nonatomic, copy) NSString *medicineType;


@end

NS_ASSUME_NONNULL_END
