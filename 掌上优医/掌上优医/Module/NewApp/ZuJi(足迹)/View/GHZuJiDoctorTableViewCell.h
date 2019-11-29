//
//  GHZuJiDoctorTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHZuJiDoctorModel.h"

#import "GHSearchDoctorModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface GHZuJiDoctorTableViewCell : GHBaseTableViewCell

@property (nonatomic, strong) GHSearchDoctorModel *model;

@end

NS_ASSUME_NONNULL_END
