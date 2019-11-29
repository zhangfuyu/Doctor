//
//  GHDepartmentModel.h
//  掌上优医
//
//  Created by GH on 2018/11/15.
//  Copyright © 2018 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHDepartmentModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *modelId;

@property (nonatomic, strong) NSMutableArray<Optional> *children;

@property (nonatomic, strong) NSNumber<Optional> *isOpen;

@property (nonatomic, strong) NSNumber<Optional> *isSelected;

@property (nonatomic, strong) NSNumber<Optional> *sortTag;

/**
 科室名字
 */
@property (nonatomic, copy) NSString<Optional> *departmentName;

/**
 科室图标
 */
@property (nonatomic, copy) NSString<Optional> *departmentsIconUrl;

/**
 科室层级
 */
@property (nonatomic, copy) NSString<Optional> *departmentLevel;


/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *departmentId;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *hospitalId;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *doctorCount;




@property (nonatomic, copy) NSString<Optional> *parentId;

@property (nonatomic, strong) NSNumber<Optional> *shouldHeight;


@end

NS_ASSUME_NONNULL_END
