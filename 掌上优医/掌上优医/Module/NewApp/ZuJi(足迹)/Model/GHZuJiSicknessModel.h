//
//  GHZuJiSicknessModel.h
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHZuJiSicknessModel : JSONModel <NSCoding>

@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 症状 长度5-20480字符 ,
 */
@property (nonatomic, copy) NSString<Optional> *symptom;

/**
 疾病名称 长度为2-200字符 ,
 */
@property (nonatomic, copy) NSString<Optional> *diseaseName;

/**
 
 */
@property (nonatomic, copy) NSString<Optional> *firstDepartmentName;


@end

NS_ASSUME_NONNULL_END
