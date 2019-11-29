//
//  GHSecondDepartModel.m
//  掌上优医
//
//  Created by apple on 2019/9/3.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHSecondDepartModel.h"

@implementation GHSecondDepartModel
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelid":@"id"}];
}

@end
