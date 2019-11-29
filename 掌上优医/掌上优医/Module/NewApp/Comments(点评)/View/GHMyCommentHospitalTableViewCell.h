//
//  GHMyCommentHospitalTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/5/15.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHMyCommentsModel.h"
#import "GHDoctorCommentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GHMyCommentHospitalTableViewCell : GHBaseTableViewCell


@property (nonatomic, strong) GHDoctorCommentModel *model;


@end

NS_ASSUME_NONNULL_END
