//
//  AppDelegate.m
//  掌上优医
//
//  Created by GH on 2018/10/23.
//  Copyright © 2018 GH. All rights reserved.
//

#import "AppDelegate.h"
#import "GHApplicationStartTool.h"
#import "GHNetworkTool.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>

#import "WXApi.h"

#import "NSDictionary+Extension.h"

#import "GHNoticeMessageSystemViewController.h"

#import "GHTabBarControllerController.h"

#import <NSDate+YYAdd.h>

#import "WeiboSDK.h"

#import <CoreLocation/CLLocationManager.h>

#import "GHInformationDetailViewController.h"

#import "GHDocterDetailViewController.h"

#import "GHHospitalDetailViewController.h"

#import "GHNDiseaseDetailViewController.h"

#import "OttoFPSButton.h"

@interface AppDelegate ()<JPUSHRegisterDelegate, WXApiDelegate, UNUserNotificationCenterDelegate, WeiboSDKDelegate>

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [GHUserModelTool shareInstance].isZheng = true;
    
    [self setupRootViewController];
   
    [self setupSVProgressHUD];
    
    [WXApi registerApp:kWXAppKey];
    
    [self setupUMSDK];
    
    [self setupJPushSDKWithOptions:launchOptions];
    
//    [self setupStartScreen];
    
    return YES;
    
}

// 设置启动屏
- (void)setupStartScreen {
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.contentMode = UIViewContentModeScaleAspectFill;
    topImageView.layer.masksToBounds = true;
    topImageView.image = [UIImage imageNamed:@"start_top_new"];
    [view addSubview:topImageView];
    
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(145);
        make.height.mas_equalTo(46);
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(HScaleHeight(77));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = UIColorHex(0x656565);
    titleLabel.font = H14;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"智能推荐 海量优质医生";
    [view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(topImageView.mas_bottom).offset(HScaleHeight(10));
    }];
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.layer.masksToBounds = true;
    bgImageView.image = [UIImage imageNamed:@"start_bg_new"];
    [view addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(HScaleHeight(294));
        make.height.mas_equalTo(HScaleHeight(318));
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(HScaleHeight(12));
    }];
    
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    logoImageView.layer.masksToBounds = true;
    logoImageView.image = [UIImage imageNamed:@"img_entry page_logo"];
    [view addSubview:logoImageView];
    
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(58);
        make.height.mas_equalTo(58);
        make.right.mas_equalTo(view.mas_centerX).mas_equalTo(-42);
        make.bottom.mas_equalTo(-35 + kBottomSafeSpace);
    }];
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.textColor = UIColorHex(0x333333);
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    titleLabel2.font = [UIFont fontWithName:@"PingFangSC-Semibold" size: 32] ? [UIFont fontWithName:@"PingFangSC-Semibold" size: 32] : [UIFont systemFontOfSize:32];
    titleLabel2.text = @"大众星医";
    [view addSubview:titleLabel2];
    
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoImageView.mas_right).offset(4);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(logoImageView.mas_top).offset(-4);
    }];
    
    UILabel *titleLabel3 = [[UILabel alloc] init];
    titleLabel3.textColor = UIColorHex(0x999999);
    titleLabel3.font = H14;
    titleLabel3.text = @"让  就  医  不  再  难";
    titleLabel3.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel3];
    
    [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(logoImageView.mas_right).offset(4);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(titleLabel2.mas_bottom);
    }];
    
    if (kiPhone4 || iPad) {
        [topImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
        }];
        [logoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-15);
        }];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [UIView animateWithDuration:1 animations:^{
            view.alpha = 0;
        }];
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];        
    });
    
}

// 初始化 SVProgressHUD
- (void)setupSVProgressHUD {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setMaximumDismissTimeInterval:5];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
}

/**
 初始化根控制器
 */
- (void)setupRootViewController {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[GHApplicationStartTool shareInstance] getStartViewController];
    
    [[UITabBar appearance] setTranslucent:NO];
    
    [self.window makeKeyAndVisible];

}

/**
 初始化极光推送 SDK
 */
