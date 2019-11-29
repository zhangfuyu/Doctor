//
//  GHNSicknessDoctorListViewController.h
//  掌上优医
//
//  Created by GH on 2019/2/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNSicknessDoctorListViewController : GHBaseViewController

/**
 按科室找医生
 */
@property (nonatomic, copy) NSString *departmentName;

@property (nonatomic, copy) NSString *sicknessId;

/**
 按疾病找医生
 */
@property (nonatomic, copy) NSString *sicknessName;


@end

NS_ASSUME_NONNULL_END
