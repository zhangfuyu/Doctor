//
//  GHDoctorFilterViewController.h
//  掌上优医
//
//  Created by GH on 2019/2/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHDoctorFilterViewControllerDelegate <NSObject>

@optional
- (void)chooseFinishDoctorFilter:(NSString *)filter;

- (void)chooseFinishDoctorPosition:(NSString *)position doctorType:(NSString *)doctorType hospitalLevel:(NSString *)hospitalLevel;

@end

@interface GHDoctorFilterViewController : GHBaseViewController

/**
 <#Description#>
 */
@property (nonatomic, weak) id<GHDoctorFilterViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
