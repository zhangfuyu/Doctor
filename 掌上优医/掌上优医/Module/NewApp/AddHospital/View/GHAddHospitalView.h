//
//  GHAddHospitalView.h
//  掌上优医
//
//  Created by GH on 2019/5/30.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHAddHospitalView : GHBaseView

/**
 0 诊所 1 专科 2 综合
 */
@property (nonatomic, assign) NSUInteger type;

@end

NS_ASSUME_NONNULL_END
