//
//  GHHospitalPointAnnotation.h
//  掌上优医
//
//  Created by GH on 2019/5/23.
//  Copyright © 2019 GH. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "GHSearchHospitalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHHospitalPointAnnotation : MAPointAnnotation

@property (nonatomic, strong) GHSearchHospitalModel *model;

@end

NS_ASSUME_NONNULL_END
