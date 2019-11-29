//
//  GHNewDepartMentModel.m
//  掌上优医
//
//  Created by apple on 2019/8/30.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewDepartMentModel.h"

@implementation GHNewDepartMentModel
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelid":@"id"}];
}

- (NSMutableArray<Optional> *)secondDepartmentList
{
    if (!_secondDepartmentList) {
        _secondDepartmentList = [NSMutableArray arrayWithCapacity:0];
    }
    return _secondDepartmentList;
}

@end
