//
//  GHTabBarControllerController.m
//  掌上优医
//
//  Created by GH on 2018/10/24.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHTabBarControllerController.h"
#import "GHTabBar.h"
#import "GHNSearchDoctorViewController.h"
#import "GHNavigationViewController.h"

#import "GHChooseCommentTypeView.h"

@interface GHTabBarControllerController ()<GHTabBarDelegate>

@end

@implementation GHTabBarControllerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
//    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
//    [self.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];

    // Do any additional setup after loading the view.
    
    //设置TabBar上第一个Item（明细）选中时的图片
//    UIImage *listActive = [UIImage imageNamed:@"ListIcon - Active(blue)"];
    UITabBarItem *listItem = self.tabBar.items[0];
    //始终按照原图片渲染
//    listItem.selectedImage = [listActive imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //设置TabBar上第二个Item（报表）选中时的图片
//    UIImage *chartActive = [UIImage imageNamed:@"ChartIcon - Active(blue)"];
    UITabBarItem *chartItem = self.tabBar.items[1];
    //始终按照原图片渲染
//    chartItem.selectedImage = [chartActive imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //创建自定义TabBar
    GHTabBar *myTabBar = [[GHTabBar alloc] init];
    myTabBar.myTabBarDelegate = self;
    
    //利用KVC替换默认的TabBar
    [self setValue:myTabBar forKey:@"tabBar"];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //设置TabBar的TintColor
    self.tabBar.tintColor = [UIColor colorWithRed:89/255.0 green:217/255.0 blue:247/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - MyTabBarDelegate
-(void)addButtonClickAction
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    GHChooseCommentTypeView *commentTypeView = [GHChooseCommentTypeView shareInstance];
    commentTypeView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    
    [window addSubview:commentTypeView];
    
//    GHTabBarControllerController *tabbarVC = (GHTabBarControllerController *)window.rootViewController;
//    GHNavigationViewController *nav = [tabbarVC.viewControllers objectOrNilAtIndex:tabbarVC.selectedIndex];
//
//
    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    GHTabBarControllerController *tabbarVC = (GHTabBarControllerController *)window.rootViewController;
//    GHNavigationViewController *nav = [tabbarVC.viewControllers objectOrNilAtIndex:tabbarVC.selectedIndex];
//    [nav popToRootViewControllerAnimated:false];
//
//    GHNSearchDoctorViewController *vc = [[GHNSearchDoctorViewController alloc] init];
//    [nav pushViewController:vc animated:true];

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
