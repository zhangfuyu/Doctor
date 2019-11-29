//
//  GHHospitalCommentViewController.h
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"
#import "GHSearchHospitalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHHospitalCommentViewController : GHBaseViewController

@property (nonatomic, strong) GHSearchHospitalModel *model;

/**
 <#Description#>
 */
@property (nonatomic, assign) BOOL isNotHaveDetail;

@end

NS_ASSUME_NONNULL_END
