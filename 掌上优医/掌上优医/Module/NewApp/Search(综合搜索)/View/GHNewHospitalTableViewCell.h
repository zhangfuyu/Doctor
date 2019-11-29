//
//  GHNewHospitalTableViewCell.h
//  掌上优医
//
//  Created by apple on 2019/8/13.
//  Copyright © 2019年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHSearchHospitalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNewHospitalTableViewCell : UITableViewCell

@property (nonatomic, strong) GHSearchHospitalModel *model;

+ (float)getCellHeightFor:(GHSearchHospitalModel *)model;


@end

NS_ASSUME_NONNULL_END
