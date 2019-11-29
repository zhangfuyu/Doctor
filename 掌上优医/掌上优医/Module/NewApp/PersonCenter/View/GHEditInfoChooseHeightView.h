//
//  GHEditInfoChooseHeightView.h
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHEditInfoChooseHeightViewDelegate <NSObject>

@optional
- (void)finishEditHeightWithText:(NSString *)str;

@end

@interface GHEditInfoChooseHeightView : GHBaseView

@property (nonatomic, weak) id<GHEditInfoChooseHeightViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
