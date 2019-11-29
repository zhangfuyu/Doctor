//
//  UINavigationItem+XSDExt.m
//  TCPF
//
//  Created by 浩 胡 on 15/10/2.
//  Copyright © 2015年 XSD. All rights reserved.
//

#import "UINavigationItem+XSDExt.h"
//#import <UINavigationItem+SXFixSpace.h>
//#import "UIImage+XSDExt.h"
//#import "CCCBusinessHeader.h"
//#import "CCCTools.h"

@implementation UINavigationItem (XSDExt)


+ (void)setBackButtonNil:(UIViewController*)vc {
    vc.navigationItem.leftBarButtonItem = nil;
}


+ (void)setRightButtonNil:(UIViewController*)vc {
    vc.navigationItem.rightBarButtonItem = nil;
}

// 设置左侧按钮不显示
+ (void)setNoneLeftButton:(UIViewController *)vc {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 42)];
    btn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    vc.navigationItem.leftBarButtonItem = backBtn;
}


+ (void)setLeftButtonOn:(UIViewController *)vc
                 target:(id)theTarget
       callbackSelector:(SEL)sel {
    [self setLeftButtonOn:vc target:theTarget callbackSelector:sel image:[UIImage imageNamed:@"login_back"]];
}


+ (void)setLeftButtonOn:(UIViewController*)vc
                 target:(id)theTarget
       callbackSelector:(SEL)sel
                  image:(UIImage *)image {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(-10, 0, 50, 44)];
    btn.backgroundColor = [UIColor clearColor];
    btn.showsTouchWhenHighlighted = NO;
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    


    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    backBtn.tag = 9528;
    
    
    
//    if (@available(iOS 11.0,*)) {
//    } else {
//
//        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        spaceItem.width = -10.0f;
//
//    }

    
    vc.navigationItem.leftBarButtonItem = backBtn;
}
//设置左侧带图片带文字的按钮
+(void)setLeftButtonOn:(UIViewController *)vc
                target:(id)theTarget
               callbackSelector:(SEL)sel
                 image:(UIImage *)image
                 title:(NSString *)title{
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 64)];
    btn.showsTouchWhenHighlighted = NO;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0,20);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 15);
    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    backBtn.tag = 9528;
    
    vc.navigationItem.leftBarButtonItem = backBtn;
}


+ (void)setLeftButtonOn:(UIViewController*)vc
                 target:(id)theTarget
       callbackSelector:(SEL)sel
                  image:(UIImage *)image
              highImage:(UIImage *)highImage {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width+10, 40)];
    btn.showsTouchWhenHighlighted = NO;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    backBtn.tag = 9528;
    
    vc.navigationItem.leftBarButtonItem = backBtn;
}



+ (void)setLeftButtonOn:(UIViewController*)vc
                 target:(id)theTarget
       callbackSelector:(SEL)sel
                  title:(NSString *)title {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    btn.showsTouchWhenHighlighted = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.minimumScaleFactor = 10.f;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];

    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:btn];

    vc.navigationItem.leftBarButtonItem = leftButton;
}



// 设置右侧的按钮
+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                   image:(UIImage *)image {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    btn.showsTouchWhenHighlighted = NO;
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];

    vc.navigationItem.rightBarButtonItem = rightBtn;
}

+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                    view:(UIView *)view {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:theTarget action:sel];
    [view addGestureRecognizer:tapGesture];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:view];
    vc.navigationItem.rightBarButtonItem = rightBtn;
}


+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                   title:(NSString *)title {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    btn.showsTouchWhenHighlighted = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.minimumScaleFactor = 10.f;
    [btn setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    if (title.length < 5) {
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -20);
    }
    
    
    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    vc.navigationItem.rightBarButtonItem = rightBtn;
}

+ (void)setRightButtonOn:(UIViewController *)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                   title:(NSString *)title
                 BGColor:(UIColor *)bgColor {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 22)];
    btn.showsTouchWhenHighlighted = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    btn.layer.borderColor = [[UIColor whiteColor] CGColor];
    btn.layer.borderWidth = 1.5f;
    btn.layer.cornerRadius = 4.0f;
    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];

    vc.navigationItem.rightBarButtonItem = rightBtn;
}


// 设置右侧的按钮
+ (void)setRightButtonOn:(UIViewController*)vc
                  target:(id)theTarget
        callbackSelector:(SEL)sel
                   image:(UIImage *)image
               highImage:(UIImage *)highImage {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width+10, 40)];
    btn.showsTouchWhenHighlighted = NO;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:theTarget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    vc.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)setTitle:(NSString *)title {

    UIFont *font = HM18;
//    CGSize textSize = [CCCTools autoCalculateRectWithTitle:title font:18.0f size:CGSizeMake(CCCScreenWidth, 18)];

    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,100, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 10.f;

    label.backgroundColor = [UIColor clearColor];
    label.font = font;

    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColorHex(0x333333);
    label.text = title;
    
    if(![self isMemberOfClass:NSClassFromString(@"_UISearchBarNavigationItem")]) {
        self.titleView = label;
    }
}


@end
