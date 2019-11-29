//
//  GHDataCollectionDoctorModel.m
//  掌上优医
//
//  Created by GH on 2019/5/29.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHDataCollectionDoctorModel.h"

@implementation GHDataCollectionDoctorModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id",
                                                                  @"doctorName":@"name",
                                                                  @"secondDepartmentName":@"visitingDepartment"
                                                                  
                                                                  }];
}
- (NSString<Optional> *)doctorGradeNum
{
    NSInteger type = [_doctorGradeNum integerValue];
    switch (type) {
        case 1:
            return @"医师";
            break;
        case 2:
            return @"主治医师";
            break;
        case 3:
            return @"副主任医师";
            break;
        default:
            return @"主任医师";
            break;
    }
}
@end
