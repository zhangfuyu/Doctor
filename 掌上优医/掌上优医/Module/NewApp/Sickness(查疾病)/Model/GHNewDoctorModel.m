//
//  GHNewDoctorModel.m
//  掌上优医
//
//  Created by apple on 2019/8/27.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewDoctorModel.h"

@implementation GHNewDoctorModel

//- (NSString<Optional> *)medicineType
//{
//    NSInteger type = [_medicineType integerValue];
//    switch (type) {
//        case 0:
//            self.medicineName = @"未知";
//            break;
//        case 1:
//            self.medicineName = @"西医";
//            break;
//        case 2:
//            self.medicineName = @"中医";
//            break;
//            
//        default:
//            self.medicineName = @"中西医结合";
//            break;
//    }
//    return nil;
//}

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
