//
//  GHNSearchSicknessViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/18.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNSearchSicknessViewController.h"

#import "GHSearchDepartmentCollectionViewCell.h"
#import "GHSearchSicknessCollectionReusableView.h"

#import "GHSearchResultSicknessViewController.h"
#import "GHSicknessLibraryViewController.h"

#import "GHDepartmentModel.h"

@interface GHNSearchSicknessViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, GHSearchSicknessCollectionReusableViewDelegate>

@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSMutableArray *departmentArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *searchView;

@end

@implementation GHNSearchSicknessViewController

- (NSMutableArray *)departmentArray {
    
    if (!_departmentArray) {
        _departmentArray = [[NSMutableArray alloc] init];
    }
    return _departmentArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self setupNavigationBar];
    
    self.navigationItem.title = @"查疾病";
    
    [self setupSearchView];
    
    [self setupUI];
    
    [self getDataAction];
}

- (void)getDataAction {
    
//    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
//    NSArray *sortArray = [@"消化科、呼吸科、内分泌科、内科其他、普通外科、泌尿外科、妇产科、男科、皮肤科、康复医学、耳鼻喉科、口腔科、眼科、整形科、急诊科、生殖医学科、心血管病科、感染科、肾内科、胸外科、肛肠科、骨科、血液内科、神经科、麻醉科、外科其他、变态反应科、风湿免疫科、肿瘤科、儿科、预防医学科、介入医学科、精神心理科、成瘾医学科、中西医结合科、高压氧医学科" componentsSeparatedByString:@"、"];
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSystemparamDepartments withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {

        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            for (NSDictionary *info in response) {
                
                GHDepartmentModel *model = [[GHDepartmentModel alloc] initWithDictionary:info error:nil];
                
                if (model == nil) {
                    continue;
                }
                
//                if ([sortArray containsObject:ISNIL(model.departmentName)]) {
//
//                    model.sortTag = @([sortArray indexOfObject:ISNIL(model.departmentName)]);
//
//                } else {
//
//                    model.sortTag = @(100);
//
//                }
                
                [self.departmentArray addObject:model];
                
            }
            
//            NSArray *sortResultArray = [self.departmentArray sortedArrayUsingComparator:^NSComparisonResult(GHDepartmentModel *obj1, GHDepartmentModel *obj2) {
//                return [obj1.sortTag compare:obj2.sortTag];
//            }];
//            
//            [self.departmentArray removeAllObjects];
//            [self.departmentArray addObjectsFromArray:sortResultArray];
            
            [self.collectionView reloadData];
            
        }
        
    }];
    
}

- (void)setupSearchView {
    
    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchView];
    
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(68);
    }];
    
    self.searchView = searchView;
    
    UITextField *searchTextField = [[UITextField alloc] init];
    searchTextField.font = H14;
    searchTextField.textColor = kDefaultBlackTextColor;
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.layer.cornerRadius = 17.5;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.placeholder = @"请输入症状或疾病名称等";
    searchTextField.returnKeyType = UIReturnKeySearch;
    searchTextField.font = H14;
    searchTextField.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    searchTextField.layer.shadowOffset = CGSizeMake(0,2);
    searchTextField.layer.shadowOpacity = 1;
    searchTextField.layer.shadowRadius = 4;
    
    if (!kiOS10Later) {
        searchTextField.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.11];
    }
    
    [searchView addSubview:searchTextField];
    
    
    
    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    searchIconImageView.contentMode = UIViewContentModeCenter;
    searchIconImageView.image = [UIImage imageNamed:@"home_search"];
    searchIconImageView.size = CGSizeMake(35, 35);
