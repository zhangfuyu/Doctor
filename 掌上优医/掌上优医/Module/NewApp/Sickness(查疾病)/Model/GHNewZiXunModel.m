//
//  GHNewZiXunModel.m
//  掌上优医
//
//  Created by apple on 2019/9/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNewZiXunModel.h"

@implementation GHNewZiXunModel
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelID":@"id"}];
}

@end
