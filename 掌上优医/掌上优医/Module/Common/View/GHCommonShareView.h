//
//  GHCommonShareView.h
//  掌上优医
//
//  Created by GH on 2018/11/9.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHCommonShareView : GHBaseView

/**
 分享的标题
 */
@property (nonatomic, copy) NSString *title;

/**
 分享的简介
 */
@property (nonatomic, copy) NSString *desc;

/**
 分享的图片
 */
@property (nonatomic, strong) UIImage *image;

/**
 分享的 URL
 */
@property (nonatomic, copy) NSString *urlString;

@end

NS_ASSUME_NONNULL_END
