//
//  GHNSearchHotViewController.m
//  掌上优医
//
//  Created by GH on 2019/4/4.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNSearchHotViewController.h"
#import "GHSearchTagHeaderCollectionReusableView.h"

#import "GHSearchResultSicknessViewController.h"
#import "GHSearchResultDoctorViewController.h"
#import "GHSearchHospitalListViewController.h"

#import "GHNSearchTextTableViewCell.h"

#import "GHNSearchInformationViewController.h"
#import "GHSearchSicknessModel.h"

#import "GHNDiseaseDetailViewController.h"

#import "GHCommentDoctorSearchListViewController.h"
#import "GHCommentHospitalSearchListViewController.h"

#import "GHSearchHospitalModel.h"
#import "GHNSearchHospitalTextTableViewCell.h"
#import "GHHospitalDetailViewController.h"

@interface GHNSearchHotViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *hotArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation GHNSearchHotViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (NSMutableArray *)hotArray {
    
    if (!_hotArray) {
        _hotArray = [[NSMutableArray alloc] init];
    }
    return _hotArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self setupUI];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.searchTextField becomeFirstResponder];
    });
    
    
}

- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    tableView.backgroundColor = kDefaultGaryViewColor;
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.tableView = tableView;
    
    if (self.type == GHNSearchHotType_Disease) {
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiHotSearchwrd withParameter:nil withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
           
            if (isSuccess) {
                
                for (id dicInfo in response) {
                    
                    if ([dicInfo isKindOfClass:[NSDictionary class]]) {
                        [self.hotArray addObject:ISNIL(dicInfo[@"searchWord"])];
                    } else {
                        [self.hotArray addObject:ISNIL(dicInfo)];
                    }
                    
                }
                
                if (self.hotArray.count) {
                    [self setupTableHeaderView];
                }
                
            }
            
        }];
        
    }
    
}

- (void)setupTableHeaderView {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 0);
    headerView.backgroundColor = [UIColor whiteColor];
    self.headerView = headerView;
    
    GHSearchTagHeaderCollectionReusableView *hotHeader = [[GHSearchTagHeaderCollectionReusableView alloc] init];
    hotHeader.titleLabel.text = @"热门搜索";
    hotHeader.titleLabel.textColor = kDefaultBlackTextColor;
    hotHeader.cleanButton.hidden = true;
    [headerView addSubview:hotHeader];
    
    [hotHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(24);
    }];
    
    UIView *hotContentView = [[UIView alloc] init];
    [headerView addSubview:hotContentView];
    
    [hotContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(hotHeader.mas_bottom).offset(14);
    }];
    
    CGFloat width = 16;
    NSInteger line = 0;
    
    for (NSInteger index = 0; index < self.hotArray.count; index++) {
        
        NSString *str = [self.hotArray objectOrNilAtIndex:index];
        
        UIButton *sicknessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [sicknessButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        sicknessButton.layer.cornerRadius = 4;
        sicknessButton.backgroundColor = kDefaultGaryViewColor;
        sicknessButton.titleLabel.font = H14;
        sicknessButton.tag = index;
        
        [sicknessButton setTitle:str forState:UIControlStateNormal];
        
        [hotContentView addSubview:sicknessButton];
        
        [sicknessButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(width);
            make.width.mas_equalTo([str widthForFont:sicknessButton.titleLabel.font] + 24);
            make.top.mas_equalTo(line * 44);
            make.height.mas_equalTo(32);
        }];
        
        width += [str widthForFont:sicknessButton.titleLabel.font] + 24 + 12;
        
        if (width > SCREENWIDTH) {
            line += 1;
            width = 16;
            [sicknessButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(width);
                make.top.mas_equalTo(line * 44);
            }];
            width += [str widthForFont:sicknessButton.titleLabel.font] + 24 + 12;
        }
        
        [sicknessButton addTarget:self action:@selector(clickSicknessAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    
    [hotContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(line * 44 + 24 + 32);
    }];
    
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [headerView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(hotContentView.mas_bottom);
    }];
    
    self.headerView.frame = CGRectMake(0, 0, SCREENWIDTH, (line * 44 + 24 + 32) + 63);
    
    if (self.type == GHNSearchHotType_Disease) {
        self.tableView.tableHeaderView = self.headerView;
    } else {
        self.tableView.tableHeaderView = nil;
    }
    
}

