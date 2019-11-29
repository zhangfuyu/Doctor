//
//  GHDoctorTimeChooseView.h
//  掌上优医
//
//  Created by GH on 2019/5/24.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHDoctorTimeChooseViewDelegate <NSObject>

@optional
- (void)chooseTimeFinishWithTime:(NSString *)time;

@end

@interface GHDoctorTimeChooseView : GHBaseView

@property (nonatomic, weak) id<GHDoctorTimeChooseViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
