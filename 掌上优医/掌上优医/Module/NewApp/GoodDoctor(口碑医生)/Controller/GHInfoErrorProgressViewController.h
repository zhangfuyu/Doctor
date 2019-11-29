//
//  GHInfoErrorProgressViewController.h
//  掌上优医
//
//  Created by GH on 2019/5/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"
#import "GHDataCollectionHospitalModel.h"
#import "GHDataCollectionDoctorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHInfoErrorProgressViewController : GHBaseViewController

/**
 1 医生  2 医院
 */
@property (nonatomic, assign) NSUInteger type;

@property (nonatomic, strong) GHDataCollectionHospitalModel *hospitalModel;

@property (nonatomic, strong) GHDataCollectionDoctorModel *doctorModel;

@end

NS_ASSUME_NONNULL_END
