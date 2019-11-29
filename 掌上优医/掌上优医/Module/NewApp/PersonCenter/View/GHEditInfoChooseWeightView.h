//
//  GHEditInfoChooseWeightView.h
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHEditInfoChooseWeightViewDelegate <NSObject>

@optional
- (void)finishEditWeightWithText:(NSString *)str;

@end

@interface GHEditInfoChooseWeightView : GHBaseView

@property (nonatomic, weak) id<GHEditInfoChooseWeightViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
