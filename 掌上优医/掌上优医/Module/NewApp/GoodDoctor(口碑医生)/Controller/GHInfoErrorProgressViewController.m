//
//  GHInfoErrorProgressViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHInfoErrorProgressViewController.h"
#import "GHSearchDoctorModel.h"
#import "GHSearchHospitalModel.h"
#import "GHInfoErrorProgressTableViewCell.h"

@interface GHInfoErrorProgressViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) GHSearchDoctorModel *realDoctorModel;

@property (nonatomic, strong) GHSearchHospitalModel *realHospitalModel;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation GHInfoErrorProgressViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"核实详情";
    
    if (self.type == 1) {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"doctorId"] = ISNIL(self.doctorModel.doctorId);
        
        [SVProgressHUD showWithStatus:kDefaultTipsText];
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDetailDocotr withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            if (isSuccess) {
                
                self.realDoctorModel = [[GHSearchDoctorModel alloc] initWithDictionary:response[@"data"][@"doctor"] error:nil];
                self.realDoctorModel.hospitalAddress = response[@"data"][@"hospitalAddress"];
                self.realDoctorModel.hospitalId = response[@"data"][@"hospitalId"];
                self.realDoctorModel.hospitalName = response[@"data"][@"hospitalName"];
                self.realDoctorModel.secondDepartmentName = [(NSArray *) response[@"data"][@"hospitalDepartment"] count] >0 ? [(NSArray *) response[@"data"][@"hospitalDepartment"]firstObject] : @"";
                [self setupUI];
                
            }
            
        }];
        
    } else {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"hospitalId"] = self.hospitalModel.originHospitalId;
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
            
            if (isSuccess) {
                
                self.realHospitalModel = [[GHSearchHospitalModel alloc] initWithDictionary:response[@"data"][@"hospital"] error:nil];
                
                [self setupUI];
                
            }
            
        }];
        
    }
    
    
    
}


- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.tableView = tableView;
    
    [self setupTableHeaderView];
    
    [self setupTableFooterView];
    
    [self getDataAction];
    
}

- (void)setupTableHeaderView {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 397);
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.contentMode = UIViewContentModeScaleToFill;
    bgImageView.image = [UIImage imageNamed:@"bng_heshixiangqing_heshizhong"];
    [headerView addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(76);
    }];
    
    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.font = [UIFont boldSystemFontOfSize:23];
    statusLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:statusLabel];
    
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
        make.right.mas_equalTo(-26);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(13);
    }];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.font = H14;
    [headerView addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(statusLabel);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(statusLabel.mas_bottom).offset(7);
    }];
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.textColor = kDefaultBlackTextColor;
    tipsLabel.font = H17;
    tipsLabel.numberOfLines = 0;
    [headerView addSubview:tipsLabel];
    
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(93);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = kDefaultGrayTextColor;
    timeLabel.font = H16;
    [headerView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(tipsLabel);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(tipsLabel.mas_bottom).offset(8);
    }];
    
