//
//  GHNSearchInformationViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNSearchInformationViewController.h"

#import "GHInformationDetailViewController.h"
#import "GHNSearchInformationTableViewCell.h"

#import "UIButton+touch.h"



@interface GHNSearchInformationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) NSMutableArray *informationArray;
@property (nonatomic, assign) NSUInteger informationCurrentPage;
@property (nonatomic, assign) NSUInteger informationTotalPage;
@property (nonatomic, strong) UITableView *informationTableView;

@property (nonatomic, strong) UIView *informationHeaderView;

@property (nonatomic, strong) UIButton *informationSortButton;
@property (nonatomic, strong) UIView *informationSortView;

@property (nonatomic, strong) NSString *informationSort;

@end

@implementation GHNSearchInformationViewController

- (UIView *)informationHeaderView {
    
    if (!_informationHeaderView) {
        
        _informationHeaderView = [[UIView alloc] init];
        _informationHeaderView.backgroundColor = kDefaultGaryViewColor;
        _informationHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH, 52);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.titleLabel.font = H14;
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
        button.isIgnore = true;
        [button setTitle:@"排序" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"search_sort_down_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"search_sort_up_icon"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(clicklInformationSortAction:) forControlEvents:UIControlEventTouchUpInside];
        button.transform = CGAffineTransformMakeScale(-1, 1);
        button.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
        button.imageView.transform = CGAffineTransformMakeScale(-1, 1);
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
        [_informationHeaderView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(120);
        }];
        self.informationSortButton = button;
        
    }
    return _informationHeaderView;
    
}

- (UIView *)informationSortView {
    
    if (!_informationSortView) {
        
        _informationSortView = [[UIView alloc] init];
        _informationSortView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _informationSortView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        [self.view addSubview:_informationSortView];
        
        UIView *popView = [[UIView alloc] init];
        popView.backgroundColor = [UIColor clearColor];
        popView.layer.masksToBounds = true;
        [_informationSortView addSubview:popView];
        
        [popView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(110);
            make.height.mas_equalTo(140);
            make.top.mas_equalTo(40);
            make.right.mas_equalTo(-30);
        }];
        
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.contentMode = UIViewContentModeScaleToFill;
        bgImageView.userInteractionEnabled = true;
        bgImageView.image = [UIImage imageNamed:@"doctorMoreBg"];
        [popView addSubview:bgImageView];
        
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        
        NSArray *titleArray = @[@"默认", @"浏览次数", @"收藏次数"];
        for (NSInteger index = 0; index < titleArray.count; index++) {
            
            UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
            actionButton.tag = index;
            [popView addSubview:actionButton];
            
            [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(40);
                make.top.mas_equalTo(index * 40 + 12);
            }];
            
            UILabel *lineLabel = [[UILabel alloc] init];
            lineLabel.backgroundColor = kDefaultGaryViewColor;
            [popView addSubview:lineLabel];
            
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(actionButton);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(1);
            }];
            
            if (index == 2) {
                lineLabel.hidden = true;
            }
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.font = H14;
            titleLabel.textColor = kDefaultBlackTextColor;
            titleLabel.text = ISNIL([titleArray objectOrNilAtIndex:index]);
            [popView addSubview:titleLabel];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(actionButton);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
            }];
            
            [actionButton addTarget:self action:@selector(clickInformationAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        UITapGestureRecognizer *noneTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOtherAction)];
        [popView addGestureRecognizer:noneTapGR];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [_informationSortView addGestureRecognizer:tapGR];
        
    }
    
    return _informationSortView;
    
}

- (void)clickOtherAction {
    
}

- (void)clickInformationAction:(UIButton *)sender {
    
    if (sender.tag == 1) {
        self.informationSort = @"浏览次数";
        [MobClick event:@"Sort_News" label:@"资讯浏览次数排序"];
    } else if (sender.tag == 2) {
        self.informationSort = @"收藏次数";
        [MobClick event:@"Sort_News" label:@"资讯收藏次数排序"];
    } else {
        self.informationSort = @"默认";
        [MobClick event:@"Sort_News" label:@"资讯默认排序"];
    }
    
    [self clickNoneView];
    
    [self refreshData];
    
}

- (void)clicklInformationSortAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
    }
    
    self.informationSortView.hidden = !sender.selected;
    
}

- (void)clickNoneView {

    self.informationSortView.hidden = true;
    self.informationSortButton.selected = false;
    
    //    [self.searchTextField resignFirstResponder];
    [self.searchTextField resignFirstResponder];
    
}

