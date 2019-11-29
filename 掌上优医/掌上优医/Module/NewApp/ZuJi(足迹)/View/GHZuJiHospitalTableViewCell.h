//
//  GHZuJiHospitalTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHZuJiHospitalModel.h"

#import "GHSearchHospitalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHZuJiHospitalTableViewCell : GHBaseTableViewCell

@property (nonatomic, strong) GHSearchHospitalModel *model;

@end

NS_ASSUME_NONNULL_END
