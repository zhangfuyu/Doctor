//
//  GHHospitalDepartmentDoctorListViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalDepartmentDoctorListViewController.h"
#import "GHDocterDetailViewController.h"
#import "GHHospitalDoctorTableViewCell.h"
#import "GHNewDoctorModel.h"
#import "GHNewDoctorTableViewCell.h"
#import "GHNewDoctorDetailViewController.h"

@interface GHHospitalDepartmentDoctorListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *doctorArray;
@property (nonatomic, strong) UITableView *doctorTableView;

@end

@implementation GHHospitalDepartmentDoctorListViewController

- (NSMutableArray *)doctorArray {
    
    if (!_doctorArray) {
        _doctorArray = [[NSMutableArray alloc] init];
    }
    return _doctorArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self requestData];
   
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    UITableView *tableView = [[UITableView alloc] init];
    
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.tableFooterView = [UIView new];
    
    tableView.backgroundColor = kDefaultGaryViewColor;
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.doctorTableView = tableView;

    
}


- (void)requestData {

    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"hospitalId"] = ISNIL(self.hospitalId);
    
//    params[@"typeId"] = self.self.departmentId;
    
//    params[@"wordsType"] = @(2);
    
    
    
    if (self.departmentId.length > 0) {
        params[@"departmentId"] = self.departmentId;
    }
    
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude :120.1236);
//
//    NSString *url;
//
//    if ([self.departmentLevel integerValue] == 1) {
//
//        url = kApiHospitalFirstDepartmentDoctors;
//
//        params[@"firstDepartmentId"] = ISNIL(self.departmentId);
//
//    } else if ([self.departmentLevel integerValue] == 2) {
//
//        url = kApiHospitalSecondDepartmentDoctors;
//
//        params[@"secondDepartmentId"] = ISNIL(self.departmentId);
//
//    }
  
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiFindDepartmentDoctor withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.doctorTableView.mj_header endRefreshing];
        [self.doctorTableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            [self.doctorArray removeAllObjects];

            for (NSDictionary *dicInfo in response[@"data"][@"doctorList"]) {
                
              
                
                GHNewDoctorModel *model = [[GHNewDoctorModel alloc] initWithDictionary:dicInfo error:nil];

                if (model == nil) {
                    continue;
                }
                
                [self.doctorArray addObject:model];
                
            }
            
            [self.doctorTableView reloadData];
            
            if (self.doctorArray.count == 0) {
                [self loadingEmptyView];
            }else{
                [self hideEmptyView];
            }
            
        }
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.doctorArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

//    return 165;
    return [GHNewDoctorTableViewCell getCellHeitghtWithMoel:[self.doctorArray objectAtIndex:indexPath.row]];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    GHHospitalDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHHospitalDoctorTableViewCell"];
//
//    if (!cell) {
//        cell = [[GHHospitalDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHHospitalDoctorTableViewCell"];
//    }
//
//    cell.model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
//
//    return cell;
    GHNewDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchDoctorTableViewCell"];
    
    if (!cell) {
        cell = [[GHNewDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchDoctorTableViewCell"];
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    cell.model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    GHNewDoctorDetailViewController *vc = [[GHNewDoctorDetailViewController alloc] init];
//    GHSearchDoctorModel *model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
    GHNewDoctorModel *model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
    vc.doctorId = model.doctorId;
//    vc.distance = model.distance;
    [self.navigationController pushViewController:vc animated:true];
    
}
//然后在UITableView的代理方法中加入以下代码
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
