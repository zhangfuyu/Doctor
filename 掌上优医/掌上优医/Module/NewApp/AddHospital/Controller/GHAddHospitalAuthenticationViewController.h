//
//  GHAddHospitalAuthenticationViewController.h
//  掌上优医
//
//  Created by GH on 2019/6/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@protocol GHAddHospitalAuthenticationViewControllerDelegate <NSObject>

@optional
- (void)uploadHospitalAuthenticationWithMaterials:(NSString *)materials;

@end

@interface GHAddHospitalAuthenticationViewController : GHBaseViewController

@property (nonatomic, weak) id<GHAddHospitalAuthenticationViewControllerDelegate> delegate;

@property (nonatomic, copy) NSString<Optional> *qualityCertifyMaterials;

@end

NS_ASSUME_NONNULL_END