//    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancelButton.titleLabel.font = H18;
//    [cancelButton setTitleColor:kDefaultGrayTextColor forState:UIControlStateNormal];
//    [cancelButton setTitle:@"撤销" forState:UIControlStateNormal];
//    cancelButton.layer.cornerRadius = 4;
//    cancelButton.layer.borderColor = kDefaultGrayTextColor.CGColor;
//    cancelButton.layer.borderWidth = .5;
//    [headerView addSubview:cancelButton];
//
//    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-18);
//        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(74);
//        make.top.mas_equalTo(168);
//    }];
//    [cancelButton addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [headerView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(216);
    }];
    
    UILabel *infoTitleLabel = [[UILabel alloc] init];
    infoTitleLabel.textColor = kDefaultBlackTextColor;
    infoTitleLabel.font = H16;
    infoTitleLabel.text = @"详细信息";
    [headerView addSubview:infoTitleLabel];
    
    [infoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(lineLabel.mas_bottom);
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 4;
    contentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,2);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 4;
    [headerView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(122);
        make.top.mas_equalTo(infoTitleLabel.mas_bottom);
    }];
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 2;
    headPortraitImageView.layer.masksToBounds = true;
    [contentView addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
        make.left.mas_equalTo(12);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = HM15;
    [contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(headPortraitImageView.mas_top);
    }];
    
   
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.textColor = kDefaultBlackTextColor;
    addressLabel.font = H12;
    addressLabel.numberOfLines = 0;
    [contentView addSubview:addressLabel];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(16);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(15);
        make.right.mas_equalTo(-16);
    }];
    
    self.tableView.tableHeaderView = headerView;
 
    if (self.type == 1) {
        
        [headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(self.realDoctorModel.profilePhoto)) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
        
        timeLabel.text = ISNIL(self.doctorModel.gmtModified);
        
        nameLabel.text = ISNIL(self.realDoctorModel.doctorName);
        addressLabel.text = ISNIL(self.realDoctorModel.hospitalAddress);
        
        if ([self.doctorModel.status integerValue] == 1) {
            
            statusLabel.text = @"信息审核中...";
            descLabel.text = @"请耐心等待";
            tipsLabel.text = @"我们已经收到你的反馈，核实结果将在10个工作日内通知您，请注意查收";
            
//            cancelButton.hidden = false;
            
        }
               else if ([self.hospitalModel.status integerValue] == 2)
                {
                    statusLabel.text = @"信息审核成功";
        //            descLabel.text = @"请耐心等待";
                    tipsLabel.text = @"我们已经收到你的反馈，感谢您的支持！";
                }
                else
                {
                    statusLabel.text = @"信息审核失败";
        //            descLabel.text = @"请耐心等待";
                    tipsLabel.text = @"我们已经收到你的反馈，感谢您的支持！";
                }
        
    } else {
        
        [headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(self.realHospitalModel.profilePhoto)) placeholderImage:[UIImage imageNamed:@"hospital_placeholder"]];
        
        timeLabel.text = ISNIL(self.hospitalModel.gmtModified);
        
        nameLabel.text = ISNIL(self.realHospitalModel.hospitalName);
        addressLabel.text = ISNIL(self.realHospitalModel.hospitalAddress);
        
        if ([self.hospitalModel.status integerValue] == 1) {//1:未处理 2:审核成功 3:审核失败
            
            statusLabel.text = @"信息审核中...";
            descLabel.text = @"请耐心等待";
            tipsLabel.text = @"我们已经收到你的反馈，核实结果将在10个工作日内通知您，请注意查收";
            
//            cancelButton.hidden = false;
            
        }
        else if ([self.hospitalModel.status integerValue] == 2)
        {
            statusLabel.text = @"信息审核成功";
//            descLabel.text = @"请耐心等待";
            tipsLabel.text = @"我们已经收到你的反馈，感谢您的支持！";
        }
        else
        {
            statusLabel.text = @"信息审核失败";
//            descLabel.text = @"请耐心等待";
            tipsLabel.text = @"我们已经收到你的反馈，感谢您的支持！";
        }
        
    }
    
    
}

- (void)clickCancelAction {
    
    NSLog(@"撤销报错");
    
}

