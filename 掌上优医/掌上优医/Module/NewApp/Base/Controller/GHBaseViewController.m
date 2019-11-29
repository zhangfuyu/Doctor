//
//  GHBaseViewController.m
//  掌上优医
//
//  Created by GH on 2018/10/24.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseViewController.h"
#import "UINavigationItem+XSDExt.h"
#import "GHNLoginViewController.h"

@interface GHBaseViewController ()

@property (nonatomic, strong) UIView *emptyView;

@end

@implementation GHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.navigationController.viewControllers.count > 1) {
        [self addBackButton];
    }
    
    [self setEmptyDataEmptyView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.view setExclusiveTouch:true];
    
    //开启右滑返回功能
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    

    if ([GHUserModelTool shareInstance].isHaveNetwork == false) {
        [self loadingNotNetworkEmptyView];
    }
    
//    if ([GHUserModelTool shareInstance].isHaveNetwork == true) {
//        // 如果有网络
//        
//        if ([GHUserModelTool shareInstance].isLogin == true) {
//            
//            // 如果已经登录
//            
//            if ([GHUserModelTool shareInstance].userInfoModel == nil) {
//                
//                // 但是没有用户信息
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    
//                    if ([GHUserModelTool shareInstance].userInfoModel == nil) {
//                        
//                        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiUserMe withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
//                            
//                            if (isSuccess) {
//                                
//                                [GHUserModelTool shareInstance].userInfoModel = [[GHUserInfoModel alloc] initWithDictionary:response error:nil];
//                                
//                                if ([GHUserModelTool shareInstance].userInfoModel == nil || [[GHUserModelTool shareInstance].userInfoModel.status intValue] == 2) {
//                                    
//                                    [[GHUserModelTool shareInstance] removeAllProperty];
//                                    
//                                    [GHUserModelTool shareInstance].isLogin = false;
//                                    
//                                    [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
//                                    
//                                    [[GHSaveDataTool shareInstance] userLogoutRemoveAllNotice];
//                                    
//                                }
//                                
//                                
//                            } else {
//                                
//                            }
//                            
//                        }];
//                        
//                    }
//                    
//                    
//                });
//                
//            }
//            
//        }
//        
//    }
//    
    
}

- (void)loadingNotNetworkEmptyView {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([GHUserModelTool shareInstance].isHaveNetwork == false) {
            
            if (self.navigationController.viewControllers.count > 1) {
             
                UIView *emptyView = [[UIView alloc] init];
                emptyView.backgroundColor = [UIColor whiteColor];
                
                [self.view addSubview:emptyView];
                [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.right.bottom.mas_equalTo(0);
                }];
                
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [emptyView addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(emptyView).offset(-30);
                    make.centerX.equalTo(emptyView);
                    make.size.mas_equalTo(CGSizeMake(300, 110));
                }];
                
                UILabel *tipLabel = [[UILabel alloc] init];
                tipLabel.font = H14;
                tipLabel.textColor = kDefaultGrayTextColor;
                tipLabel.textAlignment = NSTextAlignmentCenter;
                [emptyView addSubview:tipLabel];
                [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(emptyView);
                    make.top.equalTo(imageView.mas_bottom).offset(0);
                    make.height.mas_equalTo(60);
                }];
                
                
                imageView.image = [UIImage imageNamed:@"no_network"];
                tipLabel.text = @"没有信号";
                
            }
            
        }
        
    });
    

    
}

-(void)setEmptyDataEmptyView{
    
    UIView *emptyView = [[UIView alloc] init];
    self.emptyView = emptyView;
    
    [self.view addSubview:emptyView];
    [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-30);
        make.size.mas_equalTo(CGSizeMake(0.5*SCREENWIDTH, 0.5*SCREENWIDTH));
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [emptyView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emptyView).offset(0);
        make.centerX.equalTo(emptyView);
        make.size.mas_equalTo(CGSizeMake(300, 110));
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = H14;
    tipLabel.textColor = kDefaultGrayTextColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [emptyView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(emptyView);
        make.top.equalTo(imageView.mas_bottom).offset(0);
        make.height.mas_equalTo(60);
    }];
    emptyView.hidden = YES;
    
    if ([NSStringFromClass([self class]) hasPrefix:@"GHSearch"] || [NSStringFromClass([self class]) hasPrefix:@"GHNSearch"]) {
        imageView.image = [UIImage imageNamed:@"no_search"];
        tipLabel.text = @"暂无搜索结果";
    } else if ([NSStringFromClass([self class]) isEqualToString:@"GHNoticeMessageViewController"] || [NSStringFromClass([self class]) isEqualToString:@"GHNoticeMessageSystemViewController"]) {
        imageView.image = [UIImage imageNamed:@"no_data"];
        tipLabel.text = @"暂无消息";
    } else if ([NSStringFromClass([self class]) isEqualToString:@"GHMyCommentsListViewController"]) {
        imageView.image = [UIImage imageNamed:@"no_comments"];
        tipLabel.text = @"暂无点评";
    } else if ([NSStringFromClass([self class]) isEqualToString:@"GHNCoinRecordViewController"]) {
        imageView.image = [UIImage imageNamed:@"no_coin_record"];
        tipLabel.text = @"暂无星医分明细";
    } else {
        imageView.image = [UIImage imageNamed:@"no_data"];
        tipLabel.text = @"暂无数据";
    }
    
    
    if ([NSStringFromClass([self class]) hasPrefix:@"GHSicknessDoctorListViewController"]) {
        [emptyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view).offset(30);
        }];
    }
    
}

