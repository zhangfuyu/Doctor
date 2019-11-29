//
//  GHHospitalRecommendedModel.m
//  掌上优医
//
//  Created by apple on 2019/10/29.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalRecommendedModel.h"

@implementation GHHospitalRecommendedModel

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
