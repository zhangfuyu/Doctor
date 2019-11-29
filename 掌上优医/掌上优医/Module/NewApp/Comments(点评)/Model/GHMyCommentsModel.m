//
//  GHMyCommentsModel.m
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHMyCommentsModel.h"

@implementation GHMyCommentsModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id",
                                                                  @"comment":@"commentContent"}];
}

- (NSString<Optional> *)score {
    
    return [NSString stringWithFormat:@"%.1f", [_score integerValue] / 10.f];
    
}

- (NSString<Optional> *)envScore {
    
    return [NSString stringWithFormat:@"%.1f", [_envScore integerValue] / 10.f];
    
}

- (NSString<Optional> *)serviceScore {
    
    return [NSString stringWithFormat:@"%.1f", [_serviceScore integerValue] / 10.f];
    
}

- (NSString<Optional> *)doctorScore {
    
    return [NSString stringWithFormat:@"%.1f", [_doctorScore integerValue] / 10.f];
    
}

- (NSString *)hospitalScore {
    
    return [NSString stringWithFormat:@"%.1f", [_hospitalScore integerValue] / 10.f];
    
}

@end
