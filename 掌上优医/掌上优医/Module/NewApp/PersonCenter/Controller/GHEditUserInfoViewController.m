//
//  GHEditUserInfoViewController.m
//  掌上优医
//
//  Created by GH on 2018/11/2.
//  Copyright © 2018 GH. All rights reserved.
//
#import <NSDate+YYAdd.h>
#import "GHEditUserInfoViewController.h"
#import "GHEditInfoTableViewCell.h"

#import "GHEditUserInfoChangeNicknameViewController.h"


#import "GHEditInfoChooseSexView.h"

#import "GHEditInfoChooseBirthdayView.h"
#import "GHEditInfoChooseHeightView.h"
#import "GHEditInfoChooseWeightView.h"

@interface GHEditUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource, GHEditUserInfoChangeNicknameViewControllerDelegate, GHEditInfoChooseSexViewDelegate, GHEditInfoChooseHeightViewDelegate, GHEditInfoChooseWeightViewDelegate, GHEditInfoChooseBirthdayViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**
 性别选择
 */
@property (nonatomic, strong) GHEditInfoChooseSexView *sexView;

@property (nonatomic, strong) GHEditInfoChooseBirthdayView *birthdayView;

@property (nonatomic, strong) GHEditInfoChooseHeightView *heightView;

@property (nonatomic, strong) GHEditInfoChooseWeightView *weightView;



@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) GHUserInfoModel *model;

@end

@implementation GHEditUserInfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"编辑信息";
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
//    [self addRightButton:@selector(clickSaveAction) title:@"保存"];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    [self getUserInfoData];
    


}

- (void)clickChangePasswordAction {
    
}

- (void)dealloc {
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    
}

- (void)getUserInfoData {
    
//    [SVProgressHUD showWithStatus:kDefaultTipsText];
    NSMutableDictionary *parame = [@{@"Authorization":[GHUserModelTool shareInstance].token}copy];

    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiGetUserMe withParameter:parame withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [GHUserModelTool shareInstance].userInfoModel = [[GHUserInfoModel alloc] initWithDictionary:response[@"data"] error:nil];
            
            self.model = [[GHUserInfoModel alloc] initWithDictionary:response[@"data"] error:nil];

            [self.tableView reloadData];
            
        }
        
    }];
    
}