- (void)clickSicknessAction:(UIButton *)sender {
    
    
    NSString *searchKey;
    
    searchKey = ISNIL([self.hotArray objectOrNilAtIndex:sender.tag]);

    [self.view endEditing:true];
    
    [self.searchTextField resignFirstResponder];
    
    GHSearchResultSicknessViewController *vc = [[GHSearchResultSicknessViewController alloc] init];
    vc.searchKey = searchKey;
    [self.navigationController pushViewController:vc animated:false];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (self.searchTextField.text.length) {
        return 50;
    }
    
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (self.searchTextField.text.length) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
        
        UIImageView *searchIconImageView = [[UIImageView alloc] init];
        searchIconImageView.contentMode = UIViewContentModeCenter;
        searchIconImageView.image = [[UIImage imageNamed:@"home_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        searchIconImageView.tintColor = UIColorHex(0xB2B2B2);
        [view addSubview:searchIconImageView];

        [searchIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(8);
            make.width.mas_equalTo(30);

        }];

        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = HM15;
        titleLabel.textColor = UIColorHex(0x999999);
        titleLabel.text = @"搜索全部相关结果";
        [view addSubview:titleLabel];

        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(searchIconImageView.mas_right);
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];

        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:actionButton];

        [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_equalTo(0);
        }];

        [actionButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
        
        return view;
        
    }
    
    return nil;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == GHNSearchHotType_Hospital && self.isComment) {
        
        GHNSearchHospitalTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchHospitalTextTableViewCell"];
        
        if (!cell) {
            cell = [[GHNSearchHospitalTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchHospitalTextTableViewCell"];
        }
        
        cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
    }
    
    GHNSearchTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchTextTableViewCell"];
    
    if (!cell) {
        cell = [[GHNSearchTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchTextTableViewCell"];
    }
    
    GHSearchSicknessModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    cell.titleLabel.text = ISNIL(model.diseaseName);
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == GHNSearchHotType_Hospital && self.isComment) {
        
        GHHospitalDetailViewController *vc = [[GHHospitalDetailViewController alloc] init];
        vc.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:true];
        
        return;
    }
    
    GHNDiseaseDetailViewController *vc = [[GHNDiseaseDetailViewController alloc] init];
    GHSearchSicknessModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    vc.sicknessId = ISNIL(model.modelId);
    vc.sicknessName = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.diseaseName)];
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.searchTextField resignFirstResponder];
    
}


- (void)setupNavigationBar {
    
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, Height_NavBar - Height_StatusBar)];
    navigationView.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:navigationView];
    
    
    self.navigationView = navigationView;
    
    UITextField *searchTextField = [[UITextField alloc] init];
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.layer.cornerRadius = 17.5;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

    searchTextField.font = H14;
    searchTextField.textColor = kDefaultBlackTextColor;
    searchTextField.returnKeyType = UIReturnKeySearch;
    searchTextField.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    searchTextField.layer.shadowOffset = CGSizeMake(0,2);
    searchTextField.layer.shadowOpacity = 1;
    searchTextField.layer.shadowRadius = 4;
    
    
    if (!kiOS10Later) {
        searchTextField.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.11];
    }
    
    [navigationView addSubview:searchTextField];
    
    if (self.type == GHNSearchHotType_Disease) {
        searchTextField.placeholder = @"请输入疾病名称或症状";
    } else if (self.type == GHNSearchHotType_Doctor) {
        searchTextField.placeholder = @"请输入医生姓名";
    } else if (self.type == GHNSearchHotType_Hospital) {
        searchTextField.placeholder = @"请输入医院名称";
    } else if (self.type == GHNSearchHotType_Information) {
        searchTextField.placeholder = @"请输入资讯标题";
    }
    
    [searchTextField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];

    
    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    searchIconImageView.contentMode = UIViewContentModeCenter;
    searchIconImageView.image = [[UIImage imageNamed:@"home_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    searchIconImageView.size = CGSizeMake(35, 35);
    searchIconImageView.tintColor = UIColorHex(0xB2B2B2);
    //    searchIconImageView.size = CGSizeMake(Height_NavBar - Height_StatusBar - 10, Height_NavBar - Height_StatusBar - 10);
    
    searchTextField.leftView = searchIconImageView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(35);
        make.centerY.mas_equalTo(navigationView);
        make.right.mas_equalTo(-64);
    }];
    [searchTextField addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    self.searchTextField = searchTextField;
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    searchButton.titleLabel.font = H16;
    [searchButton setTitle:@"取消" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:searchButton];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(searchTextField.mas_right);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [self hideLeftButton];
    
//    [self addLeftButton:@selector(clickNoneAction) image:[UIImage imageNamed:@""]];
}


