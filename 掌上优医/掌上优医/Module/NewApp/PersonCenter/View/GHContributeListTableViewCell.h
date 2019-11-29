//
//  GHContributeListTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/6/5.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHDataCollectionDoctorModel.h"
#import "GHDataCollectionHospitalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHContributeListTableViewCell : GHBaseTableViewCell

@property (nonatomic, strong) GHDataCollectionDoctorModel *doctorModel;

@property (nonatomic, strong) GHDataCollectionHospitalModel *hospitalModel;

@end

NS_ASSUME_NONNULL_END
