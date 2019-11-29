//
//  GHDoctorSortViewController.h
//  掌上优医
//
//  Created by GH on 2019/2/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHDoctorSortViewControllerDelegate <NSObject>

@optional
- (void)chooseFinishDoctorSortWithSort:(NSString *)sort;

@end

@interface GHDoctorSortViewController : GHBaseViewController

@property (nonatomic , assign) BOOL isAllCountry;


@property (nonatomic, weak)  id<GHDoctorSortViewControllerDelegate> delegate;

/**
 <#Description#>
 */
@property (nonatomic, assign) BOOL isDefaultSortType;



@end

NS_ASSUME_NONNULL_END
