//
//  GHEditInfoChooseBirthdayView.h
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHEditInfoChooseBirthdayViewDelegate <NSObject>

@optional
- (void)finishEditBirthdayWithText:(NSString *)str;

@end

@interface GHEditInfoChooseBirthdayView : GHBaseView

@property (nonatomic, weak) id<GHEditInfoChooseBirthdayViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
