//
//  GHSearchHospitalButtonView.h
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"
#import "GHHospitalSpecialDepartmentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHSearchHospitalButtonView : GHBaseView

@property (nonatomic, strong) UIButton *actionButton;

/**
 <#Description#>
 */
@property (nonatomic, strong) GHHospitalSpecialDepartmentModel *model;

@end

NS_ASSUME_NONNULL_END
