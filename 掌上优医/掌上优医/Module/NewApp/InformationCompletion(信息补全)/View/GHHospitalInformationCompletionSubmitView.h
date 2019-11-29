//
//  GHHospitalInformationCompletionSubmitView.h
//  掌上优医
//
//  Created by GH on 2019/6/4.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"
#import "GHSearchHospitalModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHHospitalInformationCompletionSubmitViewDelegate <NSObject>

@optional

- (void)updateSubmitViewWithHeight:(CGFloat)height;

@end

@interface GHHospitalInformationCompletionSubmitView : GHBaseView

/**
 <#Description#>
 */
@property (nonatomic, weak) id<GHHospitalInformationCompletionSubmitViewDelegate> delegate;

@property (nonatomic, strong) GHSearchHospitalModel *model;

/**
 <#Description#>
 */
@property (nonatomic, assign) CGFloat contentHeight;

@end

NS_ASSUME_NONNULL_END
