//
//  GHNTaskView.h
//  掌上优医
//
//  Created by GH on 2019/2/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNTaskView : GHBaseView

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *finishButton;

@property (nonatomic, strong) UIButton *actionButton;

- (instancetype)initWithTaskTitle:(NSString *)title withCoin:(NSString *)coin;

@end

NS_ASSUME_NONNULL_END
