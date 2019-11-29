//
//  GHCommentDoctorRecordTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"

#import "GHNDoctorRecordModel.h"

#import "GHSearchDoctorModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GHCommentDoctorRecordTableViewCell : GHBaseTableViewCell

/**
 <#Description#>
 */
@property (nonatomic, strong) GHSearchDoctorModel *model;

@end

NS_ASSUME_NONNULL_END
