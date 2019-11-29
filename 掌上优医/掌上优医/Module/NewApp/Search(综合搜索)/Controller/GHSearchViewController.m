//
//  GHSearchViewController.m
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHSearchViewController.h"

#import "GHSearchTagHeaderCollectionReusableView.h"

#import "GHNSearchListViewController.h"

#import "GHNewSearchTableView.h"

#import "GHNewDiseaseDetailViewController.h"


@interface GHSearchViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *historyArray;

@property (nonatomic, strong) NSMutableArray *thinkarry;//联想词

@property (nonatomic, strong) NSString *wordsType;

@property (nonatomic, strong) UIButton *clearButton;

@property (nonatomic, strong) GHSearchTagHeaderCollectionReusableView *hotHeaderView;

@property (nonatomic, strong) GHSearchTagHeaderCollectionReusableView *historyHeaderView;

@property (nonatomic, strong) UIView *historyContentView;

@property (nonatomic, strong) GHNewSearchTableView *searchTable;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIView *headerView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 <#Description#>
 */
@property (nonatomic, assign) CGFloat topHeight;

@end

@implementation GHSearchViewController

- (NSMutableArray *)historyArray {
    
    if (!_historyArray) {
        _historyArray = [[NSMutableArray alloc] init];
    }
    return _historyArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self shouldDecodeArchive];

    [self setupNavigationBar];

    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self setupUI];
    
    __weak typeof(self) weakself = self;
    self.searchTable.clickResultBlock = ^(NSString * _Nonnull key) {
        
        weakself.searchTextField.text = key;
        weakself.searchTable.hidden = YES;
        
        GHNewDiseaseDetailViewController *vc = [[GHNewDiseaseDetailViewController alloc]init];
        vc.selectType = [weakself.wordsType integerValue];
        vc.sicknessId = weakself.searchTextField.text;
        [weakself.navigationController pushViewController:vc animated:false];
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.searchTextField becomeFirstResponder];
    });
    
    
    
}


- (void)setupUI {
    
    [self.searchTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
    UITableView *tableView = [[UITableView alloc] init];
    
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
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 0);
    headerView.backgroundColor = [UIColor whiteColor];
    self.headerView = headerView;
    
    self.titleArray = @[@"性功能障碍", @"盆腔炎", @"阴道炎", @"过敏", @"乳腺增生", @"鼻炎", @"抑郁症", @"前列腺炎"];
    
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
    self.hotHeaderView = hotHeader;
    
    UIView *hotContentView = [[UIView alloc] init];
    [headerView addSubview:hotContentView];
    
    [hotContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(hotHeader.mas_bottom).offset(14);
    }];
    
    CGFloat width = 16;
    NSInteger line = 0;
    
    for (NSInteger index = 0; index < self.titleArray.count; index++) {
        
        NSString *str = [self.titleArray objectOrNilAtIndex:index];
        
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
    
    GHSearchTagHeaderCollectionReusableView *historyHeader = [[GHSearchTagHeaderCollectionReusableView alloc] init];
    historyHeader.titleLabel.text = @"历史搜索";
    historyHeader.titleLabel.textColor = kDefaultBlackTextColor;
    historyHeader.cleanButton.hidden = false;
    [historyHeader.cleanButton addTarget:self action:@selector(clickCleanHistoryAction) forControlEvents:UIControlEventTouchUpInside];
    self.clearButton = historyHeader.cleanButton;
    
    
    self.clearButton.enabled = self.historyArray.count;
    
    if (self.historyArray.count == 0) {
        historyHeader.cleanButton.hidden = true;
        historyHeader.titleLabel.hidden = true;
    } else {
        historyHeader.cleanButton.hidden = false;
        historyHeader.titleLabel.hidden = false;
    }
    [headerView addSubview:historyHeader];
    
    [historyHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(lineLabel.mas_bottom).offset(24);
    }];
    self.historyHeaderView = historyHeader;
    
    self.topHeight = (line * 44 + 24 + 32) + 63 + 63;
    
    [self setupHistoryContentView];
    
    
}