- (void)setupJPushSDKWithOptions:(NSDictionary *)launchOptions {
    
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    /*!
     * @abstract 启动SDK
     *
     * @param launchingOption 启动参数.
     * @param appKey 一个JPush 应用必须的,唯一的标识. 请参考 JPush 相关说明文档来获取这个标识.
     * @param channel 发布渠道. 可选.
     * @param isProduction 是否生产环境. 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.
     *                     App 证书环境取决于profile provision的配置，此处建议与证书环境保持一致.
     * @param advertisingIdentifier 广告标识符（IDFA） 如果不需要使用IDFA，传nil.
     *
     * @discussion 提供SDK启动必须的参数, 来启动 SDK.
     * 此接口必须在 App 启动时调用, 否则 JPush SDK 将无法正常工作.
     */
#ifdef DEBUG
    [JPUSHService setupWithOption:launchOptions appKey:JPushSDKKey channel:@"" apsForProduction:NO];
#else
    [JPUSHService setupWithOption:launchOptions appKey:JPushSDKKey channel:@"" apsForProduction:YES];
#endif
    
//    [JPUSHService setupWithOption:launchOptions appKey:JPushSDKKey channel:@"" apsForProduction:true];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        if (registrationID.length) {
            
            [GHUserModelTool shareInstance].registerId = registrationID;

        }
        
    }];
    
    // apn 内容获取：
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (remoteNotification != nil) {
        NSLog(@"%@", remoteNotification);
    }
    
    if (@available(iOS 10.0, *)) {
        //iOS10特有
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        // 必须写代理，不然无法监听通知的接收与点击
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 点击允许
                NSLog(@"注册成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@", settings);
                }];
            } else {
                // 点击不允许
                NSLog(@"注册失败");
            }
        }];
    } else {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"notification:%@", notification);
    
    NSDictionary *userInfo = notification.userInfo;
    
    [[((GHTabBarControllerController *)kWindow.rootViewController).viewControllers objectOrNilAtIndex:((GHTabBarControllerController *)kWindow.rootViewController).selectedIndex] pushViewController:[[GHNoticeMessageSystemViewController alloc] init] animated:false];
   
}


#pragma mark - UNUserNotificationCenterDelegate
//在展示通知前进行处理，即有机会在展示通知前再修改通知内容。
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    //1. 处理通知
    [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWillEnterForeground object:nil];
    [JPUSHService setBadge:[UIApplication sharedApplication].applicationIconBadgeNumber];
    //2. 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
    completionHandler(UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            NSLog(@"iOS10 收到远程通知:%@", response);
            
            NSDictionary *userInfo = response.notification.request.content.userInfo;
            
            [[((GHTabBarControllerController *)kWindow.rootViewController).viewControllers objectOrNilAtIndex:((GHTabBarControllerController *)kWindow.rootViewController).selectedIndex] pushViewController:[[GHNoticeMessageSystemViewController alloc] init] animated:false];
            

            
        }
        else {
            NSLog(@"iOS10 收到本地通知:%@", response);
            
            [[((GHTabBarControllerController *)kWindow.rootViewController).viewControllers objectOrNilAtIndex:((GHTabBarControllerController *)kWindow.rootViewController).selectedIndex] pushViewController:[[GHNoticeMessageSystemViewController alloc] init] animated:false];
            

        }
    }
}

/**
 获取自定义消息推送内容
 
 只有在前端运行的时候才能收到自定义消息的推送。
 
 从 JPush 服务器获取用户推送的自定义消息内容和标题以及附加字段等。

 @param notification <#notification description#>
 */
- (void)networkDidReceiveMessage:(NSNotification *)notification {

}

- (void)registerNotificationWithTitle:(NSString *)title withUserInfo:(NSDictionary *)userInfo {
    
    if (title.length == 0) {
        return;
    }
    
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
//    content.title = [NSString localizedUserNotificationStringForKey:@"Hello!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:title
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    
    content.badge = @([content.badge integerValue] + 1);
    
    content.userInfo = userInfo;
    // 在 alertTime 后推送本地推送
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:.5 repeats:NO];
    
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:ISNIL([[NSDate date] stringWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"])
                                                                          content:content trigger:trigger];
    
    
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWillEnterForeground object:nil];
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        [alert addAction:cancelAction];
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }];

    
}

- (void)registerLocalNotificationInOldWayWithTitle:(NSString *)title withUserInfo:(NSDictionary *)userInfo {
    // ios8后，需要添加这个注册，才能得到授权
    //    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
    //        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    //        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
    //                                                                                 categories:nil];
    //        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    //        // 通知重复提示的单位，可以是天、周、月
    //    }
    
    if (title.length == 0) {
        return;
    }

    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:.5];
    NSLog(@"fireDate=%@",fireDate);

    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
//    notification.repeatInterval = kCFCalendarUnitSecond;

    
    // 通知内容
    notification.alertBody =  title;
    notification.applicationIconBadgeNumber += 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
//    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"开始学习iOS开发了" forKey:@"key"];
    notification.userInfo = userInfo;

    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
