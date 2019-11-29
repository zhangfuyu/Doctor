//
//  GHMyCommentsModel.h
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHMyCommentsModel : JSONModel

/**
 评论内容
 */
@property (nonatomic, copy) NSString<Optional> *comment;

@property (nonatomic, copy) NSString<Optional> *commentObjId;

@property (nonatomic, copy) NSString<Optional> *envScore;

/**
 评价主体ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *serviceScore;

/**
 评价主体名称
 */
@property (nonatomic, copy) NSString<Optional> *commentObjName;

/**
 评价主体类型 ,1：医生 2：医院
 */
@property (nonatomic, copy) NSString<Optional> *commentObjType;

/**
 扩展属性，JSON字符串 长度范围[3,200]
 */
@property (nonatomic, copy) NSString<Optional> *extAttributes;

/**
 评价被选择为精选的时间，格式 yyyy-MM-dd HH:mm:ss
 */
@property (nonatomic, copy) NSString<Optional> *gmtChoice;

/**
 评价时间
 */
@property (nonatomic, strong) NSString<Optional> *gmtCreate;

/**
 修改时间
 */
@property (nonatomic, strong) NSString<Optional> *gmtModified;

/**
 评价图片
 */
@property (nonatomic, strong) NSString<Optional> *pictures;

/**
 评分
 */
@property (nonatomic, strong) NSString<Optional> *score;

/**
 状态, 1：未审核 2：待人工审核 3：审核通过 4：未通过审核
 */
@property (nonatomic, strong) NSString<Optional> *status;



/**
 患者ID
 */
@property (nonatomic, strong) NSString<Optional> *userId;

/**
 患者昵称
 */
@property (nonatomic, strong) NSString<Optional> *userNickName;

/**
 患者头像
 */
@property (nonatomic, strong) NSString<Optional> *userProfileUrl;

/**
 
 */
@property (nonatomic, strong) NSString<Optional> *modelId;

@property (nonatomic, strong) NSString<Optional> *doctorName;

@property (nonatomic, strong) NSString<Optional> *doctorProfilePhoto;

@property (nonatomic, strong) NSString<Optional> *doctorScore;

@property (nonatomic, strong) NSString<Optional> *doctorHospitalName;

@property (nonatomic, strong) NSString<Optional> *doctorFirstDepartmentName;

@property (nonatomic, strong) NSString<Optional> *doctorSecondDepartmentName;

@property (nonatomic, strong) NSString<Optional> *doctorGrade;

@property (nonatomic, strong) NSString<Optional> *hospitalProfilePhoto;

@property (nonatomic, strong) NSString<Optional> *hospitalCategory;

@property (nonatomic, strong) NSString<Optional> *hospitalGovernmentalHospitalFlag;

@property (nonatomic, strong) NSString<Optional> *hospitalGrade;

@property (nonatomic, strong) NSString<Optional> *hospitalAddress;

@property (nonatomic, strong) NSString<Optional> *hospitalName;

@property (nonatomic, strong) NSString<Optional> *hospitalMedicalInsuranceFlag;

@property (nonatomic, strong) NSString<Optional> *hospitalMedicineType;

@property (nonatomic, strong) NSString<Optional> *hospitalScore;

@property (nonatomic, copy) NSString<Optional> *createTime;

@property (nonatomic, strong) NSString<Optional> *likeCount;
/**
 <#Description#>
 */
@property (nonatomic, strong) NSNumber<Optional> *contentHeight;

@property (nonatomic, strong) NSNumber<Optional> *shouldHeight;

@property (nonatomic, strong) NSString <Optional>*cureMethod;

@property (nonatomic, strong) NSString <Optional>*cureState;

@property (nonatomic, strong) NSString <Optional>*diseaseName;


/**
 医生评分
 */
@property (nonatomic, strong) NSString <Optional>*commentScore;
@end

NS_ASSUME_NONNULL_END
