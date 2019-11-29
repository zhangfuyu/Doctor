//
//  GHZuJiDoctorModel.h
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHZuJiDoctorModel : JSONModel <NSCoding>


@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 医生姓名
 */
@property (nonatomic, copy) NSString<Optional> *doctorName;

/**
 医生职称
 */
@property (nonatomic, copy) NSString<Optional> *doctorGrade;

/**
 医生头像
 */
@property (nonatomic, copy) NSString<Optional> *profilePhoto;

@property (nonatomic, copy) NSString<Optional> *firstDepartmentId;
@property (nonatomic, copy) NSString<Optional> *firstDepartmentName;
@property (nonatomic, copy) NSString<Optional> *secondDepartmentId;
@property (nonatomic, copy) NSString<Optional> *secondDepartmentName;

/**
 医生医院 ID
 */
@property (nonatomic, copy) NSString<Optional> *hospitalId;

/**
 医生医院名字
 */
@property (nonatomic, copy) NSString<Optional> *hospitalName;





@end

NS_ASSUME_NONNULL_END