- (NSMutableArray *)informationArray {
    
    if (!_informationArray) {
        _informationArray = [[NSMutableArray alloc] init];
    }
    return _informationArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupConfig];
    
    [self setupNavigationBar];
    
    [self setupUI];
    
    [self requestData];
    
}

- (void)setupConfig{
    
    self.pageSize = 10;
    self.informationTotalPage = 1;
    self.informationCurrentPage = 0;
    
}

- (void)refreshData{
    

        self.informationCurrentPage = 0;
        self.informationTotalPage = 1;
        if (self.informationArray.count) {
            [self.informationTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
    
    
    [self requestData];
    
}

- (void)getMoreData{

    self.informationCurrentPage += self.pageSize;
    
    [self requestData];
    
}

- (void)requestData {
    
    if (self.informationCurrentPage > self.informationTotalPage) {
        [self.informationTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
//    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"search"] = ISNIL(self.searchKey);
    params[@"pageSize"] = @(self.pageSize);
    params[@"from"] = @(self.informationCurrentPage);

    if ([self.informationSort isEqualToString:@"浏览次数"]) {
        params[@"sortType"] = @(6);
    } else if ([self.informationSort isEqualToString:@"收藏次数"]) {
        params[@"sortType"] = @(7);
    } else {
        params[@"sortType"] = @(1);
    }
    
//    if ([self.informationSort isEqualToString:@"浏览次数"]) {
//        params[@"sortType"] = @(6);
//    } else if ([self.informationSort isEqualToString:@"收藏次数"]) {
//        params[@"sortType"] = @(7);
//    } else {
//        params[@"sortType"] = @(1);
//    }
    
    //        排序方式 [1:默认排序 6:浏览最多 7:收藏最多]
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchNews withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.informationTableView.mj_header endRefreshing];
        [self.informationTableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.informationCurrentPage == 0) {
                
                [self.informationArray removeAllObjects];
                
            }
            
            for (NSDictionary *dicInfo in response) {
                
                GHArticleInformationModel *model = [[GHArticleInformationModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                [self.informationArray addObject:model];
                
            }
            
            if (((NSArray *)response).count >= self.pageSize) {
                self.informationTotalPage = self.informationArray.count + 1;
            } else {
                self.informationTotalPage = self.informationCurrentPage;
            }
            
            [self.informationTableView reloadData];
            
            if (self.informationArray.count == 0) {
                [self loadingEmptyView];
            }else{
                [self hideEmptyView];
            }
            
        }
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.informationArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 52;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.informationHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
        GHNSearchInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchInformationTableViewCell"];
        
        if (!cell) {
            cell = [[GHNSearchInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchInformationTableViewCell"];
        }
        
        cell.model = [self.informationArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
 
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        GHInformationDetailViewController *vc = [[GHInformationDetailViewController alloc] init];
        GHArticleInformationModel *model = [self.informationArray objectOrNilAtIndex:indexPath.row];
        vc.informationId = model.modelId;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:true];
    
}


- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
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
    self.informationTableView = tableView;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
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
    searchTextField.placeholder = @"请输入资讯标题";
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
    
    searchTextField.text = ISNIL(self.searchKey);
    [navigationView addSubview:searchTextField];
    
    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    searchIconImageView.contentMode = UIViewContentModeCenter;
    searchIconImageView.image = [UIImage imageNamed:@"home_search"];
    searchIconImageView.size = CGSizeMake(35, 35);
//    searchIconImageView.size = CGSizeMake(Height_NavBar - Height_StatusBar - 10, Height_NavBar - Height_StatusBar - 10);
    
    searchTextField.leftView = searchIconImageView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(56);
        make.height.mas_equalTo(35);
        make.centerY.mas_equalTo(navigationView);
        make.right.mas_equalTo(-64);
    }];
    [searchTextField addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    self.searchTextField = searchTextField;
    

    
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];
    
    
    
}

- (void)clickSearchAction {
    
    if (self.searchTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您要搜索的内容"];
        return;
    }
    
    if (self.searchTextField.text.length > 40) {
        [SVProgressHUD showErrorWithStatus:@"搜索的内容不得大于40字"];
        return;
    }
    
    if ([NSString isEmpty:self.searchTextField.text] || [NSString stringContainsEmoji:self.searchTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的搜索内容"];
        return;
    }
    
    if (self.searchTextField.text.length) {
        
        self.searchKey = self.searchTextField.text;
        [self.searchTextField resignFirstResponder];
        
        [self refreshData];
        
        [self clickNoneView];
        
    }
    
}

- (void)clickCancelAction {
    
    [self.searchTextField resignFirstResponder];
    
    [self.searchTextField resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:true];
    
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
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}


@end
