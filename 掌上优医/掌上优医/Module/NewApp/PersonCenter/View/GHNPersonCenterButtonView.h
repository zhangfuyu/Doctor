//
//  GHNPersonCenterButtonView.h
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHNPersonCenterButtonView : GHBaseView

@property (nonatomic, strong) UIButton *actionButton;

- (instancetype)initWithImageName:(NSString *)imageName withTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
