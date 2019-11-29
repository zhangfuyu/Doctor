//
//  GHSearchDoctorHeaderView.h
//  掌上优医
//
//  Created by apple on 2019/10/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHSearchDoctorHeaderView : GHBaseView

- (void)setupScrollViewWithModelArray:(NSArray *)modelArray;
- (void)setupRecommendDoctorModelArry:(NSMutableArray *)arry;

@end

NS_ASSUME_NONNULL_END
