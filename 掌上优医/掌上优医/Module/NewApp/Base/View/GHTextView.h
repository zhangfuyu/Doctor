//
//  GHTextView.h
//  掌上优医
//
//  Created by GH on 2018/11/6.
//  Copyright © 2018 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, assign) NSUInteger maxLength;

@end

NS_ASSUME_NONNULL_END