-(void)loadingEmptyView{
    
    self.emptyView.hidden = NO;
    //    [self.view addSubview:self.emptyView];
    
    UITableView *tableView;
    
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UITableView class]]) {
            tableView = (UITableView *)view;
        }
        
    }
    
    if (tableView) {
        [self.view insertSubview:self.emptyView aboveSubview:tableView];
    } else {
         [self.view bringSubviewToFront:self.emptyView];
    }
    
   
}

-(void)hideEmptyView{
    self.emptyView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //停止下载所有图片
    //    [[SDWebImageManager sharedManager] cancelAll];
    //清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)dealloc{
    [SVProgressHUD dismiss];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NSLog(@"%@对象已销毁", self);
}


//- (void)checkAlpha {
//  NSInteger count = self.navigationController.viewControllers.count;
//  if (count == 2) {
//    UIViewController *vc = [self.navigationController.viewControllers firstObject];
//    BOOL isNavAlpha = vc.navigationController.isNavAlpha;
//    if (isNavAlpha) {
//      [self addNavAlphaInView:self.view];
//    }
//  }
//}

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    
//    if (self.navigationController.viewControllers.count > 1) {
//        self.navigationController.navigationBar.hidden = false;
//    }
//    
//}


- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)setNavigationTitle:(NSString *)title {
    self.navigationItem.title = title;
}


- (void)addRightButton:(SEL)selector
                 image:(UIImage *)image
             highImage:(UIImage *)highImage {
    [UINavigationItem setRightButtonOn:self
                                target:self
                      callbackSelector:selector
                                 image:image
                             highImage:highImage];
}


- (void)addRightButton:(SEL)selector
                 image:(UIImage *)image {
    [UINavigationItem setRightButtonOn:self
                                target:self
                      callbackSelector:selector
                                 image:image];
}

- (void)addRightButton:(SEL)selector
                  view:(UIView *)view {
    [UINavigationItem setRightButtonOn:self
                                target:self
                      callbackSelector:selector
                                  view:view];
}


- (void)addRightButton:(SEL)selector
                 title:(NSString *)title {
    [UINavigationItem setRightButtonOn:self
                                target:self
                      callbackSelector:selector
                                 title:title];
}

- (void)addBackButton {
    [UINavigationItem setLeftButtonOn:self target:self callbackSelector:@selector(back:)];
}

- (void)addDismissButton {
    [UINavigationItem setLeftButtonOn:self target:self callbackSelector:@selector(dismissBack:)];
}

- (void)addLeftButton:(SEL)selector
                title:(NSString *)title {
    [UINavigationItem setLeftButtonOn:self
                               target:self
                     callbackSelector:selector
                                title:title];
}

-(void)addLeftButton:(SEL)selector image:(UIImage*)image{
    [UINavigationItem setLeftButtonOn:self target:self callbackSelector:selector image:image];
    
}
-(void)addLeftButton:(SEL)selector title:(NSString *)title image:(UIImage *)image{
    [UINavigationItem setLeftButtonOn:self target:self callbackSelector:selector image:image title:title];
}

- (void)addLeftButton:(SEL)selector {
    [UINavigationItem setLeftButtonOn:self
                               target:self
                     callbackSelector:selector];
}

- (void)hideLeftButton {
    [UINavigationItem setNoneLeftButton:self];
}

// 未登录处理
- (void)unLoginWarning {
    
    GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
    [self presentViewController:vc animated:false completion:nil];
    
}

- (void)setupNavigationStyle:(GHNavigationBarStyle)style {
    
    if (style == GHNavigationBarStyleWhite) {
        //设置导航栏颜色
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
        
//        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setShadowImage:nil];
        
        ((UILabel *)self.navigationItem.titleView).textColor = UIColorHex(0x333333);
        
        if (self.navigationController.viewControllers.count > 1) {
            [self addLeftButton:@selector(gotoPopAction) image:[UIImage imageNamed:@"login_back"]];
        }
        
        

    } else {

        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
        
        //        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        //        [self.navigationController.navigationBar setShadowImage:nil];
        
        ((UILabel *)self.navigationItem.titleView).textColor = UIColorHex(0x333333);
        
        if (self.navigationController.viewControllers.count > 1) {
            [self addLeftButton:@selector(gotoPopAction) image:[UIImage imageNamed:@"login_back"]];
        }
        
        
        
//        self.navigationController.navigationBar.barTintColor = kDefaultBlueColor;
//        self.navigationController.navigationBar.backgroundColor = kDefaultBlueColor;
//
////        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
////        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//
//        ((UILabel *)self.navigationItem.titleView).textColor = [UIColor whiteColor];
//
//        [self addLeftButton:@selector(gotoPopAction) image:[UIImage imageNamed:@"white_back"]];

    }
    
}

- (void)gotoPopAction {
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [MobClick endLogPageView:NSStringFromClass([self class])];
    
}


@end
