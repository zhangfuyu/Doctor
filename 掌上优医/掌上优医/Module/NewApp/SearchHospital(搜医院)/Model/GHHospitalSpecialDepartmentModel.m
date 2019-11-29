//
//  GHHospitalSpecialDepartmentModel.m
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalSpecialDepartmentModel.h"

@implementation GHHospitalSpecialDepartmentModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id"}];
}



@end
