//
//  GHHospitalChooseAddressViewController.h
//  掌上优医
//
//  Created by GH on 2019/5/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GHHospitalChooseAddressViewControllerDelegate <NSObject>

@optional
- (void)chooseAddressWithAddress:(NSString *)address withCoordinate:(CLLocationCoordinate2D )coordinate;

@end

@interface GHHospitalChooseAddressViewController : GHBaseViewController

@property (nonatomic, weak) id<GHHospitalChooseAddressViewControllerDelegate> delegate;

@property (nonatomic, strong) MAPointAnnotation *point;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *location;

@end

NS_ASSUME_NONNULL_END