//    searchIconImageView.size = CGSizeMake(Height_NavBar - Height_StatusBar - 10, Height_NavBar - Height_StatusBar - 10);
    
    searchTextField.leftView = searchIconImageView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.height.mas_equalTo(35);
        make.top.mas_equalTo(7);
        make.right.mas_equalTo(-60);
    }];
    [searchTextField addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    self.searchTextField = searchTextField;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [searchView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
//    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
//    [searchButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
//    searchButton.titleLabel.font = H16;
//    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
//    [searchView addSubview:searchButton];
//
//    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(searchTextField.mas_right);
//        make.bottom.mas_equalTo(0);
//        make.top.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//    }];
    
//    UILabel *lineLabel = [[UILabel alloc] init];
//    lineLabel.backgroundColor = UIColorHex(0xE6E6E6);
//    [searchView addSubview:lineLabel];
//
//    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(0);
//        make.height.mas_equalTo(1);
//    }];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}


- (void)setupUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 1.设置 最小行间距
    layout.minimumLineSpacing = 0;
    // 2.设置 最小列间距
    layout. minimumInteritemSpacing  = 0;
    // 3.设置item块的大小 (可以用于自适应)
    
    // 设置滑动的方向 (默认是竖着滑动的)
    layout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    // 设置item的内边距
    layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    
//    layout.itemSize = CGSizeMake((SCREENWIDTH - 30) / 4.f, (265) / 4.f);

    layout.itemSize = CGSizeMake((SCREENWIDTH - 32) / 4.f, (SCREENWIDTH - 32) / 4.f);
    
    if (IS_IPHONE4_SERIES || kiPhone5) {
        layout.headerReferenceSize = CGSizeMake(SCREENWIDTH, 258 + 20);
    } else if (kiPhone6 || IS_IPHONE_X || IS_IPHONE_Xs) {
        layout.headerReferenceSize = CGSizeMake(SCREENWIDTH, 209 + 20);
    } else if (kiPhone6Plus || IS_IPHONE_Xr || IS_IPHONE_Xs_Max) {
        layout.headerReferenceSize = CGSizeMake(SCREENWIDTH, 209 + 20);
    } else {
        layout.headerReferenceSize = CGSizeMake(SCREENWIDTH, 258 + 20);
    }
    
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 68, SCREENWIDTH, SCREENHEIGHT + kBottomSafeSpace - 68 - Height_NavBar) collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[GHSearchDepartmentCollectionViewCell class] forCellWithReuseIdentifier:@"GHSearchDepartmentCollectionViewCell"];
    //注册头视图
    [self.collectionView registerClass:[GHSearchSicknessCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GHSearchSicknessCollectionReusableView"];
    
}


#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.departmentArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GHSearchDepartmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHSearchDepartmentCollectionViewCell" forIndexPath:indexPath];
    
    GHDepartmentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.row];
    
    [cell.iconImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.departmentsIconUrl))];
    
    cell.titleLabel.text = ISNIL(model.departmentName);
    
    return cell;
    
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        GHSearchSicknessCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GHSearchSicknessCollectionReusableView" forIndexPath:indexPath];
        
        header.delegate = self;
        
        return header;
        
    }
    
    return nil;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:true];
    
    [self.searchTextField resignFirstResponder];
    
    [MobClick event:@"Search_Disease_Department"];
    
    GHSicknessLibraryViewController *vc = [[GHSicknessLibraryViewController alloc] init];
    vc.dataArray = [self.departmentArray mutableCopy];
    vc.selectedIndex = indexPath.row;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)finishSearchKeyWithText:(NSString *)text {
    
    [MobClick event:@"Search_Disease_Hot"];
    
    [self gotoSicknessSearchIWithSearchKey:text];
    
}

- (void)gotoSicknessSearchIWithSearchKey:(NSString *)searchKey {
    
    [self.view endEditing:true];
    
    [self.searchTextField resignFirstResponder];
    
    GHSearchResultSicknessViewController *vc = [[GHSearchResultSicknessViewController alloc] init];
    vc.searchKey = searchKey;
    [self.navigationController pushViewController:vc animated:false];
    
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
    
    if (self.searchTextField.text.length) {
        
        [MobClick event:@"Search_Disease_Input"];
        
        [self gotoSicknessSearchIWithSearchKey:self.searchTextField.text];
        
        self.searchTextField.text = @"";
        
    }
    
}

- (void)clickCancelAction {
    
    [self.view endEditing:true];
    
    [self.searchTextField resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:true];
    
}

@end
