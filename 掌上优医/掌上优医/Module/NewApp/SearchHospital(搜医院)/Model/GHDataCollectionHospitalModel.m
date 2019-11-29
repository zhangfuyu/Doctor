//
//  GHDataCollectionHospitalModel.m
//  掌上优医
//
//  Created by GH on 2019/5/29.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHDataCollectionHospitalModel.h"

@implementation GHDataCollectionHospitalModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id",
                                                                  @"originHospitalId":@"hospitalId",
                                                                  @"hospitalAddress":@"address",
                                                                  @"hospitalName":@"name"
                                                                  }];
}
- (NSString<Optional> *)hospitalGrade
{
    
    NSInteger compre = _hospitalGrade.integerValue;
    
    
    switch (compre) {
        case 10:
            return @"一级";
            break;
        case 20:
            return @"二级其他";
            break;
        case 21:
            return @"二级乙等";
            break;
        case 22:
            return @"二级甲等";
            break;
        case 30:
            return @"三级其他";
            break;
        case 31:
            return @"三级特等";
            break;
        case 32:
            return @"三级乙等";
            break;
        case 33:
            return @"三级甲等";
            break;
            
        default:
            return @"";
            break;
    }
    return @"";
}
@end
