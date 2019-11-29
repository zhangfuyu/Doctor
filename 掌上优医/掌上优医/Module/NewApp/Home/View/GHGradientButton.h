//
//  GHGradientButton.h
//  掌上优医
//
//  Created by apple on 2019/10/11.
//  Copyright © 2019 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHGradientButton : UIButton

//设置文字渐变色
- (void)setGradientColors:(NSArray<UIColor *> *)colors;

- (void)setTitleGradientColors:(NSArray<UIColor *> *)colors;

- (void)setNomelColor:(NSArray<UIColor *> *)colors;

- (void)setSelectedColor:(NSArray<UIColor *> *)colors;

@end

NS_ASSUME_NONNULL_END
