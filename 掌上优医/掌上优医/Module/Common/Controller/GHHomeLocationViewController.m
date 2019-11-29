//
//  GHHomeLocationViewController.m
//  掌上优医
//
//  Created by GH on 2018/10/27.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHHomeLocationViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "GHAreaTool.h"
#import "GHAreaModel.h"
#import "PinYin4Objc.h"
#import "GHLocationAreaTableViewCell.h"


#import "IndexView.h"

@interface GHHomeLocationViewController ()<AMapLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, IndexViewDelegate, IndexViewDataSource>

/**
 高德定位Manager 如果不引用,则会出现请求权限框闪现或每次打开APP都会出现
 */
@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSMutableArray *searchArray;

@property (nonatomic, strong) NSMutableArray *searchKeyArray;

@property (nonatomic, strong) NSMutableArray *sortArray;

@property (nonatomic, strong) NSMutableArray *hotArray;

@property (nonatomic, strong) NSMutableArray *hotButtonArray;

@property (nonatomic, strong) UIButton *currentCityButton;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isSearch;

@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) UITextField *searchTextField;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *searchButton;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIView *tableHeaderView;

@property (nonatomic, strong) IndexView *indexView;

@end

@implementation GHHomeLocationViewController

- (NSMutableArray *)searchArray {
    
    if (!_searchArray) {
        _searchArray = [[NSMutableArray alloc] init];
    }
    return _searchArray;
    
}

- (NSMutableArray *)searchKeyArray {
    
    if (!_searchKeyArray) {
        _searchKeyArray = [[NSMutableArray alloc] init];
    }
    return _searchKeyArray;
    
}

- (NSMutableArray *)hotButtonArray {
    
    if (!_hotButtonArray) {
        _hotButtonArray = [[NSMutableArray alloc] init];
    }
    return _hotButtonArray;
    
}

// 热门城市有客户端写死
- (NSMutableArray *)hotArray {
    
    if (!_hotArray) {
        _hotArray = [[NSMutableArray alloc] init];
        [_hotArray addObjectsFromArray:@[@"杭州", @"宁波", @"温州", @"绍兴", @"湖州", @"嘉兴", @"金华", @"台州"]];
    }
    return _hotArray;
    
}

- (NSMutableArray *)sortArray {
    
    if (!_sortArray) {
        _sortArray = [[NSMutableArray alloc] init];
    }
    return _sortArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestData];
    
    [self setupNavigationBar];
    
    [self setupUI];
    
    [self getCurrentLocationAction];
    
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
    searchTextField.placeholder = @"请输入城市名称";
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
    
    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    searchIconImageView.contentMode = UIViewContentModeCenter;
    searchIconImageView.image = [UIImage imageNamed:@"home_search"];
    searchIconImageView.size = CGSizeMake(35, 35);
//    searchIconImageView.size = CGSizeMake(Height_NavBar - Height_StatusBar - 10, Height_NavBar - Height_StatusBar - 10);
    
    searchTextField.leftView = searchIconImageView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.height.mas_equalTo(35);
        make.centerY.mas_equalTo(navigationView);
        make.right.mas_equalTo(-60);
    }];
    [searchTextField addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    [searchTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    
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
    searchButton.hidden = true;
    self.searchButton = searchButton;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42.5, 44)];
    backBtn.backgroundColor = [UIColor whiteColor];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];
    
    self.cancelButton = backBtn;
    
//    [self addLeftButton:@selector(clickCancelAction) image:[UIImage imageNamed:@"login_back"]];

}

