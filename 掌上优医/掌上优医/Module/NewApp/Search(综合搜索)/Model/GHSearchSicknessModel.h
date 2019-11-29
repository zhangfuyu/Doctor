//
//  GHSearchSicknessModel.h
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHSearchSicknessModel : JSONModel

/**
 诊断 长度5-20480字符
 */
@property (nonatomic, copy) NSString<Optional> *diagnosis;

/**
 疾病名称 长度为2-200字符 ,
 */
@property (nonatomic, copy) NSString<Optional> *diseaseName;


/**
 一级科室ID 正整数 ,
 */
@property (nonatomic, copy) NSString<Optional> *firstDepartmentId;

/**
 一级科室名称 长度为2-50字符 ,
 */
@property (nonatomic, copy) NSString<Optional> *firstDepartmentName;

/**
 Description
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 病因 长度5-20480字符 ,
 */
@property (nonatomic, copy) NSString<Optional> *pathogeny;

/**
 预防 长度5-20480字符 ,
 */
@property (nonatomic, copy) NSString<Optional> *prevent;

/**
 Description
 */
@property (nonatomic, copy) NSString<Optional> *secondDepartmentId;

/**
 Description
 */
@property (nonatomic, copy) NSString<Optional> *secondDepartmentName;

/**
 概述 长度5-20480字符 ,
 */
@property (nonatomic, copy) NSString<Optional> *summary;

/**
 症状 长度5-20480字符 ,
 */
@property (nonatomic, copy) NSString<Optional> *symptom;

/**
 治疗 长度5-20480字符
 */
@property (nonatomic, copy) NSString<Optional> *treatment;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *shouldHeight;


@end

NS_ASSUME_NONNULL_END
