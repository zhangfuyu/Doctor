//
//  GHCommentTypeView.h
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHCommentTypeView : GHBaseView

/**
 图标
 */
@property (nonatomic, strong) UIImage *iconImage;

/**
 标题
 */
@property (nonatomic, strong) NSString *title;

/**
 描述
 */
@property (nonatomic, strong) NSString *desc;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *actionButton;

@end

NS_ASSUME_NONNULL_END
