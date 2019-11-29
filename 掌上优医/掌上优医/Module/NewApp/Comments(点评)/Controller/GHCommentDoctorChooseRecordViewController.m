//
//  GHCommentDoctorChooseRecordViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHCommentDoctorChooseRecordViewController.h"

#import "GHCommentDoctorRecordTableViewCell.h"

#import "GHDocterDetailViewController.h"

#import "GHNSearchHotViewController.h"

#import "GHNewDoctorDetailViewController.h"

#import "GHSearchDoctorModel.h"

@interface GHCommentDoctorChooseRecordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , assign) NSInteger doctorPage;

/**
 <#Description#>
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation GHCommentDoctorChooseRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择医生";
    // Do any additional setup after loading the view.
    
//    self.dataArray = [[GHSaveDataTool shareInstance] getSandboxNoticeDataWithCommentDoctorRecord];
    self.doctorPage = 1;
    
    [self setupUI];
    
    [self requestData];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickShouldReloadData) name:kNotificationDoctorRecordShouldReload object:nil];
}

- (void)clickShouldReloadData {
    
//    self.dataArray = [[GHSaveDataTool shareInstance] getSandboxNoticeDataWithCommentDoctorRecord];
    
    [self.tableView reloadData];
    
}
- (void)reequstPage
{
    self.doctorPage = 1;
    [self.dataArray removeAllObjects];
    [self requestData];
}
- (void)getMoreData
{
    self.doctorPage ++;
    [self requestData];
}
- (void)requestData
{
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"page"] = @(self.doctorPage);
    parmas[@"pageSize"] = @(10);
    parmas[@"contentType"] = @(2);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiGetFootprint withParameter:parmas withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if (isSuccess) {
            
            NSDictionary *dataDic = response[@"data"];
            NSArray *footprintList = dataDic[@"footprintList"];
            
            if (footprintList.count > 0) {
                
                self.doctorPage ++;
                
                for (NSDictionary *dic in footprintList) {
                    
                    NSDictionary *detailsJson = dic[@"detailsJson"];
                    if (detailsJson.allKeys.count == 1) {
                        continue;
                    }
                    
                    GHSearchDoctorModel *model = [[GHSearchDoctorModel alloc]initWithDictionary:dic[@"detailsJson"][@"doctor"] error:nil];
                    model.hospitalName = dic[@"detailsJson"][@"hospitalAddress"];
                    model.hospitalDepartment = [(NSArray *)dic[@"detailsJson"][@"hospitalDepartment"] firstObject];
                    model.hospitalId = dic[@"detailsJson"][@"hospitalId"];
                    [self.dataArray addObject:model];
                    
                }
            }
            else
            {
                self.doctorPage --;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
            }
            
            
            
            
        }
        
        [self.tableView reloadData];
    }];
    
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    UIView *searchTextView = [[UIView alloc] init];
    searchTextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchTextView];
    
    [searchTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(58);
    }];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.titleLabel.font = H14;
    [searchButton setTitle:@"  搜索医生姓名" forState:UIControlStateNormal];
    [searchButton setTitleColor:UIColorHex(0x999999) forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
    searchButton.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    searchButton.layer.shadowOffset = CGSizeMake(0,2);
    searchButton.layer.shadowOpacity = 1;
    searchButton.layer.shadowRadius = 4;
    searchButton.backgroundColor = [UIColor whiteColor];
    searchButton.layer.cornerRadius = 17.5;
    
    
    [searchTextView addSubview:searchButton];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(60);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(8);
        make.right.mas_equalTo(-60);
        
    }];
    
    if (!kiOS10Later) {
        searchButton.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.11];
    }
    
    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reequstPage)];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.backgroundColor = kDefaultGaryViewColor;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(searchTextView.mas_bottom);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.tableView = tableView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 187;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 68;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREENWIDTH, 68);
    view.backgroundColor = kDefaultGaryViewColor;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HM18;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.text = @"最近浏览的医生";
    
    [view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.right.mas_equalTo(-17);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(28);
    }];
    
    return view;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHCommentDoctorRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHCommentDoctorRecordTableViewCell"];
    
    if (!cell) {
        cell = [[GHCommentDoctorRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHCommentDoctorRecordTableViewCell"];
    }
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    GHDocterDetailViewController *vc = [[GHDocterDetailViewController alloc] init];
//
    GHNDoctorRecordModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
//
//    vc.doctorId = model.modelId;
//    [self.navigationController pushViewController:vc animated:true];
    
    GHNewDoctorDetailViewController *doctordetail = [[GHNewDoctorDetailViewController alloc]init];
    doctordetail.doctorId = model.modelId;
    [self.navigationController pushViewController:doctordetail animated:YES];
    
}

- (void)clickSearchAction {
    
    GHNSearchHotViewController *vc = [[GHNSearchHotViewController alloc] init];
    
    vc.type = GHNSearchHotType_Doctor;
    
    vc.isComment = true;
    
    [self.navigationController pushViewController:vc animated:false];
    
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
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
