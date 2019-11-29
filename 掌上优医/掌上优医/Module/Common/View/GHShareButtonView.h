//
//  GHShareButtonView.h
//  掌上优医
//
//  Created by GH on 2018/11/9.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHShareButtonView : GHBaseView

@property (nonatomic, strong) UIButton *actionButton;

- (instancetype)initWithIconName:(NSString *)iconName withTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
