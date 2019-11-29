//
//  GHCommentHospitalRecordTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHNHospitalRecordModel.h"

#import "GHSearchHospitalModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GHCommentHospitalRecordTableViewCell : GHBaseTableViewCell

/**
 <#Description#>
 */
@property (nonatomic, strong) GHSearchHospitalModel *model;

@end

NS_ASSUME_NONNULL_END
