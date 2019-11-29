//
//  GHMyCollectionDoctorModel.h
//  掌上优医
//
//  Created by GH on 2019/2/21.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHMyCollectionDoctorModel : JSONModel

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

@property (nonatomic, copy) NSString<Optional> *contentInfo;

@property (nonatomic, copy) NSString<Optional> *contentType;


/**
 医生姓名
 */
@property (nonatomic, copy) NSString<Optional> *doctorName;

/**
 医生职称
 */
@property (nonatomic, copy) NSString<Optional> *doctorGrade;

/**
 医生教育水平
 */
@property (nonatomic, copy) NSString<Optional> *doctorEducate;

/**
 医生简介
 */
@property (nonatomic, copy) NSString<Optional> *doctorInfo;

/**
 医生擅长
 */
@property (nonatomic, copy) NSString<Optional> *specialize;

/**
 医生头像
 */
@property (nonatomic, copy) NSString<Optional> *profilePhoto;

@property (nonatomic, copy) NSString<Optional> *firstDepartmentId;
@property (nonatomic, copy) NSString<Optional> *firstDepartmentName;
@property (nonatomic, copy) NSString<Optional> *secondDepartmentId;
@property (nonatomic, copy) NSString<Optional> *secondDepartmentName;

///**
// 医生科室 id
// */
//@property (nonatomic, copy) NSString<Optional> *facultyId;
//
///**
// 医生科室名字
// */
//@property (nonatomic, copy) NSString<Optional> *facultyName;

/**
 医生医院 ID
 */
@property (nonatomic, copy) NSString<Optional> *hospitalId;

/**
 医生医院名字
 */
@property (nonatomic, copy) NSString<Optional> *hospitalName;

/**
 医生点赞数
 */
@property (nonatomic, copy) NSString<Optional> *likeCount;

/**
 医院地址
 */
@property (nonatomic, copy) NSString<Optional> *hospitalAddress;

/**
 收藏的资源 id
 */
@property (nonatomic, copy) NSString<Optional> *contentId;

/**
 收藏 名字
 */
@property (nonatomic, copy) NSString<Optional> *title;

/**
 收藏 id
 */
@property (nonatomic, copy) NSString<Optional> *collectionId;

/**
 距离
 */
@property (nonatomic, copy) NSString<Optional> *distance;

/**
 评价次数
 */
@property (nonatomic, copy) NSString<Optional> *commentCount;

/**
 评价得分
 */
@property (nonatomic, copy) NSString<Optional> *commentScore;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *score;


@end

NS_ASSUME_NONNULL_END
