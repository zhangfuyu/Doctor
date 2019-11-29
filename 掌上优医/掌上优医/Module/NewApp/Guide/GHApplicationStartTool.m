//
//  GHApplicationStartTool.m
//  掌上优医
//
//  Created by GH on 2018/10/24.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHApplicationStartTool.h"

#import "GHGuideViewController.h"

#import "GHNLoginViewController.h"

#import "GHTabBarControllerController.h"
#import "GHNavigationViewController.h"


@interface GHApplicationStartTool ()<GHGuideViewControllerDelegate>

@property (nonatomic, assign) NSUInteger likeTotalPage;

@property (nonatomic, assign) NSUInteger likeCurrentPage;

@property (nonatomic, assign) NSUInteger likePageSize;

@end

@implementation GHApplicationStartTool

+ (instancetype)shareInstance {
    
    static GHApplicationStartTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[GHApplicationStartTool alloc] init];
    });
    return _tool;
    
}

- (UIViewController *)getStartViewController {

    [[GHUserModelTool shareInstance] loadUserDefaultToSandBox];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"IsFirstComeInAPP%@", [JFTools shortVersion]]] isEqualToString:@"NO"]) {

        if ([GHUserModelTool shareInstance].isLogin) {
            
            // 如果是登录状态, 去获取用户信息
            [self getUserInfoData];
            
        }
        
        // 不是第一次打开, 去到首页
        return [self getHomeViewController];
        
    } else {
        
        // 第一次打开, 去到引导页
        return [self getGuideViewController];
    }
    
}

- (void)getUserInfoData {
    
    // 获取用户信息
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiUserMe withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [GHUserModelTool shareInstance].userInfoModel = [[GHUserInfoModel alloc] initWithDictionary:response error:nil];
            
            if ([GHUserModelTool shareInstance].userInfoModel == nil || [[GHUserModelTool shareInstance].userInfoModel.status intValue] == 2) {
                
                [[GHUserModelTool shareInstance] removeAllProperty];
                
                [GHUserModelTool shareInstance].isLogin = false;
                
                [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
                
                [[GHSaveDataTool shareInstance] userLogoutRemoveAllNotice];
                
            }
            
            
        } else {
            
        }
        
    }];
    
    // 获取用户的点赞信息 循环获取
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.likeCurrentPage = 0;
        self.likeTotalPage = 1;
        self.likePageSize = 1000;
        
        [self getLikeDataAction];
        
    });
    
}


- (void)getMoreLikeData{
    self.likeCurrentPage += self.likePageSize;
    [self getLikeDataAction];
}


- (void)getLikeDataAction {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"pageSize"] = @(self.likePageSize);
    params[@"from"] = @(self.likeCurrentPage);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiLikeMy withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        
        if (isSuccess) {
            
            NSLog(@"%@", params);
            
            if (self.likeCurrentPage == 0) {
                [[GHZoneLikeManager shareInstance].systemCommentLikeIdArray removeAllObjects];
            }
            
            for (NSDictionary *dicInfo in response) {
                
                if ([dicInfo[@"userId"] longValue] == [[GHUserModelTool shareInstance].userInfoModel.modelId longValue]) {
                    
                    if ([dicInfo[@"likeContentType"] integerValue] == 4) {
                        // 帖子
                        [[GHZoneLikeManager shareInstance].systemCommentLikeIdArray addObject:[NSString stringWithFormat:@"%ld", [dicInfo[@"likeContentId"] longValue]]];
                    }
                    
                }
                
            }
            
            if (((NSArray *)response).count >= self.likePageSize) {
                [self getMoreLikeData];
            }
            
        }
        
    }];
    
}



// 首页
- (UIViewController *)getHomeViewController {
    
    NSArray *vcInfoArray = @[
                         @{@"clsName" : @"GHNewHomeViewController", @"title" : @"首页", @"normalImageName" : @"tabbar_home_unselected", @"selectedImageName" : @"tabbar_home_selected",},

                         @{@"clsName" : @"GHNPersonCenterViewController", @"title" : @"个人中心", @"normalImageName" : @"tabbar_personcenter_unselected", @"selectedImageName" : @"tabbar_personcenter_selected",}
                         ];
    
    GHTabBarControllerController *tabbarVC = [[GHTabBarControllerController alloc] init];
    
    NSMutableArray<UIViewController *> *vcArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *vcInfo in vcInfoArray) {
        
        GHNavigationViewController *nav = [self setupChildVCWithClsName:vcInfo[@"clsName"] withTitle:vcInfo[@"title"] withNormalImageName:vcInfo[@"normalImageName"] withSelectedImageName:vcInfo[@"selectedImageName"]];
        
        [vcArray addObject:nav];
        
    }
    
    tabbarVC.viewControllers = [vcArray copy];
    
    return tabbarVC;
}

- (GHNavigationViewController *)setupChildVCWithClsName:(NSString *)clsName withTitle:(NSString *)title withNormalImageName:(NSString *)normalImageName withSelectedImageName:(NSString *)selectedImageName {
    
    if (clsName.length) {
        
        UIViewController *vc = [[NSClassFromString(clsName) alloc] init];
        GHNavigationViewController *nav = [[GHNavigationViewController alloc] initWithRootViewController:vc];
        vc.tabBarItem.title = ISNIL(title);
        [vc.tabBarItem setImage:[UIImage imageNamed:ISNIL(normalImageName)]];
        [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:ISNIL(selectedImageName)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];

        normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];

        normalAttrs[NSForegroundColorAttributeName] = UIColorHex(0x999999);

        [vc.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];

        NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];

        selectedAttrs[NSForegroundColorAttributeName] = kDefaultBlueColor;

        [vc.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
        return nav;
        
    }
    
    return nil;
    
}

// 登陆注册页
- (UIViewController *)getLoginOrRegisterViewController {
    return [[GHNLoginViewController alloc] init];
}

// 引导页
- (UIViewController *)getGuideViewController {
    
    GHGuideViewController *vc = [[GHGuideViewController alloc] init];
    vc.delegate = self;
    return vc;
}

// 切换 RootViewController 为首页
- (void)changeRootViewController {
 
    kWindow.rootViewController = [self getHomeViewController];
    
}

@end
