//
//  GHChoiceModel.h
//  掌上优医
//
//  Created by GH on 2019/2/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"
#import "GHSearchHospitalModel.h"
#import "GHSearchDoctorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHChoiceModel : JSONModel

@property (nonatomic , strong)GHSearchHospitalModel<Optional> *hospitalmoodel;


@property (nonatomic , strong)GHSearchDoctorModel<Optional> *doctormoodel;

/**
 精选标志，0：普通 1：精选
 */
@property (nonatomic, copy) NSString<Optional> *choiceFlag;

/**
 评价内容
 */
@property (nonatomic, copy) NSString<Optional> *comment;

@property (nonatomic, copy) NSString<Optional> *createTime;

@property (nonatomic, copy) NSString<Optional> *envScore;


/**
 评价主体ID 正整数
 */
@property (nonatomic, copy) NSString<Optional> *commentObjId;

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





//@property (nonatomic, copy) NSString<Optional> *treatment;
//
//
//
///**
// 治疗效果
// */
//@property (nonatomic, copy) NSString<Optional> *curativeEffect;
//
///**
// 医生ID
// */
//@property (nonatomic, copy) NSString<Optional> *doctorId;
//
///**
// 医生姓名
// */
//@property (nonatomic, copy) NSString<Optional> *doctorName;

/**
 评价首图
 */
@property (nonatomic, copy) NSString<Optional> *firstPicture;

/**
 评价时间
 */
@property (nonatomic, copy) NSString<Optional> *gmtCreate;

/**
 修改时间，
 */
@property (nonatomic, copy) NSString<Optional> *gmtModified;

/**
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

///**
// 医疗费
// */
//@property (nonatomic, copy) NSString<Optional> *medicalFee;

/**
 评价图片
 */
@property (nonatomic, copy) NSString<Optional> *pictures;

/**
 评分, 取值范围[1,10]
 */
@property (nonatomic, copy) NSString<Optional> *score;

/**
 状态, 1：未审核 2：待人工审核 3：审核通过 4：未通过审核
 */
@property (nonatomic, copy) NSString<Optional> *status;

/**
 患者ID
 */
@property (nonatomic, copy) NSString<Optional> *userId;

/**
 患者昵称
 */
@property (nonatomic, copy) NSString<Optional> *userNickName;

/**
 患者头像
 */
@property (nonatomic, copy) NSString<Optional> *userProfileUrl;

@property (nonatomic, copy) NSString<Optional> *visitCount;

/**
 评价标签，多个标签用逗号分隔 长度范围[1,50]
 */
@property (nonatomic, copy) NSString<Optional> *tags;


@property (nonatomic, copy) NSString<Optional> *imageHeight;

@property (nonatomic, copy) NSString<Optional> *shouldHeight;

//医生评分
@property (nonatomic, copy) NSString<Optional> *commentScore;

//医院综合评分
@property (nonatomic, copy) NSString<Optional> *comprehensiveScore;

//医院环境评分
@property (nonatomic, copy) NSString<Optional> *environmentScore;

//医院服务评分
@property (nonatomic, copy) NSString<Optional> *serviceScore;

@property (nonatomic, strong) NSString <Optional>*cureMethod;

@property (nonatomic, strong) NSString <Optional>*cureState;

@property (nonatomic, strong) NSString <Optional>*diseaseName;

@property (nonatomic, strong) NSString <Optional>*userImgUrl;
@end

NS_ASSUME_NONNULL_END
