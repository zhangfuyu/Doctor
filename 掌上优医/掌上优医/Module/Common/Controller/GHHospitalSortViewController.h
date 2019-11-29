//
//  GHHospitalSortViewController.h
//  掌上优医
//
//  Created by GH on 2019/2/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHHospitalSortViewControllerDelegate <NSObject>

@optional
- (void)chooseFinishHospitalSortWithSort:(NSString *)sort;

@end

@interface GHHospitalSortViewController : GHBaseViewController

@property (nonatomic, weak)  id<GHHospitalSortViewControllerDelegate> delegate;

/**
 没有搜索框, 所以不需要综合排序(智能排序)
 */
@property (nonatomic, assign) NSInteger isNotHaveSearch;

@end

NS_ASSUME_NONNULL_END