- (void)setupHistoryContentView  {
    
    [self.historyContentView removeAllSubviews];
    self.historyContentView = nil;
    
    UIView *historyContentView = [[UIView alloc] init];
    [self.headerView addSubview:historyContentView];
    
    [historyContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.historyHeaderView.mas_bottom).offset(14);
    }];
    
    CGFloat width = 16;
    CGFloat lineHeight = 0;
    
    NSMutableArray *historyLabelArray = [[NSMutableArray alloc] init];
    
    for (NSInteger index = 0; index < self.historyArray.count; index++) {
        
        NSString *str = [self.historyArray objectOrNilAtIndex:index];
        
        UILabel *sicknessLabel = [[UILabel alloc] init];
        
        sicknessLabel.textColor = kDefaultBlackTextColor;
        
        sicknessLabel.layer.cornerRadius = 4;
        sicknessLabel.numberOfLines = 0;
        sicknessLabel.layer.masksToBounds = true;
        sicknessLabel.textAlignment = NSTextAlignmentCenter;
        sicknessLabel.backgroundColor = UIColorFromRGB(0xF5F4F4);
        sicknessLabel.font = H14;
        sicknessLabel.tag = 100 + index;
        sicknessLabel.userInteractionEnabled = true;
        sicknessLabel.text = ISNIL(str);
        
        [historyContentView addSubview:sicknessLabel];
        
        [historyLabelArray addObject:sicknessLabel];
        
        sicknessLabel.mj_x = width;
        sicknessLabel.width = ceil([str widthForFont:H14] + 24 > (SCREENWIDTH - 32) ? (SCREENWIDTH - 32) : [str widthForFont:H14] + 24);
        sicknessLabel.height = ceil([str heightForFont:H14 width:(SCREENWIDTH - 32)] < 30 ? 30 : [str heightForFont:H14 width:(SCREENWIDTH - 32)] + 12);
        sicknessLabel.mj_y = lineHeight;
        
        width += ceil(([str widthForFont:H14] + 24 > (SCREENWIDTH - 32) ? (SCREENWIDTH - 32) : [str widthForFont:H14]  + 24) + 12);
        
        if (width > (SCREENWIDTH)) {

            width = 16;
            sicknessLabel.mj_x = width;
            
            if (index != 0) {
                sicknessLabel.mj_y = MaxY(((UILabel *)[historyLabelArray objectOrNilAtIndex:(index - 1)])) + 12;
            }
            
            lineHeight = (MinY(sicknessLabel));

            width += ceil(([str widthForFont:H14] + 24 > (SCREENWIDTH - 32) ? (SCREENWIDTH - 32) : [str widthForFont:H14]  + 24) + 12);
            
//            if (width > (SCREENWIDTH - 34)) {
//                width = 17;
//            }
            
        }
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSicknessActionWithGestureRecognizer:)];
        [sicknessLabel addGestureRecognizer:tapGR];
        
    }
    
    lineHeight = MaxY(((UILabel *)[historyLabelArray lastObject])) + 10;
    
    [historyContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(lineHeight);
    }];
    self.historyContentView = historyContentView;
    
    self.headerView.height = self.topHeight + lineHeight;
    
    self.tableView.tableHeaderView = self.headerView;
    
}

- (void)clickSicknessActionWithGestureRecognizer:(UIGestureRecognizer *)gr {
    
    NSString *searchKey = ISNIL([self.historyArray objectOrNilAtIndex:((UILabel *)gr.view).tag - 100]);
    
    [self.view endEditing:true];
    
    [self.searchTextField resignFirstResponder];
    
    [MobClick event:@"Home_Search_History"];
    GHNewDiseaseDetailViewController *vc = [[GHNewDiseaseDetailViewController alloc]init];
    vc.selectType = 1;
    vc.sicknessId = searchKey;
    [self.navigationController pushViewController:vc animated:false];
    
    
//    GHNSearchListViewController *vc = [[GHNSearchListViewController alloc] init];
//    vc.searchKey = searchKey;
//    [self.navigationController pushViewController:vc animated:false];

}

- (void)clickSicknessAction:(UIButton *)sender {
    
    
    NSString *searchKey;
    
    if (sender.tag < 100) {
        searchKey = ISNIL([self.titleArray objectOrNilAtIndex:sender.tag]);
    } else {
        searchKey = ISNIL([self.historyArray objectOrNilAtIndex:sender.tag - 100]);
    }
    
    [self.view endEditing:true];
    
    [self.searchTextField resignFirstResponder];
    
    [MobClick event:@"Home_Search_Hot"];
    
    GHNewDiseaseDetailViewController *vc = [[GHNewDiseaseDetailViewController alloc]init];
    vc.sicknessId = searchKey;
    [self.navigationController pushViewController:vc animated:false];
    
//    GHNSearchListViewController *vc = [[GHNSearchListViewController alloc] init];
//    vc.searchKey = searchKey;
//    [self.navigationController pushViewController:vc animated:false];

    
    
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
    searchTextField.placeholder = @"搜索疾病、医生、医院、资讯";
    searchTextField.font = H14;
    searchTextField.delegate = self;
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

    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    searchButton.titleLabel.font = H16;
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:searchButton];

    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(searchTextField.mas_right);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    

    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];



}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
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
    
