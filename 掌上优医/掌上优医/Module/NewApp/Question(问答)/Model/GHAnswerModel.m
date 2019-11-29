//
//  GHAnswerModel.m
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAnswerModel.h"

@implementation GHAnswerModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id"}];
}

- (NSMutableArray<Optional> *)replyArray {
    
    if (!_replyArray) {
        _replyArray = [[NSMutableArray alloc] init];
    }
    return _replyArray;
    
}

@end
