//
//  GHSetupViewController.m
//  掌上优医
//
//  Created by GH on 2018/10/26.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHSetupViewController.h"
#import "GHSetupNoticeTableViewCell.h"
#import "GHSetupTableViewCell.h"

#import "GHNChangePasswordViewController.h"

@interface GHSetupViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *logoutButton;

@property (nonatomic, assign) CGFloat fileSize;

@end

@implementation GHSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    // Do any additional setup after loading the view.
    [self setupUI];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        [self folderSize];
        
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldReloadTableView) name:kNotificationWillEnterForeground object:nil];
    
    
    
//    if ([GHUserModelTool shareInstance].isZheng && [GHUserModelTool shareInstance].isLogin) {
//
//        [self addRightButton:@selector(clickChangePasswordAction) title:@" 修改密码"];
//
//    }
}

- (void)clickChangePasswordAction {
    
    GHNChangePasswordViewController *vc = [[GHNChangePasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)shouldReloadTableView {
    
    [self.tableView reloadData];
    
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultLineViewColor;
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    tableView.backgroundColor = kDefaultLineViewColor;
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.tableView = tableView;
    
    if ([GHUserModelTool shareInstance].isLogin) {
        [self setupTableFooterView];
    }
    
}

- (void)setupTableFooterView {
    
    UIView *view = [[UIView alloc] init];
//    view.frame = CGRectMake(0, 0, SCREENWIDTH, 115);
    view.backgroundColor = kDefaultLineViewColor;
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(47);
        make.top.mas_equalTo(160 + HScaleHeight(104));
    }];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.backgroundColor = kDefaultBlueColor;
    logoutButton.layer.cornerRadius = 5;
//    [logoutButton setBackgroundImage:[UIImage imageNamed:@"btn_shezhi_tuchudenglu_selected"] forState:UIControlStateSelected];
//    [logoutButton setBackgroundImage:[UIImage imageNamed:@"btn_shezhi_tuchudenglu_unselected"] forState:UIControlStateNormal];
    logoutButton.titleLabel.font = H16;
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview:logoutButton];
    
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(47);
        make.bottom.mas_equalTo(0);
    }];
    self.logoutButton = logoutButton;
    [logoutButton addTarget:self action:@selector(clickLogoutAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickLogoutAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    NSLog(@"退出登录");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认退出登录?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableDictionary *para = [@{
                                      @"Authorization":[GHUserModelTool shareInstance].token,
                                      @"":[GHUserModelTool shareInstance].token
                                      }copy];
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiLogout withParameter:para withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
            
            if (isSuccess) {
                
             
                [SVProgressHUD showSuccessWithStatus:@"退出登录成功"];

            }
            
        }];
        
        [SVProgressHUD showSuccessWithStatus:@"退出登录成功"];
        
        [[GHZoneLikeManager shareInstance].systemCommentLikeIdArray removeAllObjects];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if ([GHUserModelTool shareInstance].registerId.length) {
                [self unbindingPushDevAction];
            }
            
        });
        

        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[GHUserModelTool shareInstance] removeAllProperty];
            
            [GHUserModelTool shareInstance].isLogin = false;
            
            [[GHUserModelTool shareInstance] saveUserDefaultToSandBox];
            
            [[GHSaveDataTool shareInstance] userLogoutRemoveAllNotice];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
            
            [self.navigationController popViewControllerAnimated:true];
            
        });

        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    
    [self presentViewController:alertController animated:true completion:nil];
    

 
    
}

/**
 解除绑定设备 ID
 */
- (void)unbindingPushDevAction {
    
    if ([GHUserModelTool shareInstance].registerId.length) {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"devId"] = [GHUserModelTool shareInstance].registerId;
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_DELETE withUrl:kApiPushDevUser withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            if (isSuccess) {
                
                NSLog(@"设备 ID 解除绑定成功");
                
            }
            
        }];
        
    }
    
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 50;
    } else if (indexPath.row == 1) {
        return 50;
    }
    
    return 50;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kDefaultLineViewColor;
    view.frame = CGRectMake(0, 0, SCREENWIDTH, 6);
    
    return view;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (indexPath.row == 0) {
        
        GHSetupNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHSetupNoticeTableViewCell"];
        
        if (!cell) {
            cell = [[GHSetupNoticeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHSetupNoticeTableViewCell"];
        }
        
        [cell checkState];
        
        return cell;
        
    } else {
        
        GHSetupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHSetupTableViewCell"];
        
        if (!cell) {
            cell = [[GHSetupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHSetupTableViewCell"];
        }
        
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"清除缓存";
            cell.descLabel.text = [NSString stringWithFormat:@"%.2fM", self.fileSize];
            cell.arrowImageView.hidden = true;
            cell.descLabel.hidden = false;
        } else if (indexPath.row == 2) {
            cell.titleLabel.text = @"评价我们";
            cell.arrowImageView.hidden = false;
            cell.descLabel.hidden = true;
        }
        
        return cell;

        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
//        [self gotoSetupNotificationAction];
    } else if (indexPath.row == 1) {
        [self cleanAPPCacheAction];
    } else if (indexPath.row == 2) {
        [self gotoCommentAction];
    }
    
}

- (void)gotoSetupNotificationAction {

    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if (@available(iOS 10.0, *)) {
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
        
    } else {
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
        
    }
    
}

- (void)cleanAPPCacheAction {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清除缓存" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        

        //===============清除缓存==============
        //获取路径
        NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
        
        //返回路径中的文件数组
        NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
        
        NSLog(@"文件数：%ld",[files count]);
        for(NSString *p in files){
            NSError*error;
            
            NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
            
            if([[NSFileManager defaultManager]fileExistsAtPath:path])
            {
                BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
                if(isRemove) {
                    NSLog(@"清除成功");
                    //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
                    [SVProgressHUD showSuccessWithStatus:@"缓存清理成功"];
                    self.fileSize = 0;
                    [self.tableView reloadData];
                    
                }else{
                    
                    NSLog(@"清除失败");
                    
                }
            }
        }
        
        
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

// 缓存大小
- (void)folderSize {
    
    CGFloat folderSize = 0.0;
    
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",files.count);
    
    for(NSString *path in files) {
        
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    
    self.fileSize = sizeM;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });

}


- (void)gotoCommentAction {
    
    NSString *itunesurl = kAppStoreItunesurl;
    
    if (@available(iOS 10.0, *)) {
        /// 10及其以上系统
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl] options:@{} completionHandler:nil];
    } else {
        /// 10以下系统
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl]];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
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