- (void)setupTableFooterView {
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = kDefaultGaryViewColor;
    footerView.frame = CGRectMake(0, 0, SCREENWIDTH, 200);
    
    UIView *footerContentView = [[UIView alloc] init];
    footerContentView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:footerContentView];
    
    [footerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(145);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = H16;
    timeLabel.textColor = kDefaultGrayTextColor;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(footerContentView.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H16;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.text = @"核实过程";
    [footerContentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
        make.height.mas_equalTo(53);
        make.top.mas_equalTo(0);
    }];
    
    NSArray *titleArray = @[@"核实完成", @"核实中", @"提交报错"];
    
    NSArray *topArray = @[@(50), @(80), @(110)];
    
    // 0 未开始 1 进行中 2 已完成
    NSArray *statusArray = @[@(0), @(1), @(2)];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [footerContentView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(55);
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(24.5);
        make.width.mas_equalTo(1);
    }];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        UILabel *statusLabel = [[UILabel alloc] init];
        statusLabel.font = H13;
        statusLabel.text = [titleArray objectOrNilAtIndex:index];
        [footerContentView addSubview:statusLabel];
        
        [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(36);
            make.top.mas_equalTo([[topArray objectOrNilAtIndex:index] floatValue]);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(13);
        }];
        
        UILabel *bigLabel = [[UILabel alloc] init];
        bigLabel.layer.cornerRadius = 6;
        bigLabel.layer.masksToBounds = true;
        [footerContentView addSubview:bigLabel];
        
        [bigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(12);
            make.centerY.mas_equalTo(statusLabel);
            make.left.mas_equalTo(19);
        }];
        
        UILabel *litterLabel = [[UILabel alloc] init];
        litterLabel.layer.cornerRadius = 3;
        litterLabel.layer.masksToBounds = true;
        litterLabel.backgroundColor = [UIColor whiteColor];
        [footerContentView addSubview:litterLabel];
        
        [litterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(6);
            make.centerY.centerX.mas_equalTo(bigLabel);
        }];
        
        NSInteger statu = [[statusArray objectOrNilAtIndex:index] integerValue];
        
        if (statu == 0) {
            
            bigLabel.backgroundColor = UIColorHex(0xCCCCCC);
            statusLabel.textColor = UIColorHex(0x999999);
            
        } else if (statu == 1) {
            
            bigLabel.backgroundColor = kDefaultBlueColor;
            statusLabel.textColor = UIColorHex(0x333333);
            
        } else if (statu == 2) {
            
            bigLabel.backgroundColor = UIColorHex(0xB8BBFF);
            statusLabel.textColor = UIColorHex(0xCCCCCC);
            
        }
        
    }
    
    
    if (self.type == 1) {
        timeLabel.text = [NSString stringWithFormat:@"提交时间: %@", ISNIL(self.doctorModel.createTime)];
    } else {
        timeLabel.text = [NSString stringWithFormat:@"提交时间: %@", ISNIL(self.hospitalModel.createTime)];
    }
    
    self.tableView.tableFooterView = footerView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return [dic[@"height"] floatValue];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHInfoErrorProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHInfoErrorProgressTableViewCell"];
    
    if (!cell) {
        cell = [[GHInfoErrorProgressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHInfoErrorProgressTableViewCell"];
    }
    
    NSDictionary *dic = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    if ([dic[@"type"] integerValue] == 2) {
        
        cell.firstValueLabel.text = ((NSString *)dic[@"title"]).length ? dic[@"title"] : @" ";
        
        cell.thirdValueLabel.text = ((NSString *)dic[@"origin"]).length ? dic[@"origin"] : @" ";

        cell.secondValueLabel.text = ((NSString *)dic[@"now"]).length ? dic[@"now"] : @" ";

        cell.thirdValueLabel.hidden = false;
        cell.secondValueLabel.hidden = false;
        
        cell.thirdTitleLabel.hidden = false;
        cell.secondTitleLabel.hidden = false;
        
        for (NSInteger index = 0; index < cell.imageViewArray.count; index++) {
            
            UIImageView *imageView = [cell.imageViewArray objectOrNilAtIndex:index];
            
            imageView.hidden = true;
            
        }
        
    } else if ([dic[@"type"] integerValue] == 1) {
        
        cell.firstValueLabel.text = ((NSString *)dic[@"title"]).length ? dic[@"title"] : @" ";
        
        cell.thirdValueLabel.hidden = true;
        cell.secondValueLabel.hidden = true;
        
        cell.thirdTitleLabel.hidden = true;
        cell.secondTitleLabel.hidden = true;
        
        for (NSInteger index = 0; index < cell.imageViewArray.count; index++) {
            
            UIImageView *imageView = [cell.imageViewArray objectOrNilAtIndex:index];
            
            if (index == 0) {
                
                [imageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(dic[@"urlArray"]))];
                
                imageView.hidden = false;
                
            } else {
                
                imageView.hidden = true;
                
            }
            
        }
        
    } else if ([dic[@"type"] integerValue] == 3) {
        
        cell.firstValueLabel.text = ((NSString *)dic[@"title"]).length ? dic[@"title"] : @" ";
        
        cell.thirdValueLabel.hidden = true;
        cell.secondValueLabel.hidden = true;
        
        cell.thirdTitleLabel.hidden = true;
        cell.secondTitleLabel.hidden = true;
        
        for (NSInteger index = 0; index < cell.imageViewArray.count; index++) {
            
            UIImageView *imageView = [cell.imageViewArray objectOrNilAtIndex:index];
            
            NSString *imageUrl = [(NSArray *)dic[@"urlArray"] objectOrNilAtIndex:index];
            
//            NSDictionary *dicInfo = [((NSArray *)dic[@"urlArray"]) objectOrNilAtIndex:index];
            
//            NSString *imageUrl = dicInfo[@"url"];
//
            if (imageUrl.length) {

                [imageView sd_setImageWithURL:kGetImageURLWithString(imageUrl)];

                imageView.hidden = false;

            } else {

                imageView.hidden = true;

            }
            
        }
        
    }
    
    return cell;
    
}

