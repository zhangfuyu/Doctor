//
//  GHHospitalDepartmentDoctorListViewController.h
//  掌上优医
//
//  Created by GH on 2019/5/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHHospitalDepartmentDoctorListViewController : GHBaseViewController

@property (nonatomic, strong) NSString *hospitalId;

@property (nonatomic, strong) NSString *departmentId;

@property (nonatomic, strong) NSString *departmentLevel;

@end

NS_ASSUME_NONNULL_END
