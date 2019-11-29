//
//  GHChooseDoctorHospitalViewController.h
//  掌上优医
//
//  Created by GH on 2019/5/29.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"
#import "GHSearchHospitalModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHChooseDoctorHospitalViewControllerDelegate <NSObject>

@optional

- (void)choooseHospitalWithModel:(GHSearchHospitalModel *)model;

@end

@interface GHChooseDoctorHospitalViewController : GHBaseViewController

@property (nonatomic, weak) id<GHChooseDoctorHospitalViewControllerDelegate> delegate;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *searchKey;

@end

NS_ASSUME_NONNULL_END
