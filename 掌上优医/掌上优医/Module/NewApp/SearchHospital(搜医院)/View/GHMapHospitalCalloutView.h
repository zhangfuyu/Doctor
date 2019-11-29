//
//  GHMapHospitalCalloutView.h
//  掌上优医
//
//  Created by GH on 2019/5/23.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"
#import "GHSearchHospitalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHMapHospitalCalloutView : GHBaseView

@property (nonatomic, strong) GHSearchHospitalModel *model;


/**
 0 左 1 右

 @param direction <#direction description#>
 */
- (void)setupDirection:(NSUInteger)direction;

@end

NS_ASSUME_NONNULL_END
