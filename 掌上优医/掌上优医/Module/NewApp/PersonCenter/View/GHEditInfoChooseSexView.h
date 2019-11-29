//
//  GHEditInfoChooseSexView.h
//  掌上优医
//
//  Created by GH on 2018/11/2.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHEditInfoChooseSexViewDelegate <NSObject>

@optional
- (void)finishEditSexWithText:(NSString *)str;

@end

@interface GHEditInfoChooseSexView : GHBaseView

@property (nonatomic, weak) id<GHEditInfoChooseSexViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
