//
//  GHNavigationViewController.m
//  掌上优医
//
//  Created by GH on 2018/10/24.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHNavigationViewController.h"

@interface GHNavigationViewController ()

@end

@implementation GHNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.navigationBar.translucent = NO;
    //设置导航栏颜色
    self.navigationBar.barTintColor = kDefaultBlueColor;
    self.navigationBar.backgroundColor = kDefaultBlueColor;
    //去掉导航栏底部的线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
//    //设置导航栏透明度
//    self.edgesForExtendedLayout = 0;
//    self.navigationBar.barStyle = UIBarStyleDefault;
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//
//    如果不想影响其他页面的导航透明度，viewWillDisappear将其设置为nil即可:
//
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    
    
    //设置导航栏透明度
//    self.edgesForExtendedLayout = 0;
//    self.navigationBar.barStyle = UIBarStyleDefault;
    
    // Do any additional setup after loading the view.
}

// 重写自定义的UINavigationController中的push方法
// 处理tabbar的显示隐藏
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    
    [SVProgressHUD dismiss];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [super pushViewController:viewController animated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