//    [self hideLeftButton];
    
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

        // 如果有搜索历史
        if (![self.historyArray containsObject:ISNIL(self.searchTextField.text)]) {

            
            if (self.searchTextField.text.length > 10) {
                 [self.historyArray insertObject:[self.searchTextField.text substringToIndex:10] atIndex:0];
            }
            else
            {
                [self.historyArray insertObject:self.searchTextField.text atIndex:0];

            }
            

            [self shouldEncodeArchive];

        }

        [self.view endEditing:true];

        [self.searchTextField resignFirstResponder];
    
        [MobClick event:@"Home_Search_Input"];
        self.searchTable.hidden = YES;

//        GHNSearchListViewController *vc = [[GHNSearchListViewController alloc] init];
//        vc.searchKey = self.searchTextField.text;
//        [self.navigationController pushViewController:vc animated:false];
        
        GHNewDiseaseDetailViewController *vc = [[GHNewDiseaseDetailViewController alloc]init];
        vc.sicknessId = self.searchTextField.text;
        [self.navigationController pushViewController:vc animated:false];
        
        
    }

}

- (void)clickCancelAction {
    
    [self.view endEditing:true];
    
    [self.searchTextField resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)clickCleanHistoryAction {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除搜索记录吗?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.historyArray removeAllObjects];
        
        [self shouldEncodeArchive];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    
    [self presentViewController:alertController animated:true completion:nil];

    

    
}

- (void)shouldDecodeArchive {
    
    //获取文件路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //在document文件夹下,创建新的文件
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"SearchContentHistoryFile.a"];
    
    
    self.historyArray = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:filePath]];
    
    
    self.clearButton.enabled = self.historyArray.count;
    
    if (self.historyArray.count == 0) {
        self.historyHeaderView.cleanButton.hidden = true;
        self.historyHeaderView.titleLabel.hidden = true;
    } else {
        self.historyHeaderView.cleanButton.hidden = false;
        self.historyHeaderView.titleLabel.hidden = false;
    }
}

- (void)shouldEncodeArchive {
    
    //获取文件路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //在document文件夹下,创建新的文件
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"SearchContentHistoryFile.a"];
    
    NSMutableArray *archiverArray = [[NSMutableArray alloc] init];
    
    [archiverArray addObjectsFromArray:self.historyArray];
    
    if (self.historyArray.count > 10) {
        
        [archiverArray removeAllObjects];

        for (NSInteger index = 0; index < 10; index++) {
            
            NSString *searchKey = [self.historyArray objectOrNilAtIndex:index];
            
            if (searchKey.length) {
                [archiverArray addObject:searchKey];
            }
            
        }
        
        self.historyArray = [archiverArray mutableCopy];
        
    }
    
    
    
    [NSKeyedArchiver archiveRootObject:archiverArray toFile:filePath];
    
//    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    
    self.clearButton.enabled = self.historyArray.count;
    
    if (self.historyArray.count == 0) {
        self.historyHeaderView.cleanButton.hidden = true;
        self.historyHeaderView.titleLabel.hidden = true;
    } else {
        self.historyHeaderView.cleanButton.hidden = false;
        self.historyHeaderView.titleLabel.hidden = false;
    }
    
    [self setupHistoryContentView];
    
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField{

    [self thinkSearchWith:textField.text];
}
- (void)thinkSearchWith:(NSString *)text
{
    
    if (text.length == 0) {
        return;
    }
    NSMutableDictionary *param = [@{
                                    @"words":text,
//                                    @"city":@""
                                    }copy];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchthinkDisease withParameter:param withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:YES withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            self.thinkarry = response[@"data"][@"diseaseNameList"];
            if (self.thinkarry.count > 0) {
                self.searchTable.hidden = NO;
                self.searchTable.searchText = text;
                self.searchTable.thinkData = self.thinkarry;
                [self.view bringSubviewToFront:self.searchTable];
                
                self.wordsType = [NSString stringWithFormat:@"%@",response[@"data"][@"wordsType"]];
            }
            else
            {
                self.searchTable.hidden = YES;
                self.searchTable.searchText = text;
                self.searchTable.thinkData = self.thinkarry;

//                [self.searchTable.thinkData removeAllObjects];
            }
            
           
            
        }
        
    }];
}


- (GHNewSearchTableView *)searchTable
{
    if (!_searchTable) {
        _searchTable = [[GHNewSearchTableView alloc]init];
        _searchTable.hidden = YES;
        [self.view addSubview:_searchTable];
        
    }
    return _searchTable;
}

@end


