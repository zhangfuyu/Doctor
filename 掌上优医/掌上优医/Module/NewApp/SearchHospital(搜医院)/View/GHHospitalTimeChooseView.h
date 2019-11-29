//
//  GHHospitalTimeChooseView.h
//  掌上优医
//
//  Created by GH on 2019/5/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class GHHospitalTimeChooseView;
@protocol GHHospitalTimeChooseViewDelegate <NSObject>

@optional
- (void)chooseTimeFinishWithTime:(NSString *)time withTimeView:(GHHospitalTimeChooseView *)timeView;

@end

@interface GHHospitalTimeChooseView : GHBaseView

/**
 <#Description#>
 */
@property (nonatomic, weak) id<GHHospitalTimeChooseViewDelegate> delegate;

@property (nonatomic, strong) UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
