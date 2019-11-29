//
//  GHBaseViewController.h
//  掌上优医
//
//  Created by GH on 2018/10/24.
//  Copyright © 2018 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    GHNavigationBarStyleBlue,
    GHNavigationBarStyleWhite,
} GHNavigationBarStyle;

@interface GHBaseViewController : UIViewController

/**
 *  添加右侧按钮
 *
 *  @param selector  回调方法
 *  @param image     显示的图片
 *  @param highImage 高亮显示的图片
 */
- (void)addRightButton:(SEL)selector
                 image:(UIImage *)image
             highImage:(UIImage *)highImage;

/**
 *  添加右侧按钮
 *
 *  @param selector  回调方法
 *  @param image     显示的图片
 */
- (void)addRightButton:(SEL)selector
                 image:(UIImage *)image;


/**
 *  添加右侧按钮
 *
 *  @param selector  回调方法
 *  @param title     按钮文字
 */
- (void)addRightButton:(SEL)selector
                 title:(NSString *)title;
/**
 *  添加右侧按钮
 *
 *  @param selector  回调方法
 *  @param view      自定义view
 */
- (void)addRightButton:(SEL)selector
                  view:(UIView *)view;

/**
 *  添加导航栏标题
 *
 *  @param title 标题内容
 */
- (void)setNavigationTitle:(NSString *)title;


/**
 *  添加返回按钮
 */
- (void)addBackButton;

- (void)addDismissButton;

/**
 *  添加左侧带文字的按钮
 *
 *  @param selector 回调方法
 *  @param title    按钮上显示的文字
 */
- (void)addLeftButton:(SEL)selector
                title:(NSString *)title;

-(void)addLeftButton:(SEL)selector image:(UIImage*)image;

/**
 添加左侧有文字和图片的按钮
 
 @param selector 回调方法
 @param title  文字
 @param image 图片名
 */
-(void)addLeftButton:(SEL)selector
               title:(NSString *)title
               image:(UIImage *)image;
/**
 *  添加左侧带图片的按钮
 *
 *  @param selector 回调方法
 *
 */
- (void)addLeftButton:(SEL)selector;


/**
 *  隐藏左侧按钮
 */
- (void)hideLeftButton;


/*
 * 未登录处理
 */
- (void)unLoginWarning;

///**
// *  导航栏的alpha问题
// *
// *  @param view 调用类的view
// */
//- (void)addNavAlphaInView:(UIView *)view;


/**
 *无数据加载遮罩view
 */
-(void)loadingEmptyView;


-(void)hideEmptyView;

- (void)back:(id)sender;

- (void)setupNavigationStyle:(GHNavigationBarStyle)style;

@end

NS_ASSUME_NONNULL_END
