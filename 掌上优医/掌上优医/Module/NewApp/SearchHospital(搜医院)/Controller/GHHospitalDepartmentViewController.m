//
//  GHHospitalDepartmentViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalDepartmentViewController.h"

#import "GHDepartmentModel.h"

#import "GHGoodDoctorDepartmentTableViewCell.h"

#import "GHHospitalDepartmentChildrenTableViewCell.h"

@interface GHHospitalDepartmentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *departmentArray;
@property (nonatomic, strong) UITableView *departmentTableView;

@end

@implementation GHHospitalDepartmentViewController

- (NSMutableArray *)departmentArray {
    
    if (!_departmentArray) {
        _departmentArray = [[NSMutableArray alloc] init];
    }
    return _departmentArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"全部科室";
    
    [self setupUI];
    
    [self getDataAction];
}


/**
 领导要求
 医院科室列表中的 parentId 以及 iconUrl 必须去 全部科室接口 去进行获取, 医院科室接口不应该有这些信息, 就是不肯返回, 所以只能请求两个接口进行遍历循环
 */
- (void)getDataAction {
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSystemparamDepartments withParameter:@{@"hospitalId":self.hospitalId} withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            for (NSDictionary *info in response[@"data"][@"departmentList"]) {
                
                GHNewDepartMentModel *model = [[GHNewDepartMentModel alloc]initWithDictionary:(NSDictionary *)info[@"firstDepartment"] error:nil];
                
                NSArray *secondDepartmentList = info[@"secondDepartmentList"];
                
                for (NSInteger index = 0; index < secondDepartmentList.count; index ++) {
                    
                    NSDictionary *secondDic = [secondDepartmentList objectAtIndex:index];
                    
                    GHNewDepartMentModel *second = [[GHNewDepartMentModel alloc]initWithDictionary:secondDic error:nil];
                    [model.secondDepartmentList addObject:second];
                }
                
                [self.departmentArray addObject:model];
                
            }
            
            [self.departmentTableView reloadData];
//            
//            NSMutableDictionary *sonParams = [[NSMutableDictionary alloc] init];
//            sonParams[@"hospitalId"] = self.hospitalId;
//            
//            [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHospitalDepartments withParameter:sonParams withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
//
//                if (isSuccess) {
//
//                    [SVProgressHUD dismiss];
//
//                    NSMutableArray *firstDepartmentArray = [[NSMutableArray alloc] init];
//
//                    NSInteger firstDepartmentTag = 0;
//
//                    for (NSDictionary *info in response) {
//
//                        GHDepartmentModel *model = [[GHDepartmentModel alloc] initWithDictionary:info error:nil];
//
//                        if ([model.departmentLevel integerValue] == 1) {
//
//                            for (GHDepartmentModel *infoModel in firstDepartmentInfoArray) {
//
//                                if ([infoModel.modelId longValue] == [model.departmentId longValue]) {
//
//                                    model.departmentsIconUrl = infoModel.departmentsIconUrl;
//
//                                    break;
//
//                                }
//
//                            }
//
//                            [firstDepartmentArray addObject:model];
//
//                        } else if ([model.departmentLevel integerValue] == 2) {
//
//                            for (GHDepartmentModel *infoModel in secondDepartmentInfoArray) {
//
//                                if ([infoModel.modelId longValue] == [model.departmentId longValue]) {
//
//                                    model.parentId = infoModel.parentId;
//
//                                    break;
//
//                                }
//
//                            }
//
//                            GHDepartmentModel *firstModel = [firstDepartmentArray objectOrNilAtIndex:firstDepartmentTag];
//
//                            if ([firstModel.departmentId longValue] == [model.parentId longValue]) {
//
//                                [firstModel.children addObject:model];
//
//                            } else {
//
//                                GHDepartmentModel *firstModel = [firstDepartmentArray objectOrNilAtIndex:firstDepartmentTag + 1];
//
//                                if ([firstModel.departmentId longValue] == [model.parentId longValue]) {
//
//                                    [firstModel.children addObject:model];
//
//                                    firstDepartmentTag = [firstDepartmentArray indexOfObject:firstModel];
//
//                                } else {
//
//                                    for (GHDepartmentModel *firstModel in firstDepartmentArray) {
//
//                                        if ([firstModel.departmentId longValue] == [model.parentId longValue]) {
//
//                                            [firstModel.children addObject:model];
//
//                                            firstDepartmentTag = [firstDepartmentArray indexOfObject:firstModel];
//
//                                            break;
//
//                                        }
//
//                                    }
//
//                                }
//
//                            }
//
//                        }
//
//                    }
//
//                    self.departmentArray = [firstDepartmentArray mutableCopy];
//
//                    [self.departmentTableView reloadData];
//
//                }
//
//            }];
  
            
        }
        
    }];
    
}

- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = kDefaultGaryViewColor;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.departmentTableView = tableView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.departmentArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:section];
    return [model.isOpen integerValue] + 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 52;
    } else {
        GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
        return ceil(model.secondDepartmentList.count / 3.f) * 50 - 10 + 40;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        GHGoodDoctorDepartmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHGoodDoctorDepartmentTableViewCell"];
        
        if (!cell) {
            cell = [[GHGoodDoctorDepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHGoodDoctorDepartmentTableViewCell"];
            
            cell.descLabel.hidden = false;
            
        }
        
        cell.model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
        
        
        
        return cell;
        
    } else {
        
        GHHospitalDepartmentChildrenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHHospitalDepartmentChildrenTableViewCell"];
        
        if (!cell) {
            cell = [[GHHospitalDepartmentChildrenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHHospitalDepartmentChildrenTableViewCell"];
        }
        cell.hospitalID = self.hospitalId;
        
        GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
        
        cell.childrenArray = [model.secondDepartmentList copy];
        
        return cell;
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        
        for (NSInteger index = 0; index < self.departmentArray.count; index++) {
            
            GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:index];
            
            if (index == indexPath.section) {
                continue;
            }
            
            model.isOpen = @(false);
            
        }
        
        [self.departmentTableView reloadData];
        
        GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
        
        if (model.secondDepartmentList.count > 0) {
            
            model.isOpen = [NSNumber numberWithBool:![model.isOpen boolValue]];
            
            
            [self.departmentTableView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
            
            [self.departmentTableView scrollToRow:0 inSection:indexPath.section atScrollPosition:UITableViewScrollPositionTop animated:false];
            
            
        } else {
            
            //                    GHDepartmentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.row];
            
            [MobClick event:@"Search_Doctor_Department"];
            
            //                GHSicknessDoctorListViewController *vc = [[GHSicknessDoctorListViewController alloc] init];
            //                vc.departmentName = ISNIL(model.departmentName);
            //                vc.departmentModel = model;
            //                [self.navigationController pushViewController:vc animated:true];
            
            
        }
        
        
    }
    
    
    
}



@end