#pragma mark -给每个cell中的textfield添加事件，只要值改变就调用此函数
- (void)changedTextField:(UITextField *)textField
{
    if (textField.text.length == 0) {
        if (self.type == GHNSearchHotType_Disease) {
            self.tableView.tableHeaderView = self.headerView;
        } else {
            self.tableView.tableHeaderView = nil;
        }
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
    } else {
        self.tableView.tableHeaderView = nil;
        if (self.type == GHNSearchHotType_Disease) {
            [self.dataArray addObject:@(1)];
//            [self requestData];
        } else if (self.type == GHSaveDataType_Hospital && self.isComment == true) {
            [self.dataArray addObject:@(1)];
//            [self requestHospitalData];
        } else {
            [self.tableView reloadData];
        }
    }
}

- (void)requestHospitalData {
    
    if (self.searchTextField.text.length == 0) {
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"search"] = self.searchTextField.text;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchHospitalSuggest withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            [self.dataArray removeAllObjects];
            
            for (NSDictionary *dicInfo in response) {
                
                GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                [self.dataArray addObject:model];
                
            }
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

- (void)requestData {
    
    if (self.searchTextField.text.length == 0) {
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"search"] = self.searchTextField.text;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchDiseaseSuggest withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {

        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            [self.dataArray removeAllObjects];
            
            for (NSDictionary *dicInfo in response) {
                
                GHSearchSicknessModel *model = [[GHSearchSicknessModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                if ([dicInfo[@"diseaseId"] longValue]) {
                    model.modelId = dicInfo[@"diseaseId"];
                }

                [self.dataArray addObject:model];
                
            }
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}


- (void)clickSearchAction {
    

    
    if (self.searchTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您要搜索的内容"];
        return;
    }
    
    if ([NSString isEmpty:self.searchTextField.text] || [NSString stringContainsEmoji:self.searchTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的搜索内容"];
        return;
    }
    
    [self.view endEditing:true];
    
    [self.searchTextField resignFirstResponder];
    
    if (self.type == GHNSearchHotType_Disease) {
        
        [MobClick event:@"Search_Disease_Input"];
        
        GHSearchResultSicknessViewController *vc = [[GHSearchResultSicknessViewController alloc] init];
        vc.searchKey = self.searchTextField.text;
        [self.navigationController pushViewController:vc animated:false];
        
    } else if (self.type == GHNSearchHotType_Doctor) {
        
        if (self.isComment) {
            
            GHCommentDoctorSearchListViewController *vc = [[GHCommentDoctorSearchListViewController alloc] init];
            vc.searchKey = self.searchTextField.text;
            [self.navigationController pushViewController:vc animated:false];
            
        } else {
            
            [MobClick event:@"Search_Doctor_Input"];
            
            GHSearchResultDoctorViewController *vc = [[GHSearchResultDoctorViewController alloc] init];
            vc.searchKey = self.searchTextField.text;
            [self.navigationController pushViewController:vc animated:false];
            
        }
        
    } else if (self.type == GHNSearchHotType_Hospital) {
        
        if (self.isComment) {
            
            GHCommentHospitalSearchListViewController *vc = [[GHCommentHospitalSearchListViewController alloc] init];
            vc.searchKey = self.searchTextField.text;
            [self.navigationController pushViewController:vc animated:false];
            
        } else {
         
            [MobClick event:@"Search_Hospital_Input"];
            
            GHSearchHospitalListViewController *vc = [[GHSearchHospitalListViewController alloc] init];
            vc.searchKey = ISNIL(self.searchTextField.text);
            [self.navigationController pushViewController:vc animated:false];
            
        }
        
    } else if (self.type == GHNSearchHotType_Information) {
        
        [MobClick event:@"Search_News_Input"];
        
        GHNSearchInformationViewController *vc = [[GHNSearchInformationViewController alloc] init];
        vc.searchKey = ISNIL(self.searchTextField.text);
        [self.navigationController pushViewController:vc animated:false];

        
    }
    

    
}

- (void)clickCancelAction {
    
    [self.navigationController popViewControllerAnimated:false];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationView.hidden = false;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
    //    [self hideLeftButton];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationView.hidden = true;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
    //    [self hideLeftButton];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self hideLeftButton];
    
}


@end
