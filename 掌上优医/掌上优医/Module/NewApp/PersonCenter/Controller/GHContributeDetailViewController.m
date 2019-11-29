//
//  GHContributeDetailViewController.m
//  掌上优医
//
//  Created by GH on 2019/6/6.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHContributeDetailViewController.h"

#import "GHSearchDoctorModel.h"
#import "GHSearchHospitalModel.h"
#import "GHInfoErrorProgressTableViewCell.h"

#import "GHDocterDetailViewController.h"

#import "GHHospitalDetailViewController.h"


@interface GHContributeDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) GHSearchDoctorModel *realDoctorModel;

@property (nonatomic, strong) GHSearchHospitalModel *realHospitalModel;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation GHContributeDetailViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.type == 1) {
        
        // 医生
        switch ([self.doctorModel.dataCollectionType integerValue]) {
            case 1:
                self.navigationItem.title = @"核实详情";
                break;
            case 2:
                self.navigationItem.title = @"补全详情";
                break;
            case 3:
                self.navigationItem.title = @"新增详情";
                break;

            default:
                break;
        }
        
        
    } else {
        
        // 医院
        switch ([self.hospitalModel.dataCollectionType integerValue]) {
            case 1:
                self.navigationItem.title = @"核实详情";
                break;
            case 2:
                self.navigationItem.title = @"补全详情";
                break;
            case 3:
                self.navigationItem.title = @"新增详情";
                break;
                
            default:
                break;
        }
        
    }
    
    
    if (self.type == 1) {
        
        if ([self.doctorModel.dataCollectionType integerValue] == 3) {
            [self setupUI];
            return;
        }
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"id"] = ISNIL(self.doctorModel.doctorId);
        
        [SVProgressHUD showWithStatus:kDefaultTipsText];
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDoctorDoctor withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            if (isSuccess) {
                
                self.realDoctorModel = [[GHSearchDoctorModel alloc] initWithDictionary:response error:nil];
                
                [self setupUI];
                
            }
            
        }];
        
    } else {
        
        if ([self.hospitalModel.dataCollectionType integerValue] == 3) {
            [self setupUI];
            return;
        }
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"id"] = self.hospitalModel.originHospitalId;
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
            
            if (isSuccess) {
                
                self.realHospitalModel = [[GHSearchHospitalModel alloc] initWithDictionary:response error:nil];
                
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
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 95);

    UIView *headerContentView = [[UIView alloc] init];
    [headerView addSubview:headerContentView];
    
    [headerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(85);
    }];
    
    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.font = H23;
    [headerContentView addSubview:statusLabel];
    
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.right.mas_equalTo(-23);
        make.top.bottom.mas_equalTo(0);
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [headerView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(85);
        make.height.mas_equalTo(10);
    }];
    
    if (self.type == 1) {
        
        switch ([self.doctorModel.status integerValue]) {
            case 0:
                headerContentView.backgroundColor = UIColorHex(0xFEAE05);
                statusLabel.text = @"审核中";
                break;
            case 1:
                headerContentView.backgroundColor = UIColorHex(0x21C17A);
                statusLabel.text = @"已采纳";
                break;
            case 2:
                headerContentView.backgroundColor = UIColorHex(0xFF6188);
                statusLabel.text = @"未采纳";
                break;
                
            default:
                break;
        }
        
        if ([self.doctorModel.dataCollectionType integerValue] == 1 || [self.doctorModel.dataCollectionType integerValue] == 2) {
            
            headerView.height += 180;
            
            UILabel *infoTitleLabel = [[UILabel alloc] init];
            infoTitleLabel.textColor = kDefaultBlackTextColor;
            infoTitleLabel.font = H16;
            infoTitleLabel.text = @"详细信息";
            [headerView addSubview:infoTitleLabel];
            
            [infoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(16);
                make.right.mas_equalTo(-16);
                make.height.mas_equalTo(45);
                make.top.mas_equalTo(95);
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
            
            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDoctorAction)];
            [contentView addGestureRecognizer:tapGR];
            
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
            
            [headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(self.realDoctorModel.profilePhoto)) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];

            nameLabel.text = ISNIL(self.realDoctorModel.doctorName);
            addressLabel.text = ISNIL(self.realDoctorModel.hospitalAddress);
            
            
        }
        
    } else if (self.type == 2) {
        
        switch ([self.hospitalModel.status integerValue]) {
            case 0:
                headerContentView.backgroundColor = UIColorHex(0xFEAE05);
                statusLabel.text = @"审核中";
                break;
            case 1:
                headerContentView.backgroundColor = UIColorHex(0x21C17A);
                statusLabel.text = @"已采纳";
                break;
            case 2:
                headerContentView.backgroundColor = UIColorHex(0xFF6188);
                statusLabel.text = @"未采纳";
                break;
                
            default:
                break;
        }
        
        if ([self.hospitalModel.dataCollectionType integerValue] == 1 || [self.hospitalModel.dataCollectionType integerValue] == 2) {
            
            headerView.height += 180;
            
            UILabel *infoTitleLabel = [[UILabel alloc] init];
            infoTitleLabel.textColor = kDefaultBlackTextColor;
            infoTitleLabel.font = H16;
            infoTitleLabel.text = @"详细信息";
            [headerView addSubview:infoTitleLabel];
            
            [infoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(16);
                make.right.mas_equalTo(-16);
                make.height.mas_equalTo(45);
                make.top.mas_equalTo(95);
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
            
            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHospitalAction)];
            [contentView addGestureRecognizer:tapGR];
            
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
            
            [headPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(self.realHospitalModel.profilePhoto)) placeholderImage:[UIImage imageNamed:@"hospital_placeholder"]];
            
            nameLabel.text = ISNIL(self.realHospitalModel.hospitalName);
            addressLabel.text = ISNIL(self.realHospitalModel.hospitalAddress);
            
            
        }
        
    }
    
    self.tableView.tableHeaderView = headerView;
    
}

