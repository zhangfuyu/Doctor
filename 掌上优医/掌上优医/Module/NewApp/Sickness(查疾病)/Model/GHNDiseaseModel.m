//
//  GHNDiseaseModel.m
//  掌上优医
//
//  Created by GH on 2019/4/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNDiseaseModel.h"

@implementation GHNDiseaseModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id"}];
}

@end
