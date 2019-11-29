//
//  GHNPersonCenterFooterView.h
//  掌上优医
//
//  Created by GH on 2019/2/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNPersonCenterFooterView : GHBaseView

- (void)reloadData;

- (void)setIsCanCommentTask:(BOOL)task;

- (void)setIsCanShareTask:(BOOL)task;

@end

NS_ASSUME_NONNULL_END
