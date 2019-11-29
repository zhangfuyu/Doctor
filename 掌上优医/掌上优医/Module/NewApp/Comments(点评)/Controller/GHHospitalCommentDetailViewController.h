//
//  GHHospitalCommentDetailViewController.h
//  掌上优医
//
//  Created by GH on 2019/5/15.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"
#import "GHMyCommentsModel.h"
#import "GHSearchHospitalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHHospitalCommentDetailViewController : GHBaseViewController

@property (nonatomic, strong) GHMyCommentsModel *model;

@property (nonatomic, strong)GHSearchHospitalModel *hospitalModel;
@end

NS_ASSUME_NONNULL_END
