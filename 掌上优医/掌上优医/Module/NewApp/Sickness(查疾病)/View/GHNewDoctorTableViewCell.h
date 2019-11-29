//
//  GHNewDoctorTableViewCell.h
//  掌上优医
//
//  Created by apple on 2019/8/8.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHSearchDoctorModel.h"

#import "GHNewDoctorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNewDoctorTableViewCell : UITableViewCell

@property (nonatomic , strong)GHNewDoctorModel *model;

+ (float)getCellHeitghtWithMoel:(GHNewDoctorModel *)model;
@end

NS_ASSUME_NONNULL_END
