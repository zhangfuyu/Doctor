//
//  GHAddDoctorAuthenticationViewController.h
//  掌上优医
//
//  Created by GH on 2019/5/30.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHAddDoctorAuthenticationViewControllerDelegate <NSObject>

@optional
- (void)uploadDoctorAuthenticationWithMaterials:(NSMutableDictionary *)materials;

@end

@interface GHAddDoctorAuthenticationViewController : GHBaseViewController

/**
 <#Description#>
 */
@property (nonatomic, weak) id<GHAddDoctorAuthenticationViewControllerDelegate> delegate;

@property (nonatomic, copy) NSMutableDictionary<Optional> *qualityCertifyMaterials;

@end

NS_ASSUME_NONNULL_END
