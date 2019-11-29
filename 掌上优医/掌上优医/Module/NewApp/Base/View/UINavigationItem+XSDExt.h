//
//  UINavigationItem+XSDExt.h
//  TCPF
//
//  Created by 浩 胡 on 15/10/2.
//  Copyright © 2015年 XSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (XSDExt)

/**
 *  设置导航栏有图片的左侧按钮
 *
 *  @param vc        当前VC
 *  @param theTarget 当前VC
 *  @param sel       回调方法
 */
+ (void)setLeftButtonOn:(UIViewController *)vc
                 target:(id)theTarget
       callbackSelector:(SEL)sel;


/**
 *  设置导航栏有图片的左侧按钮
 *
 *  @param vc        当前VC
 *  @param theTarget 当前VC
 *  @param sel       回调方法
 *  @param image     按钮上的图片
 */
+ (void)setLeftButtonOn:(UIViewController *)vc
                 target:(id)theTarget
       callbackSelector:(SEL)sel
                  image:(UIImage *)image;


/**
 *  设置导航栏有图片的左侧按钮, 带高亮图片
 *
 *  @param vc        当前VC
 *  @param theTarget 当前VC
 *  @param sel       回调方法
 *  @param image     按钮上的图片
 *  @param highImage 高亮图片
 */
+ (void)setLeftButtonOn:(UIViewController *)vc
                 target:(id)theTarget
       callbackSelector:(SEL)sel
                  image:(UIImage *)image
              highImage:(UIImage *)highImage;

/**
 设置导航栏左侧带文字图片的按钮

 @param vc 当前vc
 @param theTarget 当前vc
 @param sel 回调方法
 @param image 按钮上图片
 @param title 按钮上文字
 */
+(void)setLeftButtonOn:(UIViewController *)vc
                target:(id)theTarget
      callbackSelector:(SEL)sel
                 image:(UIImage *)image
                 title:(NSString *)title;
/**
 *  设置导航栏有文字的左侧按钮
 *
 *  @param vc        当前VC
 *  @param theTarget 当前VC
 *  @param sel       回调方法
 *  @param title     按钮上的文字
 */
+ (void)setLeftButtonOn:(UIViewController*)vc
                 target:(id)theTarget
       callbackSelector:(SEL)sel
                  title:(NSString *)title;



/**
 *  设置导航栏有图片的右侧按钮
 *
 *  @param vc        当前VC
 *  @param theTarget 当前VC
 *  @param sel       回调方法
 *  @param image     按钮上的图片
 */
+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                   image:(UIImage *)image;

/**
 *  设置导航栏有图片的右侧按钮
 *
 *  @param vc        当前VC
 *  @param theTarget 当前VC
 *  @param sel       回调方法
 *  @param image     按钮上的图片
 *  @param highImage 高亮图片
 */
+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                   image:(UIImage *)image
               highImage:(UIImage *)highImage;


/**
 *  设置导航栏有文字的右侧按钮
 *
 *  @param vc        当前VC
 *  @param theTarget 当前VC
 *  @param sel       回调方法
 *  @param title     按钮上的文字
 */
+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                   title:(NSString *)title;


/**
 *  设置导航栏有文字的右侧按钮, 背景色自定义
 *
 *  @param vc        当前VC
 *  @param theTarget 当前VC
 *  @param sel       回调方法
 *  @param title     按钮上的文字
 *  @param bgColor   按钮的背景颜色
 */
+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                   title:(NSString *)title
                 BGColor:(UIColor*)bgColor;

/**
 *  设置导航栏自定义view的右侧按钮
 *
 *  @param vc        当前VC
 *  @param theTarget 当前VC
 *  @param sel       回调方法
 *  @param view      自定义view
 */
+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                    view:(UIView *)view;

/**
 *  设置左侧无返回按钮
 *
 *  @param vc 当前VC
 */
+ (void)setBackButtonNil:(UIViewController *)vc;

/**
 *  设置无右侧按钮
 *
 *  @param vc 当前VC
 */
+ (void)setRightButtonNil:(UIViewController *)vc;


/**
 *  设置左侧按钮不显示
 *
 *  @param vc 当前VC
 */
+ (void)setNoneLeftButton:(UIViewController *)vc;


@end
