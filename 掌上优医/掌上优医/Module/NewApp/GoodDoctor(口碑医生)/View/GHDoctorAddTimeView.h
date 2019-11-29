//
//  GHDoctorAddTimeView.h
//  掌上优医
//
//  Created by GH on 2019/5/24.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHDoctorAddTimeView : GHBaseView

/**
 <#Description#>
 */
@property (nonatomic, assign) BOOL isAdd;

- (void)setupTimeArray:(NSArray *)array;

/**
 获取出诊时间

 @return <#return value description#>
 */
- (NSString *)getTimeString;

@end

NS_ASSUME_NONNULL_END
