//
//  GHTextField.h
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHTextField : UITextField

/**
 最大输入位数
 */
@property (nonatomic, assign) NSUInteger maxInputDigit;

/**
 结束编辑的位数
 */
@property (nonatomic, assign) NSUInteger endEditingDigit;

/**
 左边距
 */
@property (nonatomic, assign) CGFloat leftSpace;


/**
 右边距
 */
@property (nonatomic, assign) CGFloat rightSpace;

@end

NS_ASSUME_NONNULL_END
