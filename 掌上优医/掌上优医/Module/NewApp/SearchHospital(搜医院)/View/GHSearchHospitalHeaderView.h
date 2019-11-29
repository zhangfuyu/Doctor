//
//  GHSearchHospitalHeaderView.h
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHSearchHospitalHeaderView : GHBaseView

@property (nonatomic, strong) NSArray *specialArray;

- (void)setupScrollViewWithModelArray:(NSArray *)modelArray;
- (void)setupRecommendHospitalModelArry:(NSMutableArray *)arry;
+ (NSMutableArray *)getmodelarry;
@end

NS_ASSUME_NONNULL_END