- (void)clickDoctorAction {
    
    GHDocterDetailViewController *vc = [[GHDocterDetailViewController alloc] init];
    vc.doctorId = self.realDoctorModel.modelId;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)clickHospitalAction {
    
    GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] init];
    model.modelId = self.realHospitalModel.modelId;
    model.hospitalName = self.realHospitalModel.hospitalName;
    
    GHHospitalDetailViewController *vc = [[GHHospitalDetailViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)setupTableFooterView {
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = kDefaultGaryViewColor;
    footerView.frame = CGRectMake(0, 0, SCREENWIDTH, 45);

    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = H16;
    timeLabel.textColor = kDefaultGrayTextColor;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    
    
    if (self.type == 1) {
        timeLabel.text = [NSString stringWithFormat:@"提交时间: %@", ISNIL(self.doctorModel.gmtCreate)];
    } else {
        timeLabel.text = [NSString stringWithFormat:@"提交时间: %@", ISNIL(self.hospitalModel.gmtCreate)];
    }
    
    self.tableView.tableFooterView = footerView;
    
}

- (void)getDataAction {
    
    if (self.type == 1) {
        
        // 医生
//        if ([self.doctorModel.dataCollectionType integerValue] == 1) {
        
            if (self.doctorModel.profilePhoto.length) {
                
                if (![ISNIL(self.doctorModel.profilePhoto) isEqualToString:ISNIL(self.realDoctorModel.profilePhoto)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(1),
                                          @"urlArray" : ISNIL(self.doctorModel.profilePhoto),
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
            
            if (self.doctorModel.doctorGrade.length) {
                
                if (![ISNIL(self.doctorModel.doctorGrade) isEqualToString:ISNIL(self.realDoctorModel.doctorGrade)]) {
                    
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
            
            
            if (self.doctorModel.hospitalName.length) {
                
                if (![ISNIL(self.doctorModel.hospitalName) isEqualToString:ISNIL(self.realDoctorModel.hospitalName)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(2),
                                          @"origin" : ISNIL(self.doctorModel.hospitalName),
                                          @"now" : ISNIL(self.realDoctorModel.hospitalName),
                                          @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.hospitalName) withNewsValue:ISNIL(self.realDoctorModel.hospitalName)],
                                          @"title" : @"医院名称"
                                          };
                    
                    [self.dataArray addObject:dic];
                    
                }
                
            }
            
            if (self.doctorModel.hospital.length) {
                
                if (![ISNIL(self.doctorModel.hospital) isEqualToString:ISNIL(self.realDoctorModel.hospitalAddress)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(2),
                                          @"origin" : ISNIL(self.doctorModel.hospital),
                                          @"now" : ISNIL(self.realDoctorModel.hospitalAddress),
                                          @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.hospital) withNewsValue:ISNIL(self.realDoctorModel.hospitalAddress)],
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
            
            if (self.doctorModel.diagnosisTime.length) {
                
                if (![ISNIL(self.doctorModel.diagnosisTime) isEqualToString:ISNIL(self.realDoctorModel.diagnosisTime)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(2),
                                          @"origin" : ISNIL(self.doctorModel.diagnosisTime),
                                          @"now" : ISNIL(self.realDoctorModel.diagnosisTime),
                                          @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.diagnosisTime) withNewsValue:ISNIL(self.realDoctorModel.diagnosisTime)],
                                          @"title" : @"出诊时间"
                                          };
                    
                    [self.dataArray addObject:dic];
                    
                }
                
            }
            
            if (self.doctorModel.careerExperience.length) {
                
                if (![ISNIL(self.doctorModel.careerExperience) isEqualToString:ISNIL(self.realDoctorModel.specialize)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(2),
                                          @"origin" : ISNIL(self.doctorModel.careerExperience),
                                          @"now" : ISNIL(self.realDoctorModel.specialize),
                                          @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.careerExperience) withNewsValue:ISNIL(self.realDoctorModel.specialize)],
                                          @"title" : @"医生擅长"
                                          };
                    
                    [self.dataArray addObject:dic];
                    
                }
                
            }
            
            if (self.doctorModel.doctorInfo.length) {
                
                if (![ISNIL(self.doctorModel.doctorInfo) isEqualToString:ISNIL(self.realDoctorModel.doctorInfo)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(2),
                                          @"origin" : ISNIL(self.doctorModel.doctorInfo),
                                          @"now" : ISNIL(self.realDoctorModel.doctorInfo),
                                          @"height" : [self getHeightWithOriginValue:ISNIL(self.doctorModel.doctorInfo) withNewsValue:ISNIL(self.realDoctorModel.doctorInfo)],
                                          @"title" : @"职业经历"
                                          };
                    
                    [self.dataArray addObject:dic];
                    
                }
                
//            }
            
        }
        
    } else {
        
//        if ([self.hospitalModel.dataCollectionType integerValue] == 1) {
        
            
            if (self.hospitalModel.profilePhoto.length) {
                
                if (![ISNIL(self.hospitalModel.profilePhoto) isEqualToString:ISNIL(self.realHospitalModel.profilePhoto)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(1),
                                          @"urlArray" : ISNIL(self.hospitalModel.profilePhoto),
                                          @"height" : @(100),
                                          @"title" : @"医院封面"
                                          };
                    
                    [self.dataArray addObject:dic];
                    
                }
                
            }
            
            if (self.hospitalModel.pictures.length) {
                
                if (![ISNIL(self.hospitalModel.pictures) isEqualToString:ISNIL(self.realHospitalModel.pictures)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(3),
                                          @"urlArray" : [self.hospitalModel.pictures jsonValueDecoded],
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
            
            if (self.hospitalModel.grade.length) {
                
                if (![ISNIL(self.hospitalModel.grade) isEqualToString:ISNIL(self.realHospitalModel.hospitalGrade)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(2),
                                          @"origin" : ISNIL(self.hospitalModel.grade),
                                          @"now" : ISNIL(self.realHospitalModel.hospitalGrade),
                                          @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.grade) withNewsValue:ISNIL(self.realHospitalModel.hospitalGrade)],
                                          @"title" : @"医院等级"
                                          };
                    
                    [self.dataArray addObject:dic];
                    
                }
                
            }
            
            if (self.hospitalModel.category.length) {
                
                if (![ISNIL(self.hospitalModel.category) isEqualToString:ISNIL(self.realHospitalModel.category)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(2),
                                          @"origin" : ISNIL(self.hospitalModel.category),
                                          @"now" : ISNIL(self.realHospitalModel.category),
                                          @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.category) withNewsValue:ISNIL(self.realHospitalModel.category)],
                                          @"title" : @"医院类型"
                                          };
                    
                    [self.dataArray addObject:dic];
                    
                }
                
            }
            
            if (self.hospitalModel.medicalInsuranceFlag.length) {
                
                if (![ISNIL(self.hospitalModel.medicalInsuranceFlag) isEqualToString:ISNIL(self.realHospitalModel.medicalInsuranceFlag)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(2),
                                          @"origin" : [self.hospitalModel.medicalInsuranceFlag integerValue] == 0 ? @"无医保" : @"有医保",
                                          @"now" : [self.realHospitalModel.medicalInsuranceFlag integerValue] == 0 ? @"无医保" : @"有医保",
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
                                          @"origin" : [self.hospitalModel.governmentalHospitalFlag integerValue] == 0 ? @"私立医院" : @"公立医院",
                                          @"now" : [self.realHospitalModel.governmentalHospitalFlag integerValue] == 0 ? @"私立医院" : @"公立医院",
                                          @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.governmentalHospitalFlag) withNewsValue:ISNIL(self.realHospitalModel.governmentalHospitalFlag)],
                                          @"title" : @"医院属性"
                                          };
                    
                    [self.dataArray addObject:dic];
                    
                }
                
            }
        
        if (self.hospitalModel.medicineType.length) {
            
            if (![ISNIL(self.hospitalModel.medicineType) isEqualToString:ISNIL(self.realHospitalModel.medicineType)]) {
                
                NSDictionary *dic = @{
                                      @"type" : @(2),
                                      @"origin" : ISNIL(self.hospitalModel.medicineType),
                                      @"now" : ISNIL(self.realHospitalModel.medicineType),
                                      @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.medicineType) withNewsValue:ISNIL(self.realHospitalModel.medicineType)],
                                      @"title" : @"医院标签"
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
            
            if (self.hospitalModel.outpatientDepartmentTime.length) {
                
                if (![ISNIL(self.hospitalModel.outpatientDepartmentTime) isEqualToString:ISNIL(self.realHospitalModel.outpatientDepartmentTime)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(2),
                                          @"origin" : ISNIL(self.hospitalModel.outpatientDepartmentTime),
                                          @"now" : ISNIL(self.realHospitalModel.outpatientDepartmentTime),
                                          @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.outpatientDepartmentTime) withNewsValue:ISNIL(self.realHospitalModel.outpatientDepartmentTime)],
                                          @"title" : [self.realHospitalModel.categoryByScale isEqualToString:@"综合医院"] ? @"门诊时间" : @"营业时间"
                                          };
                    
                    [self.dataArray addObject:dic];
                    
                }
                
            }
            
            if (self.hospitalModel.emergencyTreatmentTime.length) {
                
                if (![ISNIL(self.hospitalModel.emergencyTreatmentTime) isEqualToString:ISNIL(self.realHospitalModel.emergencyTreatmentTime)]) {
                    
                    NSDictionary *dic = @{
                                          @"type" : @(2),
                                          @"origin" : ISNIL(self.hospitalModel.emergencyTreatmentTime),
                                          @"now" : ISNIL(self.realHospitalModel.emergencyTreatmentTime),
                                          @"height" : [self getHeightWithOriginValue:ISNIL(self.hospitalModel.emergencyTreatmentTime) withNewsValue:ISNIL(self.realHospitalModel.emergencyTreatmentTime)],
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
            
//        }
        
        
    }
    
    [self.tableView reloadData];
    
}

- (NSNumber *)getHeightWithOriginValue:(NSString *)originValue withNewsValue:(NSString *)newsValue {
    
    CGFloat originHeight = [ISNIL(originValue) heightForFont:H16 width:SCREENWIDTH - 116];
    
    CGFloat newsHeight = [ISNIL(newsValue) heightForFont:H16 width:SCREENWIDTH - 116];
    
    if (self.type == 1) {
        
        if ([self.doctorModel.dataCollectionType integerValue] == 1) {
            return [NSNumber numberWithFloat:(88 + originHeight + newsHeight)];
        } else if ([self.doctorModel.dataCollectionType integerValue] == 2) {
            return [NSNumber numberWithFloat:(66 + originHeight)];
        } else if ([self.doctorModel.dataCollectionType integerValue] == 3) {
            return [NSNumber numberWithFloat:(66 + originHeight)];
        }
        
    } else if (self.type == 2) {
        
        if ([self.hospitalModel.dataCollectionType integerValue] == 1) {
            return [NSNumber numberWithFloat:(88 + originHeight + newsHeight)];
        } else if ([self.hospitalModel.dataCollectionType integerValue] == 2) {
            return [NSNumber numberWithFloat:(66 + originHeight)];
        } else if ([self.hospitalModel.dataCollectionType integerValue] == 3) {
            return [NSNumber numberWithFloat:(66 + originHeight)];
        }
        
    }
    
    return 0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return [dic[@"height"] floatValue];
    
    
    
    if (self.type == 1) {
        
        if ([self.doctorModel.dataCollectionType integerValue] == 1) {
            
        } else if ([self.doctorModel.dataCollectionType integerValue] == 2) {
            
        } else if ([self.doctorModel.dataCollectionType integerValue] == 3) {
            
        }
        
    } else if (self.type == 2) {
        
        if ([self.hospitalModel.dataCollectionType integerValue] == 1) {
            
        } else if ([self.hospitalModel.dataCollectionType integerValue] == 2) {
            
        } else if ([self.hospitalModel.dataCollectionType integerValue] == 3) {
            
        }
        
    }
    
    return 0;
    
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
            
            NSDictionary *dicInfo = [((NSArray *)dic[@"urlArray"]) objectOrNilAtIndex:index];
            
            NSString *imageUrl = dicInfo[@"url"];
            
            if (imageUrl.length) {
                
                [imageView sd_setImageWithURL:kGetImageURLWithString(imageUrl)];
                
                imageView.hidden = false;
                
            } else {
                
                imageView.hidden = true;
                
            }
            
        }
        
    }
    
    if (self.type == 1) {
        
        if ([self.doctorModel.dataCollectionType integerValue] == 2) {
            cell.thirdTitleLabel.hidden = true;
            cell.thirdValueLabel.hidden = true;
            cell.firstTitleLabel.text = @"补全内容";
            cell.secondValueLabel.text = ((NSString *)dic[@"origin"]).length ? dic[@"origin"] : @" ";
            cell.secondTitleLabel.text = @"补全信息";
        } else if ([self.doctorModel.dataCollectionType integerValue] == 3) {
            cell.thirdTitleLabel.hidden = true;
            cell.thirdValueLabel.hidden = true;
            cell.firstTitleLabel.text = @"新增内容";
            cell.secondValueLabel.text = ((NSString *)dic[@"origin"]).length ? dic[@"origin"] : @" ";
            cell.secondTitleLabel.text = @"新增信息";
        }
        
    } else if (self.type == 2) {
        
        if ([self.hospitalModel.dataCollectionType integerValue] == 2) {
            cell.thirdTitleLabel.hidden = true;
            cell.thirdValueLabel.hidden = true;
            cell.firstTitleLabel.text = @"补全内容";
            cell.secondValueLabel.text = ((NSString *)dic[@"origin"]).length ? dic[@"origin"] : @" ";
            cell.secondTitleLabel.text = @"补全信息";
        } else if ([self.hospitalModel.dataCollectionType integerValue] == 3) {
            cell.thirdTitleLabel.hidden = true;
            cell.thirdValueLabel.hidden = true;
            cell.firstTitleLabel.text = @"新增内容";
            cell.secondValueLabel.text = ((NSString *)dic[@"origin"]).length ? dic[@"origin"] : @" ";
            cell.secondTitleLabel.text = @"新增信息";
        }
        
    }
    
    return cell;
    
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
