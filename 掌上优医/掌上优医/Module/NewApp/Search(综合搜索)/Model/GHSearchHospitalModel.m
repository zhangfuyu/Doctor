//
//  GHSearchHospitalModel.m
//  掌上优医
//
//  Created by GH on 2019/2/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHSearchHospitalModel.h"

@implementation GHSearchHospitalModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id",
                                                                  @"profilePhoto":@"hospitalImgUrl"
                                                                  }];
}

- (NSString<Optional> *)score {
    
    return [NSString stringWithFormat:@"%.1f", [_score integerValue] / 10.f];
    
}

- (NSString<Optional> *)environmentScore {
    
    return [NSString stringWithFormat:@"%.1f", [_environmentScore integerValue] / 10.f];
    
}

- (NSString<Optional> *)serviceScore {
    
    return [NSString stringWithFormat:@"%.1f", [_serviceScore integerValue] / 10.f];
    
}

- (NSString<Optional> *)comprehensiveScore {
    
    return [NSString stringWithFormat:@"%.1f", [_comprehensiveScore integerValue] / 10.f];
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
- (NSString<Optional> *)governmentalHospitalFlag
{
    NSInteger compre = _governmentalHospitalFlag.integerValue;
    
    
    switch (compre) {
        case 1:
            return @"公立";
            break;
        case 2:
            return @"私立";
            break;
        default:
            break;
    }
    return @"";
}
@end
