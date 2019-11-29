//
//  GHMyCommentsTableViewCell.h
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHMyCommentsModel.h"
#import "GHDoctorCommentModel.h"



NS_ASSUME_NONNULL_BEGIN

@interface GHMyCommentsTableViewCell : GHBaseTableViewCell

/**
 <#Description#>
 */
@property (nonatomic, strong) GHDoctorCommentModel *model;

@end

NS_ASSUME_NONNULL_END