// type 1 图片 2 文字 3 图片数组
- (void)getDataAction {
    
    if (self.type == 1) {
        
        if (self.doctorModel.imageUrl.length) {
            
            if (![ISNIL(self.doctorModel.imageUrl) isEqualToString:ISNIL(self.realDoctorModel.profilePhoto)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(1),
                                      @"urlArray" : ISNIL(self.doctorModel.imageUrl),
                                      @"height" : @(100),
                                      @"title" : @"医生图片"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.doctorModel.doctorName.length) {
            
            if (![ISNIL(self.doctorModel.doctorName) isEqualToString:ISNIL(self.realDoctorModel.doctorName)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.doctorModel.doctorName),
                                      @"now" : ISNIL(self.realDoctorModel.doctorName),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.doctorName) withNewsValue:ISNIL(self.realDoctorModel.doctorName)],
                                      @"title" : @"医生姓名"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.doctorModel.doctorGradeNum.length) {
            
            if (![ISNIL(self.doctorModel.doctorGradeNum) isEqualToString:ISNIL(self.realDoctorModel.doctorGrade)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.doctorModel.doctorGrade),
                                      @"now" : ISNIL(self.realDoctorModel.doctorGrade),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.doctorGrade) withNewsValue:ISNIL(self.realDoctorModel.doctorGrade)],
                                      @"title" : @"医生职称"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.doctorModel.medicineType.length) {
            
            if (![ISNIL(self.doctorModel.medicineType) isEqualToString:ISNIL(self.realDoctorModel.medicineType)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.doctorModel.medicineType),
                                      @"now" : ISNIL(self.realDoctorModel.medicineType),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.medicineType) withNewsValue:ISNIL(self.realDoctorModel.medicineType)],
                                      @"title" : @"医生类型"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        
        if (self.doctorModel.hospital.length) {
            
            if (![ISNIL(self.doctorModel.hospital) isEqualToString:ISNIL(self.realDoctorModel.hospitalName)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.doctorModel.hospital),
                                      @"now" : ISNIL(self.realDoctorModel.hospitalName),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.hospital) withNewsValue:ISNIL(self.realDoctorModel.hospitalName)],
                                      @"title" : @"医院名称"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.doctorModel.address.length) {
            
            if (![ISNIL(self.doctorModel.address) isEqualToString:ISNIL(self.realDoctorModel.hospitalAddress)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.doctorModel.address),
                                      @"now" : ISNIL(self.realDoctorModel.hospitalAddress),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.address) withNewsValue:ISNIL(self.realDoctorModel.hospitalAddress)],
                                      @"title" : @"医生地址"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.doctorModel.secondDepartmentName.length) {
            
            if (![ISNIL(self.doctorModel.secondDepartmentName) isEqualToString:ISNIL(self.realDoctorModel.secondDepartmentName)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.doctorModel.secondDepartmentName),
                                      @"now" : ISNIL(self.realDoctorModel.secondDepartmentName),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.secondDepartmentName) withNewsValue:ISNIL(self.realDoctorModel.secondDepartmentName)],
                                      @"title" : @"出诊科室"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.doctorModel.visitTime.length) {
            
            if (![ISNIL(self.doctorModel.visitTime) isEqualToString:ISNIL(self.realDoctorModel.diagnosisTime)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.doctorModel.visitTime),
                                      @"now" : ISNIL(self.realDoctorModel.diagnosisTime),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.visitTime) withNewsValue:ISNIL(self.realDoctorModel.diagnosisTime)],
                                      @"title" : @"出诊时间"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.doctorModel.goodAt.length) {
            
            if (![ISNIL(self.doctorModel.goodAt) isEqualToString:ISNIL(self.realDoctorModel.specialize)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.doctorModel.goodAt),
                                      @"now" : ISNIL(self.realDoctorModel.specialize),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.goodAt) withNewsValue:ISNIL(self.realDoctorModel.specialize)],
                                      @"title" : @"医生擅长"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.doctorModel.careerExperience.length) {
            
            if (![ISNIL(self.doctorModel.careerExperience) isEqualToString:ISNIL(self.realDoctorModel.doctorInfo)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.doctorModel.careerExperience),
                                      @"now" : ISNIL(self.realDoctorModel.doctorInfo),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.careerExperience) withNewsValue:ISNIL(self.realDoctorModel.doctorInfo)],
                                      @"title" : @"职业经历"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
    } else {
        
        if (self.hospitalModel.doorPhotoUrl.length) {
            
            if (![ISNIL(self.hospitalModel.profilePhoto) isEqualToString:ISNIL(self.realHospitalModel.profilePhoto)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(1),
                                      @"urlArray" : ISNIL(self.hospitalModel.doorPhotoUrl),
                                      @"height" : @(100),
                                      @"title" : @"医院封面"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
 
        }
        //医院封面图
        if (self.hospitalModel.surroundingsUrl.length) {
         
            if (![ISNIL(self.hospitalModel.surroundingsUrl) isEqualToString:ISNIL(self.realHospitalModel.pictures)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(3),
                                      @"urlArray" : [self.hospitalModel.surroundingsUrl componentsSeparatedByString:@""],//[self.hospitalModel.surroundingsUrl jsonValueDecoded],
                                      @"height" : @(100),
                                      @"title" : @"医院环境"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.hospitalModel.hospitalName.length) {
            
            if (![ISNIL(self.hospitalModel.hospitalName) isEqualToString:ISNIL(self.realHospitalModel.hospitalName)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.hospitalModel.hospitalName),
                                      @"now" : ISNIL(self.realHospitalModel.hospitalName),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.hospitalName) withNewsValue:ISNIL(self.realHospitalModel.hospitalName)],
                                      @"title" : @"医院名称"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.hospitalModel.hospitalGrade.length) {
            
            if (![ISNIL(self.hospitalModel.hospitalGrade) isEqualToString:ISNIL(self.realHospitalModel.hospitalGrade)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.hospitalModel.hospitalGrade),
                                      @"now" : ISNIL(self.realHospitalModel.hospitalGrade),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.hospitalGrade) withNewsValue:ISNIL(self.realHospitalModel.hospitalGrade)],
                                      @"title" : @"医院等级"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.hospitalModel.medicineType.length) {
            
            if (![ISNIL(self.hospitalModel.medicineType) isEqualToString:ISNIL(self.realHospitalModel.category)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.hospitalModel.medicineType),
                                      @"now" : ISNIL(self.realHospitalModel.category),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.medicineType) withNewsValue:ISNIL(self.realHospitalModel.category)],
                                      @"title" : @"医院类型"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.hospitalModel.medicalInsuranceFlag.length) {
            
            if (![ISNIL(self.hospitalModel.medicalInsuranceFlag) isEqualToString:ISNIL(self.realHospitalModel.medicalInsuranceFlag)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : [self.hospitalModel.medicalInsuranceFlag integerValue] == 1 ? @"有医保":@"无医保",
                                      @"now" : [self.realHospitalModel.medicalInsuranceFlag integerValue] == 1 ? @"有医保" : @"无医保",
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.medicalInsuranceFlag) withNewsValue:ISNIL(self.realHospitalModel.medicalInsuranceFlag)],
                                      @"title" : @"医保情况"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.hospitalModel.governmentalHospitalFlag.length) {
            
            if (![ISNIL(self.hospitalModel.governmentalHospitalFlag) isEqualToString:ISNIL(self.realHospitalModel.governmentalHospitalFlag)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : [self.hospitalModel.governmentalHospitalFlag integerValue] == 1 ? @"私立医院" : @"公立医院",
                                      @"now" : [self.realHospitalModel.governmentalHospitalFlag integerValue] == 1 ? @"私立医院" : @"公立医院",
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.governmentalHospitalFlag) withNewsValue:ISNIL(self.realHospitalModel.governmentalHospitalFlag)],
                                      @"title" : @"医院属性"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        
        if (self.hospitalModel.contactNumber.length) {
            
            if (![ISNIL(self.hospitalModel.contactNumber) isEqualToString:ISNIL(self.realHospitalModel.contactNumber)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.hospitalModel.contactNumber),
                                      @"now" : ISNIL(self.realHospitalModel.contactNumber),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.contactNumber) withNewsValue:ISNIL(self.realHospitalModel.contactNumber)],
                                      @"title" : @"医院电话"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.hospitalModel.outpatientTime.length) {
            
            if (![ISNIL(self.hospitalModel.outpatientTime) isEqualToString:ISNIL(self.realHospitalModel.outpatientDepartmentTime)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.hospitalModel.outpatientTime),
                                      @"now" : ISNIL(self.realHospitalModel.outpatientDepartmentTime),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.outpatientTime) withNewsValue:ISNIL(self.realHospitalModel.outpatientDepartmentTime)],
                                      @"title" : [self.realHospitalModel.categoryByScale isEqualToString:@"综合医院"] ? @"门诊时间" : @"营业时间"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.hospitalModel.emergencyTime.length) {
            
            if (![ISNIL(self.hospitalModel.emergencyTime) isEqualToString:ISNIL(self.realHospitalModel.emergencyTreatmentTime)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.hospitalModel.emergencyTime),
                                      @"now" : ISNIL(self.realHospitalModel.emergencyTreatmentTime),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.emergencyTime) withNewsValue:ISNIL(self.realHospitalModel.emergencyTreatmentTime)],
                                      @"title" : @"急诊时间"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.hospitalModel.hospitalAddress.length) {
            
            if (![ISNIL(self.hospitalModel.hospitalAddress) isEqualToString:ISNIL(self.realHospitalModel.hospitalAddress)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.hospitalModel.hospitalAddress),
                                      @"now" : ISNIL(self.realHospitalModel.hospitalAddress),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.hospitalAddress) withNewsValue:ISNIL(self.realHospitalModel.hospitalAddress)],
                                      @"title" : @"医院地址"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.hospitalModel.introduction.length) {
            
            if (![ISNIL(self.hospitalModel.introduction) isEqualToString:ISNIL(self.realHospitalModel.introduction)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.hospitalModel.introduction),
                                      @"now" : ISNIL(self.realHospitalModel.introduction),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.introduction) withNewsValue:ISNIL(self.realHospitalModel.introduction)],
                                      @"title" : @"医院介绍"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }
        
        if (self.hospitalModel.hospitalFacility.length) {
            
            if (![ISNIL(self.hospitalModel.hospitalFacility) isEqualToString:ISNIL(self.realHospitalModel.hospitalFacility)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.hospitalModel.hospitalFacility),
                                      @"now" : ISNIL(self.realHospitalModel.hospitalFacility),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.hospitalFacility) withNewsValue:ISNIL(self.realHospitalModel.hospitalFacility)],
                                      @"title" : @"医院设施"
                                      };
                
                [self.dataArray addObject:dic];
                
            }
            
        }


        
    }
    
    
    [self.tableView reloadData];
    
}

- (NSNumber *)getHeightWithOriginValue:(NSString *)originValue withNewsValue:(NSString *)newsValue {
    
    CGFloat originHeight = [ISNIL(originValue) heightForFont:H16 width:SCREENWIDTH - 116];
    
    CGFloat newsHeight = [ISNIL(newsValue) heightForFont:H16 width:SCREENWIDTH - 116];
    
    return [NSNumber numberWithFloat:(88 + originHeight + newsHeight)];
    
}

@end
