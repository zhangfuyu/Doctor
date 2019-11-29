//
//  GHDepartmentModel.m
//  掌上优医
//
//  Created by GH on 2018/11/15.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHDepartmentModel.h"

@implementation GHDepartmentModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id"}];
}

- (NSMutableArray<Optional> *)children {
    
    if (!_children) {
        _children = [[NSMutableArray alloc] init];
    }
    return _children;
    
}

@end
