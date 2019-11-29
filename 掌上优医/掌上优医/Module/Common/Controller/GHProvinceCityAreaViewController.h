//
//  GHProvinceCityAreaViewController.h
//  掌上优医
//
//  Created by GH on 2018/10/26.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseViewController.h"
#import "GHAreaModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHProvinceCityAreaViewControllerDelegate <NSObject>

@optional
- (void)chooseFinishWithCountryModel:(GHAreaModel *)countryModel provinceModel:(GHAreaModel *)provinceModel cityModel:(GHAreaModel *)cityModel areaModel:(GHAreaModel *)areaModel areaLevel:(NSInteger)areaLevel;

@end

@interface GHProvinceCityAreaViewController : GHBaseViewController

@property (nonatomic, weak)  id<GHProvinceCityAreaViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