- (void)textFieldChange:(UITextField *)textField {
    
    [self.searchArray removeAllObjects];
    [self.searchKeyArray removeAllObjects];
    
    self.isSearch = false;
    
    self.indexView.hidden = false;

    if (textField.text.length > 0) {
        
        self.indexView.hidden = true;
        
        self.searchButton.hidden = false;
        
        self.cancelButton.hidden = true;
        
        [self hideLeftButton];
        
        self.tableView.tableHeaderView = nil;
        
        self.isSearch = true;
        
        for (NSDictionary *dic in self.dataArray) {

            NSArray *array = dic[@"value"];
            
            NSMutableArray *valueArray = [[NSMutableArray alloc] init];
            
            for (GHAreaModel *model in array) {
                
                if ([model.areaName containsString:ISNIL(textField.text)] || [model.fistPinYin hasPrefix:[ISNIL(textField.text) uppercaseString]]) {
                    [valueArray addObject:model];
                }
                
            }
            
            if (valueArray.count > 0) {
                
                [self.searchKeyArray addObject:ISNIL(dic[@"key"])];
                NSDictionary *d = @{@"key":ISNIL(dic[@"key"]), @"value":[valueArray copy]};
                [self.searchArray addObject:d];
                
            }
            
        }
        
    } else {
        
        [self.searchTextField resignFirstResponder];
        
        self.searchButton.hidden = true;
        
        self.cancelButton.hidden = false;
        
        [self addLeftButton:@selector(clickCancelAction) image:[UIImage imageNamed:@"login_back"]];
        
        self.tableView.tableHeaderView = self.tableHeaderView;
        
    }
    
    [self.indexView reloadData];
    [self.tableView reloadData];
    
    if (self.isSearch == true  && self.searchKeyArray.count > 0) {
        [self.indexView setSelectionIndex:0];
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationView.hidden = false;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    
    self.navigationView.hidden = true;
    
}

- (void)requestData {

    NSArray *array = [[GHSaveDataTool shareInstance] loadSortCityData];
    
    if (array.count > 0) {
        
        self.dataArray = array;
        
        for (NSDictionary *dic in self.dataArray) {
            [self.sortArray addObject:ISNIL(dic[@"key"])];
        }

        [self.indexView reloadData];
        [self.tableView reloadData];
        
    } else {
        
        [SVProgressHUD showWithStatus:kDefaultTipsText];
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSystemparamAreas withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            if (isSuccess) {
                
                HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
                [outputFormat setToneType:ToneTypeWithoutTone];
                [outputFormat setVCharType:VCharTypeWithV];
                [outputFormat setCaseType:CaseTypeUppercase];
                
                NSMutableArray *cityArray = [[NSMutableArray alloc] init];
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                
                NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
                
                for (NSDictionary *info in response[@"data"][@"areaList"]) {
                    
                    GHAreaModel *model = [[GHAreaModel alloc] initWithDictionary:info error:nil];
                    
                    if (model == nil) {
                        continue;
                    }
                    
                    if ([model.areaLevel integerValue] == 2) {
                        [provinceArray addObject:model];
                    } else if ([model.areaLevel integerValue] == 3) {
                        
                        if ([model.areaName isEqualToString:@"县"]) {
                            continue;
                        }
                        
                        if (model.areaName.length) {
                            
                            if ([model.areaName isEqualToString:@"市辖区"]) {
                                //                            model.areaName = provinceInfo[@"name"];
                                for (GHAreaModel *provinceModel in provinceArray) {
                                    
                                    if ([provinceModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                        model.areaName = provinceModel.areaName;
                                        break;
                                    }
                                    
                                }
                            }
                            
                            if ([model.areaName isEqualToString:@"自治区直辖县级行政区划"] || [model.areaName isEqualToString:@"省直辖县级行政区划"]) {
                                
                                for (GHAreaModel *provinceModel in provinceArray) {
                                    
                                    if ([provinceModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                        model.areaName = [NSString stringWithFormat:@"%@%@", ISNIL(provinceModel.areaName), ISNIL(model.areaName)];
                                        break;
                                    }
                                    
                                }
                                
                            }
                            
//                            if ([model.areaName hasSuffix:@"市"]) {
//                                model.areaName = [model.areaName substringToIndex:model.areaName.length - 1];
//                            }
                            
                            NSString *pinYin = [PinyinHelper toHanyuPinyinStringWithNSString:model.areaName withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];
                            
                            if (pinYin.length > 0) {
                                
                                model.fist = [pinYin substringToIndex:1];
                                
                                NSArray *pinyinArray = [pinYin componentsSeparatedByString:@" "];
                                
                                for (NSString *str in pinyinArray) {
                                    
                                    model.pinYin = [NSString stringWithFormat:@"%@%@",ISNIL(model.pinYin), ISNIL(str)];
                                    
                                    if (str.length) {
                                        model.fistPinYin = [NSString stringWithFormat:@"%@%@",ISNIL(model.fistPinYin), [str substringToIndex:1]];
                                    }
                                    
                                }
                                
                                if ([dic.allKeys containsObject:model.fist]) {
                                    
                                    NSMutableArray *array = dic[model.fist];
                                    [array addObject:model];
                                    
                                } else {
                                    
                                    NSMutableArray *array = [[NSMutableArray alloc] init];
                                    [array addObject:model];
                                    
                                    dic[model.fist] = array;
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                        
                    } else if ([model.areaLevel integerValue] == 4) {
                        break;
                    }
                    
                }
                
                
                NSArray *arr = [dic allKeys];
                arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
                    NSComparisonResult result = [obj1 compare:obj2];
                    return result==NSOrderedDescending;
                }];
                
                for (NSString *key in arr) {
                    
                    NSArray *valueArr = dic[key];
                    valueArr = [valueArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
                        NSComparisonResult result = [ISNIL(((GHAreaModel *)obj1).pinYin) compare:ISNIL(((GHAreaModel *)obj2).pinYin)];
                        return result==NSOrderedDescending;
                    }];
                    
                    NSDictionary *d = @{@"key":key,@"value":valueArr};
                    [cityArray addObject:d];
                    
                }
                
                self.dataArray = [cityArray mutableCopy];
                
                [self.sortArray removeAllObjects];
                
                for (NSDictionary *dic in self.dataArray) {
                    [self.sortArray addObject:ISNIL(dic[@"key"])];
                }
                
                
                [SVProgressHUD dismiss];
                
                [self.indexView reloadData];
                [self.tableView reloadData];
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    [[GHSaveDataTool shareInstance] saveSortCityDataWithArray:[self.dataArray copy]];
                    
                    NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
                    
                    NSMutableArray *cityArray = [[NSMutableArray alloc] init];
                    
                    NSMutableArray *areaArray = [[NSMutableArray alloc] init];
                    
                    NSInteger provinceTag = 0;
                    
                    NSInteger cityTag = 0;
                    
                    for (NSDictionary *info in response) {
                        
                        GHAreaModel *model = [[GHAreaModel alloc] initWithDictionary:info error:nil];
                        
                        if (model == nil) {
                            continue;
                        }
                        
                        if ([model.areaLevel integerValue] == 1) {
                            [[GHSaveDataTool shareInstance] saveCountryDataWithArray:@[model]];
                        } else if ([model.areaLevel integerValue] == 2) {
                            
                            [provinceArray addObject:model];
                            
                        } else if ([model.areaLevel integerValue] == 3) {
                            
                            GHAreaModel *provinceModel = [provinceArray objectOrNilAtIndex:provinceTag];
                            
                            if ([provinceModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                
                                if ([model.areaName isEqualToString:@"市辖区"]) {
                                    model.areaName = provinceModel.areaName;
                                }
                                
                                [provinceModel.children addObject:model];
                                
                            } else {
                                
                                GHAreaModel *provinceModel = [provinceArray objectOrNilAtIndex:provinceTag + 1];
                                
                                if ([provinceModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                    
                                    if ([model.areaName isEqualToString:@"市辖区"]) {
                                        model.areaName = provinceModel.areaName;
                                    }
                                    
                                    [provinceModel.children addObject:model];
                                    
                                    provinceTag = [provinceArray indexOfObject:provinceModel];
                                    
                                } else {
                                    
                                    for (GHAreaModel *provinceModel in provinceArray) {
                                        
                                        if ([provinceModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                            
                                            if ([model.areaName isEqualToString:@"市辖区"]) {
                                                model.areaName = provinceModel.areaName;
                                            }
                                            
                                            [provinceModel.children addObject:model];
                                            
                                            provinceTag = [provinceArray indexOfObject:provinceModel];
                                            
                                            break;
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                            [cityArray addObject:model];
                            
                        } else if ([model.areaLevel integerValue] == 4) {
                            
                            GHAreaModel *cityModel = [cityArray objectOrNilAtIndex:cityTag];
                            
                            if ([cityModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                
                                [cityModel.children addObject:model];
                                
                            } else {
                                
                                
                                GHAreaModel *cityModel = [cityArray objectOrNilAtIndex:provinceTag + 1];
                                
                                if ([cityModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                    
                                    [cityModel.children addObject:model];
                                    
                                    cityTag = [cityArray indexOfObject:cityModel];
                                    
                                } else {
                                    
                                    for (GHAreaModel *cityModel in cityArray) {
                                        
                                        if ([cityModel.areaCode integerValue] == [model.parentCode integerValue]) {
                                            
                                            [cityModel.children addObject:model];
                                            
                                            cityTag = [cityArray indexOfObject:cityModel];
                                            
                                            break;
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                            [areaArray addObject:model];
                            
                        }
                        
                    }
                    
                    [[GHSaveDataTool shareInstance] saveProvinceCityAreaDataWithArray:[provinceArray copy]];
                    
                });
                
            } else {
                [SVProgressHUD dismiss];
            }
            
        }];
        
    }

}

/**
 获取当前位置
 */
- (void)getCurrentLocationAction {
    
    //获取定位信息
    AMapLocationManager *mangaer = [[AMapLocationManager alloc] init];
    self.locationManager = mangaer;
    [mangaer setDelegate:self];
    
    //设置期望定位精度
    [mangaer setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //设置不允许系统暂停定位
    [mangaer setPausesLocationUpdatesAutomatically:NO];
    //设置允许在后台定位
    [mangaer setAllowsBackgroundLocationUpdates:NO];
    //设置定位超时时间
    [mangaer setLocationTimeout:3];
    //设置逆地理超时时间
    [mangaer setReGeocodeTimeout:3];
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [mangaer requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            [self.currentCityButton setTitle:@"定位失败" forState:UIControlStateNormal];
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        if (regeocode) {
            
            NSString *city;
            
            city = regeocode.city;
//            if ([regeocode.city hasSuffix:@"市"]) {
//                city = [regeocode.city substringToIndex:regeocode.city.length - 1];
//            } else {
//
//            }
            [GHUserModelTool shareInstance].locationCityArea = regeocode.district;
            self.currentCityButton.userInteractionEnabled = true;
            [self.currentCityButton setTitle:ISNIL(city) forState:UIControlStateNormal];
        }
        
    }];
    
}

- (void)setupUI {

    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];

    
//    tableView.sectionIndexTrackingBackgroundColor = kDefaultBlueColor;
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
    
    [self.view addSubview:self.indexView];
    
}

- (void)setupTableHeaderView {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 256);
    headerView.backgroundColor = kDefaultGaryViewColor;
    self.tableHeaderView = headerView;
    self.tableView.tableHeaderView = headerView;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *titleLabel1 = [[UILabel alloc] init];
    titleLabel1.textColor = kDefaultGrayTextColor;
    titleLabel1.font = H13;
    titleLabel1.text = @"当前定位城市";
    [headerView addSubview:titleLabel1];
    
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineLabel.mas_bottom).offset(17);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(16);
    }];
    
    UIButton *currentCityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    currentCityBtn.titleLabel.font = H14;
    [currentCityBtn setImage:[UIImage imageNamed:@"location_address_new"] forState:UIControlStateNormal];
    [currentCityBtn setTitleColor:kDefaultBlueColor forState:UIControlStateNormal];
    [currentCityBtn addTarget:self action:@selector(clickCurrentCityAction:) forControlEvents:UIControlEventTouchUpInside];
    [currentCityBtn setTitle:@"正在定位" forState:UIControlStateNormal];
    [currentCityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    currentCityBtn.userInteractionEnabled = false;
    [headerView addSubview:currentCityBtn];
    
    [currentCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(titleLabel1.mas_bottom).offset(0);
        make.height.mas_equalTo(43);
    }];
    self.currentCityButton = currentCityBtn;
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.textColor = kDefaultGrayTextColor;
    titleLabel2.font = H13;
    titleLabel2.text = @"热门城市";
    [headerView addSubview:titleLabel2];
    
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(currentCityBtn.mas_bottom).offset(9);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(16);
    }];
    
    for (NSInteger index = 0; index < self.hotArray.count; index++) {
        
        UIButton *hotCityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        hotCityBtn.titleLabel.font = H14;
        hotCityBtn.layer.cornerRadius = 2;
        hotCityBtn.backgroundColor = [UIColor whiteColor];
        hotCityBtn.layer.masksToBounds = true;
        [hotCityBtn setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [hotCityBtn setTitle:ISNIL([self.hotArray objectOrNilAtIndex:index]) forState:UIControlStateNormal];
        [hotCityBtn addTarget:self action:@selector(clickCityAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:hotCityBtn];
        
        [hotCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16 + ((index % 3) * ((SCREENWIDTH - 32 - 20 - 17) / 3.f + 10)));
            make.top.mas_equalTo(titleLabel2.mas_bottom).offset(10 + ((index / 3) * 50));
            make.width.mas_equalTo((SCREENWIDTH - 32 - 20 - 17) / 3.f);
            make.height.mas_equalTo(40);
        }];
        
        [self.hotButtonArray addObject:hotCityBtn];
        
    }
    
    
    
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.isSearch ? self.searchArray.count : self.dataArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isSearch == false && section == 0) {
        return 0;
    }
    
    NSArray *dataArray = self.isSearch ? self.searchArray[section][@"value"] : self.dataArray[section - 1][@"value"];
    return dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isSearch == true) {
        return 0;
    }
    if (section == 0) {
        return 0;
    }
    return 52;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.isSearch == true) {
        return nil;
    }
    if (section == 0) {
        return nil;
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kDefaultGaryViewColor;
    view.frame = CGRectMake(0, 0, SCREENWIDTH, 52);
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = H13;
    textLabel.textColor = kDefaultBlackTextColor;
    textLabel.text = self.isSearch ? [self.searchArray objectOrNilAtIndex:section][@"key"] : [self.dataArray objectOrNilAtIndex:section - 1][@"key"];
    [view addSubview:textLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-16);
        make.left.mas_equalTo(16);
    }];
    
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHLocationAreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHLocationAreaTableViewCell"];
    
    if (!cell) {
        cell = [[GHLocationAreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHLocationAreaTableViewCell"];
    }
    
    NSArray *dataArray = self.isSearch ? self.searchArray[indexPath.section][@"value"] : self.dataArray[indexPath.section - 1][@"value"];
    
    cell.isSearch = self.isSearch;
    
    cell.searchText = ISNIL(self.searchTextField.text);
    
    cell.model = [dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    [self.indexView tableView:tableView willDisplayHeaderView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    [self.indexView tableView:tableView didEndDisplayingHeaderView:view forSection:section];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.indexView scrollViewDidScroll:scrollView];
    [self.searchTextField resignFirstResponder];
}

- (NSArray<NSString *> *)sectionIndexTitles {
    NSMutableArray *sortArray = [[NSMutableArray alloc] init];
    [sortArray addObject:@"热"];
    [sortArray addObjectsFromArray:self.sortArray];
    return self.isSearch ? self.searchKeyArray : sortArray;
}

//当前选中组
- (void)selectedSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    [self.searchTextField resignFirstResponder];
    if (index == 0) {
        [self.tableView scrollToTop];
    } else {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
   
}

- (IndexView *)indexView {
    if (!_indexView) {
        _indexView = [[IndexView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 15, 0, 15, SCREENHEIGHT + kBottomSafeSpace - Height_NavBar)];
        _indexView.delegate = self;
        _indexView.dataSource = self;
        _indexView.titleColor = UIColorFromRGB(0x989898);
        _indexView.titleFontSize = 12;
        _indexView.marginRight = 0;
        _indexView.vibrationOn = true;
        _indexView.backgroundColor = [UIColor clearColor];
    }
    return _indexView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *dataArray = self.isSearch ? self.searchArray[indexPath.section][@"value"] : self.dataArray[indexPath.section - 1][@"value"];

    GHAreaModel *model = [dataArray objectOrNilAtIndex:indexPath.row];

    if ([self.delegate respondsToSelector:@selector(chooseFinishWithCity:withCode:)]) {
        [self.delegate chooseFinishWithCity:ISNIL(model.areaName) withCode:ISNIL(model.areaCode)];
        
        if (self.isSearch) {
            [self clickCancelAction];
            [self clickCancelAction];
        } else {
            [self clickCancelAction];
        }
        
    }
    
}

- (void)clickCurrentCityAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(chooseFinishWithCity:withCode:)]) {
        
        NSString *code = @"";
        
        for (NSDictionary *dic in self.dataArray) {
            
            for (GHAreaModel *model in dic[@"value"]) {
                if ([ISNIL(model.areaName) isEqualToString:sender.currentTitle]) {
                    code = model.areaCode;
                    break;
                }
            }
            
            if (code.length > 0) {
                break;
            }
            
            
        }
        
        if (sender.currentTitle.length) {
            [self.delegate chooseFinishWithCity:[NSString stringWithFormat:@"%@", ISNIL(sender.currentTitle)] withCode:ISNIL(code)];
            [self clickCancelAction];
        }
        
        
    }
    
}

- (void)clickCityAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(chooseFinishWithCity:withCode:)]) {
        
        NSString *code = @"";
        
        for (NSDictionary *dic in self.dataArray) {
            
            for (GHAreaModel *model in dic[@"value"]) {
                if ([ISNIL(model.areaName) isEqualToString:sender.currentTitle]) {
                    code = model.areaCode;
                    break;
                }
            }
            
            if (code.length > 0) {
                break;
            }
            

        }
        
        if (sender.currentTitle.length) {
            [self.delegate chooseFinishWithCity:[NSString stringWithFormat:@"%@市", ISNIL(sender.currentTitle)] withCode:ISNIL(code)];
            [self clickCancelAction];
        }
        

    }
    
}

- (void)clickCancelAction {
    
    if (self.searchButton.hidden == false) {

        self.searchButton.hidden = true;
        
        self.cancelButton.hidden = false;
        
        [self addLeftButton:@selector(clickCancelAction) image:[UIImage imageNamed:@"login_back"]];
        
        self.indexView.hidden = false;
        
        [self.searchArray removeAllObjects];
        [self.searchKeyArray removeAllObjects];

        self.isSearch = false;

        self.searchTextField.text = @"";

        [self.searchTextField resignFirstResponder];

        self.tableView.tableHeaderView = self.tableHeaderView;

        [self.indexView reloadData];
        [self.tableView reloadData];

        return;
    }
    
    [self.view endEditing:true];
    
    [self.searchTextField resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:true];
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    [self.view endEditing:true];
//
//    [self.searchTextField resignFirstResponder];
//
//}

- (void)clickSearchAction {
    
    if (self.searchTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您要搜索的内容"];
        return;
    }
    
    if ([NSString isEmpty:self.searchTextField.text] || [NSString stringContainsEmoji:self.searchTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的搜索内容"];
        return;
    }
    
    [self.searchTextField resignFirstResponder];
    
    [self.indexView reloadData];
    [self.tableView reloadData];
    
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
