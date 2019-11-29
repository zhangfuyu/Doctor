//
//  GHNChooseTitleView.h
//  掌上优医
//
//  Created by GH on 2019/2/21.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHNChooseTitleViewDelegate <NSObject>

@optional
- (void)clickButtonWithTag:(NSInteger)tag;

@end

@interface GHNChooseTitleView : GHBaseView

@property (nonatomic, weak) id<GHNChooseTitleViewDelegate> delegate;

- (instancetype)initWithTitleArray:(NSArray *)titleArray;

@end

NS_ASSUME_NONNULL_END
