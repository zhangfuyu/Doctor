//
//  GHDoctorCommentViewController.h
//  掌上优医
//
//  Created by GH on 2019/1/15.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"
#import "GHSearchDoctorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHDoctorCommentViewController : GHBaseViewController

@property (nonatomic, strong) GHSearchDoctorModel *model;

/**
 <#Description#>
 */
@property (nonatomic, assign) BOOL isNotHaveDetail;

@end

NS_ASSUME_NONNULL_END