- (void)clickSaveAction {
    
//    if ([NSString stringContainsEmoji:ISNIL(self.model.nickName)]) {
//        [SVProgressHUD showErrorWithStatus:@"请填写正确的昵称,请勿包含表情等特殊字符"];
//        return;
//    }
//
//    if (ISNIL(self.model.nickName).length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"请填写您的昵称"];
//        return;
//    }
//
//    if ([self.model.sex integerValue] == 0) {
//        [SVProgressHUD showErrorWithStatus:@"请选择您的性别"];
//        return;
//    }
//
//    [SVProgressHUD showWithStatus:kDefaultTipsText];
//
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//
//    params[@"nickName"]  = ISNIL(self.model.nickName);
//
//    params[@"sex"] = self.model.sex;
//
//    params[@"profilePhoto"] = ISNIL(self.model.profilePhoto);
//
//
//    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_PUT withUrl:kApiUserMe withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
//
//        if (isSuccess) {
//            [SVProgressHUD showSuccessWithStatus:@"资料保存成功"];
//            [self.navigationController popViewControllerAnimated:true];
//        }
//
//    }];
    
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultLineViewColor;
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.backgroundColor = kDefaultLineViewColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.tableView = tableView;
    
    
    self.sexView = [[GHEditInfoChooseSexView alloc] init];
    self.sexView.delegate = self;
    [self.view addSubview:self.sexView];
    
    [self.sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.sexView.hidden = true;
    
    self.birthdayView = [[GHEditInfoChooseBirthdayView alloc] init];
    self.birthdayView.delegate = self;
    [self.view addSubview:self.birthdayView];
    
    [self.birthdayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.birthdayView.hidden = true;
    
    self.heightView = [[GHEditInfoChooseHeightView alloc] init];
    self.heightView.delegate = self;
    [self.view addSubview:self.heightView];
    
    [self.heightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.heightView.hidden = true;
    
    self.weightView = [[GHEditInfoChooseWeightView alloc] init];
    self.weightView.delegate = self;
    [self.view addSubview:self.weightView];
    
    [self.weightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.weightView.hidden = true;

    
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 50;
    }
    
    return 50;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kDefaultLineViewColor;
    view.frame = CGRectMake(0, 0, SCREENWIDTH, 10);
    
    return view;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHEditInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"GHEditInfoTableViewCell_%ld", (long)indexPath.row]];
    
    if (!cell) {
        cell = [[GHEditInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"GHEditInfoTableViewCell_%ld", (long)indexPath.row]];
    }
    
    if (indexPath.section == 0) {
        
        // 头像
        cell.style = GHEditInfoTableViewCellStyle_HeadPortrait;
        
        cell.descLabel.text = @"头像";
        
        self.headPortraitImageView = cell.headPortraitImageView;
        
        [cell.headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(self.model.avatar)) placeholderImage:[UIImage imageNamed:@"img_gerenzhongxin_touxiang_pressed"]];

    } else {
        
        if (indexPath.row == 0) {
            // 昵称
            
            cell.style = GHEditInfoTableViewCellStyle_Arrow;
            
            cell.titleLabel.text = @"昵称";
            
            cell.descLabel.text = ISNIL(self.model.nickName);
            
        } else if (indexPath.row == 1) {
            // 性别
            cell.style = GHEditInfoTableViewCellStyle_Default;
            
            cell.titleLabel.text = @"性别";
            
            if ([self.model.sex isEqualToString:@"M"]) {
                cell.descLabel.text = @"男";
            } else if ([self.model.sex isEqualToString:@"F"]) {
                cell.descLabel.text = @"女";
            }
            
        } else if (indexPath.row == 2) {
            // 来自
            cell.style = GHEditInfoTableViewCellStyle_Default;
            
            cell.titleLabel.text = @"生日";

            NSArray *timerarry = [self.model.birthday componentsSeparatedByString:@" "];
            
            cell.descLabel.text = [timerarry firstObject];

            
        } else if (indexPath.row == 3) {
            // 签名
            
            cell.style = GHEditInfoTableViewCellStyle_Default;
            
            cell.titleLabel.text = @"身高";
            
            if ([self.model.stature integerValue] > 0) {
                cell.descLabel.text = [NSString stringWithFormat:@"%ldcm", (long)[self.model.stature integerValue]];
            } else {
                cell.descLabel.text = @"";
            }
            
        } else if (indexPath.row == 4) {
            // 签名
            
            cell.style = GHEditInfoTableViewCellStyle_Default;
            
            cell.titleLabel.text = @"体重";
            
            if ([self.model.weight integerValue] > 0) {
                cell.descLabel.text = [NSString stringWithFormat:@"%ldkg", [self.model.weight integerValue]];
            } else {
                cell.descLabel.text = @"";
            }
            
        }
        
        if (cell.descLabel.text.length == 0) {
            cell.descLabel.text = @"未填写";
        }
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        [[GHPhotoTool shareInstance] takePhotoWithVC:self isPresent:false allowsEdit:true block:^(UIImage * _Nonnull originalImage, UIImage * _Nonnull image, NSData * _Nonnull data) {
           
            if (image) {
                
                [[GHUploadPhotoTool shareInstance] uploadImageWithImage:originalImage withMaxCapture:50 type:@"userPic" completion:^(NSString * _Nonnull urlStr, UIImage * _Nonnull thumbImage) {
                    self.model.avatar = ISNIL(urlStr);
                    
                    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                    params[@"avatar"] = urlStr;
                    
                    NSLog(@"%@", urlStr);
                    
                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiUserNickname withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                        
                        if (isSuccess) {
                            [SVProgressHUD showSuccessWithStatus:@"恭喜您,头像修改成功"];
                            [self.tableView reloadData];
                            
                        }
                        else
                        {
                            [SVProgressHUD showErrorWithStatus:@"头像修改失败"];
                        }
                        
                    }];
                }];
                
            }
            
        }];
        
    } else {
        
        if (indexPath.row == 0) {
            
            GHEditUserInfoChangeNicknameViewController *vc = [[GHEditUserInfoChangeNicknameViewController alloc] init];
            vc.delegate = self;
            vc.string = ISNIL(self.model.nickName);
            [self.navigationController pushViewController:vc animated:true];
            
        } else if (indexPath.row == 1) {
            
            self.sexView.hidden = false;
            
        } else if (indexPath.row == 2) {
            
            self.birthdayView.hidden = false;
            
        } else if (indexPath.row == 3) {
            
            self.heightView.hidden = false;
            
        } else if (indexPath.row == 4) {
            
            self.weightView.hidden = false;
            
        }
        
    }
    
}

- (void)finishEditNicknameWithText:(NSString *)str {
    
    self.model.nickName = ISNIL(str);
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"nickName"] = self.model.nickName;
    params[@"Authorization"] = [GHUserModelTool shareInstance].token;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiUserNickname withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"恭喜您,昵称修改成功"];
            [self.tableView reloadData];
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"昵称修改失败"];
        }
        
    }];
    
}

- (void)finishEditSexWithText:(NSString *)str {
    
    self.model.sex = ISNIL(str);
    if ([str isEqualToString:@"2"]) {
        self.model.sex = @"M";
    } else if ([str isEqualToString:@"1"]) {
        self.model.sex = @"F";
    }
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"sex"] = [str isEqualToString:@"1"] ? @"F" :@"M";
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiUserNickname withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"恭喜您,性别修改成功"];
            [self.tableView reloadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"性别修改失败"];
        }
        
    }];
    
}

- (void)finishEditBirthdayWithText:(NSString *)str {
    
    self.model.birthday = ISNIL(str);
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"birthday"] = self.model.birthday;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiUserNickname withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"恭喜您,生日修改成功"];
            [self.tableView reloadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"生日修改失败"];
        }
        
    }];
    
}

- (void)finishEditHeightWithText:(NSString *)str {
    
    self.model.stature = ISNIL(str);
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"stature"] = self.model.stature;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiUserNickname withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"恭喜您,身高修改成功"];
            [self.tableView reloadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"身高修改失败"];
        }
    }];
    
}

- (void)finishEditWeightWithText:(NSString *)str {
    
    self.model.weight = ISNIL(str);
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"weight"] = self.model.weight;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiUserNickname withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"恭喜您,体重修改成功"];
            [self.tableView reloadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"体重修改失败"];
        }
    }];
    
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
