//
//  GHMyCollectionInformationModel.m
//  掌上优医
//
//  Created by GH on 2019/2/21.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHMyCollectionInformationModel.h"

@implementation GHMyCollectionInformationModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id"}];
}

@end
