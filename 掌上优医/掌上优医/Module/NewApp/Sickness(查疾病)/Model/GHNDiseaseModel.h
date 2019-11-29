//
//  GHNDiseaseModel.h
//  掌上优医
//
//  Created by GH on 2019/4/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNDiseaseModel : JSONModel

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

@property (nonatomic, copy) NSString<Optional> *diagnosis;

@property (nonatomic, copy) NSString<Optional> *diseaseName;

@property (nonatomic, copy) NSString<Optional> *firstDepartmentId;

@property (nonatomic, copy) NSString<Optional> *firstDepartmentName;

@property (nonatomic, copy) NSString<Optional> *pathogeny;

@property (nonatomic, copy) NSString<Optional> *prevent;

@property (nonatomic, copy) NSString<Optional> *secondDepartmentId;

@property (nonatomic, copy) NSString<Optional> *secondDepartmentName;

@property (nonatomic, copy) NSString<Optional> *summary;

@property (nonatomic, copy) NSString<Optional> *symptom;

@property (nonatomic, copy) NSString<Optional> *treatment;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *departmentNames;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *departmentIds;




@end

NS_ASSUME_NONNULL_END
