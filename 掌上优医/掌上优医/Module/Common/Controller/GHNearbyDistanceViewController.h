//
//  GHNearbyDistanceViewController.h
//  掌上优医
//
//  Created by GH on 2018/10/31.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHNearbyDistanceViewControllerDelegate <NSObject>

@optional
- (void)chooseFinishNearby:(NSString *)nearby;

@end

@interface GHNearbyDistanceViewController : GHBaseViewController

@property (nonatomic, weak) id<GHNearbyDistanceViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
