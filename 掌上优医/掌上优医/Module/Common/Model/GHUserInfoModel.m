//
//  GHUserInfoModel.m
//  掌上优医
//
//  Created by GH on 2018/11/12.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHUserInfoModel.h"

@implementation GHUserInfoModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id"}];
}

- (void)setPhoneNum:(NSString<Optional> *)phoneNum {
    
    _phoneNum = phoneNum;
    
    if (phoneNum.length >= 7) {
        self.showPhoneNum = [NSString stringWithFormat:@"%@****%@", ISNIL([phoneNum substringToIndex:3]), ISNIL([phoneNum substringFromIndex:7])];
    }
    
}

@end
