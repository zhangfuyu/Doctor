//
//  GHSearchDoctorModel.h
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHSearchDoctorModel : JSONModel

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 医生id
 */
@property (nonatomic, copy) NSString<Optional> *doctorId;
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

@property (nonatomic, copy) NSString<Optional> *hospitalDepartment;

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
 医院距离
 */
@property (nonatomic, copy) NSString<Optional> *hospitalDistance;

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

/**
 医学类型 ： 西医|中医|西医,中医
 */
@property (nonatomic, copy) NSString<Optional> *medicineType;

/**
 资质认证 0：待提交 1：待审核 2：审核不通过 3：审核通过
 */
@property (nonatomic, copy) NSString<Optional> *qualityCertifyFlag;

/**
 认证材料，JSON格式
 */
@property (nonatomic, copy) NSString<Optional> *qualityCertifyMaterials;

/**
 出诊时间,多个时间用逗号分隔按周一到周日排序 示例: "周一(上午),周三(全天),周四(下午)"
 */
@property (nonatomic, copy) NSString<Optional> *diagnosisTime;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *hospitalLevel;

/**
 评价条数
 */
@property (nonatomic, copy) NSString<Optional> *evaluationNumber;

/**
 评价列表
 */
@property (nonatomic, copy) NSMutableArray<Optional> *evaluationList;

/**
 问答列表
 */
@property (nonatomic, copy) NSMutableArray<Optional> *answerList;

@property (nonatomic, copy) NSString<Optional> *headImgUrl;


/**
 是否已入驻
 1是
 */
@property (nonatomic, copy) NSString<Optional> *isinplatform;
@end

NS_ASSUME_NONNULL_END
