//
//  GHSearchHospitalModel.h
//  掌上优医
//
//  Created by GH on 2019/2/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHSearchHospitalModel : JSONModel

/**
 医院类型：综合医院 中医医院 儿童医院 妇产医院 皮肤病医院 整形医院 口腔医院
 */
@property (nonatomic, copy) NSString<Optional> *category;

/**
 评论条数
 */
@property (nonatomic, copy) NSString<Optional> *comprehensiveCount;

/**
 string
 医院规模类型：综合医院|专科医院|诊所
 */
@property (nonatomic, copy) NSString<Optional> *categoryByScale;

/**
 string
 特色科室，按分隔符分割多个科室名
 */
@property (nonatomic, copy) NSString<Optional> *choiceDepartments;

/**
 评价次数
 */
@property (nonatomic, copy) NSString<Optional> *commentCount;

/**
 评价环境得分
 */
@property (nonatomic, copy) NSString<Optional> *commentEnvScore;

/**
 评价得分
 */
@property (nonatomic, copy) NSString<Optional> *commentScore;

/**
 评价服务得分
 */
@property (nonatomic, copy) NSString<Optional> *commentServiceScore;


/**
 医院服务评分
 */
@property (nonatomic, copy) NSString<Optional> *serviceScore;

/**
 医院环境评分
 */
@property (nonatomic, copy) NSString<Optional> *environmentScore;

/**
 医院综合评分
 */
@property (nonatomic, copy) NSString<Optional> *comprehensiveScore;

/**
 公立医院标志 0：私立医院 1：公立医院
 */
@property (nonatomic, copy) NSString<Optional> *governmentalHospitalFlag;

/**
 医院标签， 数组，逗号分隔
 */
@property (nonatomic, copy) NSString<Optional> *hospitalTags;

/**
 是否医保 0：否 1：是
 */
@property (nonatomic, copy) NSString<Optional> *medicalInsuranceFlag;

/**
 医学类型 ： 西医|中医|西医,中医
 */
@property (nonatomic, copy) NSString<Optional> *medicineType;

/**
 门诊时间
 */
@property (nonatomic, copy) NSString<Optional> *outpatientDepartmentTime;

/**
 急诊时间
 */
@property (nonatomic, copy) NSString<Optional> *emergencyTreatmentTime;

/**
 资质认证 0：待提交 1：待审核 2：审核不通过 3：审核通过
 */
@property (nonatomic, copy) NSString<Optional> *qualityCertifyFlag;

/**
 认证材料，JSON格式
 */
@property (nonatomic, copy) NSString<Optional> *qualityCertifyMaterials;


/**
 医院评分
 */
@property (nonatomic, copy) NSString<Optional> *score;









/**
 市编码
 */
@property (nonatomic, copy) NSString<Optional> *city;

/**
 联系电话
 */
@property (nonatomic, copy) NSString<Optional> *contactNumber;

/**
 区县编码
 */
@property (nonatomic, copy) NSString<Optional> *county;

/**
 所属国家编码
 */
@property (nonatomic, copy) NSString<Optional> *country;

/**
 距离 用户到医院的距离,单位是米
 */
@property (nonatomic, copy) NSString<Optional> *distance;

/**
 string
 创建时间
 */
@property (nonatomic, copy) NSString<Optional> *gmtCreate;

/**
 
 */
@property (nonatomic, copy) NSString<Optional> *gmtModified;

/**
 string
 医院等级 2-30字符
 */
@property (nonatomic, copy) NSString<Optional> *hospitalGrade;

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
 医院所在位置纬度 高德地图 格式 -10.238776
 */
@property (nonatomic, copy) NSString<Optional> *lat;

/**
 医院所在位置经度 高德地图 格式 120.234576
 */
@property (nonatomic, copy) NSString<Optional> *lng;

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

@property (nonatomic, copy) NSString<Optional> *totalCount;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *collectionId;


/**
 医院设施
 */
@property (nonatomic, copy) NSString<Optional> *hospitalFacility;

/**
 string
 医院资讯， JSON格式,[{"title":"标题1","h5url":"h5页面1链接"},
 {"title":"标题2","h5url":"h5页面2链接"}]
 */
@property (nonatomic, copy) NSString<Optional> *hospitalNews;

@property (nonatomic, copy) NSString<Optional> *level;



@end

NS_ASSUME_NONNULL_END
