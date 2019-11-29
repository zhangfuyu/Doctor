//
//  GHChooseHospitalAuthenticationTimeView.h
//  掌上优医
//
//  Created by GH on 2019/6/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHChooseHospitalAuthenticationTimeViewDelegate <NSObject>

@optional
- (void)chooseFinishWithHospitalAuthenticationTime:(NSString *)time;

@end

@interface GHChooseHospitalAuthenticationTimeView : GHBaseView

/**
 <#Description#>
 */
@property (nonatomic, weak) id<GHChooseHospitalAuthenticationTimeViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