//        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
//        notification.repeatInterval = NSDayCalendarUnit;
    }

    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWillEnterForeground object:nil];
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    

}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
//    // APNs 内容为 userInfo
//    NSDictionary * userInfo = notification.request.content.userInfo;
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        [[((GHTabBarControllerController *)kWindow.rootViewController).viewControllers objectOrNilAtIndex:((GHTabBarControllerController *)kWindow.rootViewController).selectedIndex] pushViewController:[[GHNoticeMessageSystemViewController alloc] init] animated:false];
        
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        [[((GHTabBarControllerController *)kWindow.rootViewController).viewControllers objectOrNilAtIndex:((GHTabBarControllerController *)kWindow.rootViewController).selectedIndex] pushViewController:[[GHNoticeMessageSystemViewController alloc] init] animated:false];

    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    
    [[((GHTabBarControllerController *)kWindow.rootViewController).viewControllers objectOrNilAtIndex:((GHTabBarControllerController *)kWindow.rootViewController).selectedIndex] pushViewController:[[GHNoticeMessageSystemViewController alloc] init] animated:false];

    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    [JPUSHService handleRemoteNotification:userInfo];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWillEnterBackground object:nil];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    
    
//    [JPUSHService resetBadge];  // 重置角标
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; // APP 清空角标
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
        
        //定位功能可用
        [GHUserModelTool shareInstance].isHaveLocation = true;
        
    } else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        //定位不能用
        [GHUserModelTool shareInstance].isHaveLocation = false;
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWillEnterForeground object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [WXApi handleOpenURL:url delegate:self] || [WeiboSDK handleOpenURL:url delegate:self];
    
}


/**
 从 Safari 浏览器打开 APP 到指定页面

 @param app <#app description#>
 @param url <#url description#>
 @param sourceApplication <#sourceApplication description#>
 @param annotation <#annotation description#>
 @return <#return value description#>
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation {
    
    if ([ISNIL(url.absoluteString) hasPrefix:@"dzxy://"]) {
        
        NSArray *paramsArray = [self getParamsWithUrlString:ISNIL(url.absoluteString)];

        NSDictionary *params = [paramsArray lastObject];
        
        if (params) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
                if ([params[@"type"] integerValue] == 1) {
                    
                    GHInformationDetailViewController *vc = [[GHInformationDetailViewController alloc] init];
                    GHArticleInformationModel *model = [[GHArticleInformationModel alloc] init];
                    vc.informationId = params[@"id"];
                    model.modelId = params[@"id"];
                    model.title = [params[@"title"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    model.gmtCreate = [params[@"gmtCreate"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    vc.model = model;
                    
                    [[((GHTabBarControllerController *)kWindow.rootViewController).viewControllers objectOrNilAtIndex:((GHTabBarControllerController *)kWindow.rootViewController).selectedIndex] pushViewController:vc animated:false];
                    
                } else if ([params[@"type"] integerValue] == 2) {
                    
                    GHNDiseaseDetailViewController *vc = [[GHNDiseaseDetailViewController alloc] init];
                    vc.sicknessId = params[@"id"];
                    
                    vc.sicknessName = [GHFilterHTMLTool filterHTMLEMTag:[ISNIL(params[@"diseaseName"]) stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    vc.departmentName = [ISNIL(params[@"firstDepartmentName"]) stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    vc.symptom = [GHFilterHTMLTool filterHTMLEMTag:[ISNIL(params[@"symptom"]) stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    
                    [[((GHTabBarControllerController *)kWindow.rootViewController).viewControllers objectOrNilAtIndex:((GHTabBarControllerController *)kWindow.rootViewController).selectedIndex] pushViewController:vc animated:false];
                    
                } else if ([params[@"type"] integerValue] == 3) {
                    
                    GHDocterDetailViewController *vc = [[GHDocterDetailViewController alloc] init];
                    vc.doctorId = params[@"id"];
                    [[((GHTabBarControllerController *)kWindow.rootViewController).viewControllers objectOrNilAtIndex:((GHTabBarControllerController *)kWindow.rootViewController).selectedIndex] pushViewController:vc animated:false];
                    
                } else if ([params[@"type"] integerValue] == 4) {
                    
                    GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] init];
                    model.modelId = params[@"hospitalId"];
                    model.hospitalName = params[@"hospitalName"];
                    
                    GHHospitalDetailViewController *vc = [[GHHospitalDetailViewController alloc] init];
                    vc.model = model;
                   [[((GHTabBarControllerController *)kWindow.rootViewController).viewControllers objectOrNilAtIndex:((GHTabBarControllerController *)kWindow.rootViewController).selectedIndex] pushViewController:vc animated:false];
                    
                }
                
            });
            
        }
        
        return true;
        
    }
    
    return [WXApi handleOpenURL:url delegate:self] || [WeiboSDK handleOpenURL:url delegate:self];
    
}


- (void)onResp:(BaseResp*)resp {
    
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        
        SendAuthResp *sendAuthResp = ((SendAuthResp *)resp);
        if ([sendAuthResp.state isEqualToString:@"udoctor"] && sendAuthResp.errCode == 0) {
            
            // 是微信登录成功的回调
            NSString *code = sendAuthResp.code;
//            [self getWeiXinOpenId:code];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWeChatAuthSuccess object:nil userInfo:@{@"code":ISNIL(code)}];
            
        } else {
            
            // 微信登录失败
//              ERR_OK = 0(用户同意) ERR_AUTH_DENIED = -4（用户拒绝授权） ERR_USER_CANCEL = -2（用户取消）
            if (sendAuthResp.errCode == -4) {
                [SVProgressHUD showErrorWithStatus:@"您已拒绝登录授权"];
            } else if (sendAuthResp.errCode == -2) {
                [SVProgressHUD showErrorWithStatus:@"您已取消登录授权"];
            } else {
                [SVProgressHUD showErrorWithStatus:ISNIL(sendAuthResp.errStr)];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWeChatAuthFailed object:nil];

        }
        
    } else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        
        SendMessageToWXResp *sendMessageResp = ((SendMessageToWXResp *)resp);
        
        if (sendMessageResp.errCode == 0) {
            NSLog(@"微信分享成功");
            
            [self shareSuccessAction];
            
        }
        
    }
    
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        
        // 分享成功
        
        NSLog(@"分享成功");
        
        [self shareSuccessAction];
        
    }
    
}

- (void)shareSuccessAction{
    
    if ([GHUserModelTool shareInstance].isLogin) {
     
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"userId"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.modelId);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiBusinesstaskContentsharedtask withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
            
        }];

    }
    
}

/**
 设置友盟统计
 */
