//
//  GHQuestionModel.m
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHQuestionModel.h"

@implementation GHQuestionModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id"}];
}

@end
