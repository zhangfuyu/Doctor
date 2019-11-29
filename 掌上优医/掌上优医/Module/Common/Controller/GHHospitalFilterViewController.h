//
//  GHHospitalFilterViewController.h
//  掌上优医
//
//  Created by GH on 2019/2/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHHospitalFilterViewControllerDelegate <NSObject>

@optional
- (void)chooseFinishHospitalType:(NSString *)type level:(NSString *)level;

@end

@interface GHHospitalFilterViewController : GHBaseViewController

@property (nonatomic, weak) id<GHHospitalFilterViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