- (void)setupUMSDK {
    
    //开发者需要显式的调用此函数，日志系统才能工作
    [UMConfigure setLogEnabled:true];
    
    [UMConfigure initWithAppkey:kUMAppKey channel:nil];
    
    [MobClick setScenarioType:E_UM_NORMAL];

#ifdef DEBUG
#else
    [WeiboSDK registerApp:kSinaAppKey];
#endif
    
}

// 获取 URL 中的参数
- (NSArray *)getParamsWithUrlString:(NSString *)urlString {
    
    if(urlString.length==0) {
        
        NSLog(@"链接为空！");
        
        return @[@"",@{}];
        
    }
    //先截取问号
    
    NSArray *allElements = [urlString componentsSeparatedByString:@"?"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];//待set的参数字典
    
    
    
    if(allElements.count==2) {
        
        //有参数或者?后面为空
        
        NSString*myUrlString = allElements[0];
        
        NSString*paramsString = allElements[1];

        //获取参数对
        
        NSArray*paramsArray = [paramsString componentsSeparatedByString:@"&"];

        if(paramsArray.count>=2) {
            
            for(NSInteger i =0; i < paramsArray.count; i++) {
                
                NSString*singleParamString = paramsArray[i];
                
                NSArray*singleParamSet = [singleParamString componentsSeparatedByString:@"="];
                
                if(singleParamSet.count==2) {
                    
                    NSString*key = singleParamSet[0];
                    
                    NSString*value = singleParamSet[1];
                    
                    if(key.length>0|| value.length>0) {
                        
                        [params setObject:value.length>0?value:@""forKey:key.length>0?key:@""];
                        
                    }
                    
                }
                
            }
            
        }else if(paramsArray.count==1) {
            
            //无 &。url只有?后一个参数
            
            NSString*singleParamString = paramsArray[0];
            
            NSArray*singleParamSet = [singleParamString componentsSeparatedByString:@"="];
            
            if(singleParamSet.count==2) {
                
                NSString*key = singleParamSet[0];
                
                NSString*value = singleParamSet[1];
                
                if(key.length>0|| value.length>0) {
                    
                    [params setObject:value.length>0?value:@""forKey:key.length>0?key:@""];
                    
                }
                
            }else{
                
                //问号后面啥也没有 xxxx?  无需处理
                
            }
            
        }
        
        
        
        //整合url及参数
        
        return@[myUrlString,params];
        
    }else if(allElements.count>2) {
        
        NSLog(@"链接不合法！链接包含多个\"?\"");
        
        return @[@"",@{}];
        
    }else{
        
        NSLog(@"链接不包含参数！");
        
        return@[urlString,@{}];
        
    }
    
    
    
}

@end
