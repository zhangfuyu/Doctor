//
//  GHHospitalSpecialDepartmentModel.h
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHHospitalSpecialDepartmentModel : JSONModel

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *name;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *typeName;


/**
 <#Description#>
 */
@property (nonatomic, copy) NSString<Optional> *iconUrl;


@end

NS_ASSUME_NONNULL_END
