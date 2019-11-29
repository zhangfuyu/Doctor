//
//  GHProvinceCityAreaViewController.m
//  掌上优医
//
//  Created by GH on 2018/10/26.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHProvinceCityAreaViewController.h"
#import "GHAreaTool.h"

#import "GHCommonChooseTableViewCell.h"
#import "PinYin4Objc.h"

extern NSString * const YZUpdateMenuTitleNote;

@interface GHProvinceCityAreaViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *provinceArray;

@property (nonatomic, strong) NSArray *cityArray;

@property (nonatomic, strong) NSArray *areaArray;

@property (nonatomic, strong) GHAreaModel *countryModel;

@property (nonatomic, strong) GHAreaModel *provinceModel;

@property (nonatomic, strong) GHAreaModel *cityModel;

@property (nonatomic, strong) GHAreaModel *areaModel;

@property (nonatomic, strong) UITableView *provinceTableView;

@property (nonatomic, strong) UITableView *cityTableView;

@property (nonatomic, strong) UITableView *areaTableView;

/**
 全市按钮
 */
@property (nonatomic, strong) UIButton *allAreaButton;

/**
 全省按钮
 */
@property (nonatomic, strong) UIButton *allCityButton;

/**
 全国按钮
 */
@property (nonatomic, strong) UIButton *allProvinceButton;


@property (nonatomic, strong) UIView *provinceHeaderView;

@property (nonatomic, strong) UIView *cityHeaderView;

@property (nonatomic, strong) UIView *areaHeaderView;


@property (nonatomic, strong) NSIndexPath *firstIndexPath;
@property (nonatomic, strong) NSIndexPath *secondIndexPath;

@end

@implementation GHProvinceCityAreaViewController

- (UIView *)areaHeaderView {
    
    if (!_areaHeaderView) {
        
        _areaHeaderView = [[UIView alloc] init];
        _areaHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH / 3.f, 45);
        _areaHeaderView.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = H14;
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [_areaHeaderView addSubview:button];
        
            [button setTitle:@"全市" forState:UIControlStateNormal];
            button.tag = 3;
            self.allAreaButton = button;
        
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        
        [button addTarget:self action:@selector(clickAllAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _areaHeaderView;
    
}

- (UIView *)cityHeaderView {
    
    if (!_cityHeaderView) {
        
        _cityHeaderView = [[UIView alloc] init];
        _cityHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH / 3.f, 45);
        _cityHeaderView.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = H14;
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [_cityHeaderView addSubview:button];
        
        [button setTitle:@"全省" forState:UIControlStateNormal];
        button.tag = 2;
        self.allCityButton = button;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        
        [button addTarget:self action:@selector(clickAllAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cityHeaderView;
    
}

- (UIView *)provinceHeaderView {
    
    if (!_provinceHeaderView) {
        
        _provinceHeaderView = [[UIView alloc] init];
        _provinceHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH / 3.f, 45);
        _provinceHeaderView.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = H14;
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [_provinceHeaderView addSubview:button];
        
        [button setTitle:@"全国" forState:UIControlStateNormal];
        button.tag = 1;
        self.allProvinceButton = button;
        _provinceHeaderView.backgroundColor = UIColorHex(0xF6F4F4);
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = UIColorHex(0xCCCCCC);
        [_provinceHeaderView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        
        [button addTarget:self action:@selector(clickAllAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _provinceHeaderView;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.provinceHeaderView.hidden = false;
    self.cityHeaderView.hidden = false;
    self.areaHeaderView.hidden = false;
    
    [self setupUI];
    
//    [self getData];
    
    // Do any additional setup after loading the view.
}

- (void)getData {
    
    NSArray *array = [[GHSaveDataTool shareInstance] loadProvinceCityAreaData];
    
    if (array.count > 0) {
        
        self.countryModel = [[[GHSaveDataTool shareInstance] loadCountryData] objectOrNilAtIndex:0];
  
        self.provinceArray = [array copy];
        self.provinceModel = [self.provinceArray firstObject];
        self.cityArray = [self.provinceModel.children copy];
        self.cityModel = ((GHAreaModel *)[self.cityArray firstObject]);
        self.areaArray = [self.cityModel.children copy];
        self.areaModel = ((GHAreaModel *)[self.areaArray firstObject]);
        
        [self.provinceTableView reloadData];
        [self.cityTableView reloadData];
        [self.areaTableView reloadData];
        
        [self tableView:self.provinceTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        // 设置某项变为选中
        [self.provinceTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES
                                      scrollPosition:UITableViewScrollPositionNone];
        
        [self getLocationData];
        
    } else {
        
        
        [SVProgressHUD showWithStatus:kDefaultTipsText];
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSystemparamAreas withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            if (isSuccess) {
                
                
                NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
                
                NSMutableArray *cityArray = [[NSMutableArray alloc] init];
                
                NSMutableArray *areaArray = [[NSMutableArray alloc] init];
                
                NSInteger provinceTag = 0;
                
                NSInteger cityTag = 0;
                
                for (NSDictionary *info in response[@"data"][@"areaList"]) {
                    
                    GHAreaModel *model = [[GHAreaModel alloc] initWithDictionary:info error:nil];
                    
                    if (model == nil) {
                        continue;
                    }
                    
                    if ([model.areaLevel integerValue] == 1) {
                        self.countryModel = model;
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
                
                self.provinceArray = [provinceArray copy];
                self.provinceModel = [self.provinceArray firstObject];
                self.cityArray = [self.provinceModel.children copy];
                self.cityModel = ((GHAreaModel *)[self.cityArray firstObject]);
                self.areaArray = [self.cityModel.children copy];
                self.areaModel = ((GHAreaModel *)[self.areaArray firstObject]);
                
                [self.provinceTableView reloadData];
                [self.cityTableView reloadData];
                [self.areaTableView reloadData];
                
 
                
                [self tableView:self.provinceTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                
                // 设置某项变为选中
                [self.provinceTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES
                                              scrollPosition:UITableViewScrollPositionNone];
                
                [SVProgressHUD dismiss];
                
                [self getLocationData];
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    [[GHSaveDataTool shareInstance] saveProvinceCityAreaDataWithArray:[provinceArray copy]];
                    
                    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
                    [outputFormat setToneType:ToneTypeWithoutTone];
                    [outputFormat setVCharType:VCharTypeWithV];
                    [outputFormat setCaseType:CaseTypeUppercase];
                    
                    NSMutableArray *cityArray = [[NSMutableArray alloc] init];
                    
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    
                    NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
                    
                    for (NSDictionary *info in response) {
                        
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
                                
//                                if ([model.areaName hasSuffix:@"市"]) {
//                                    model.areaName = [model.areaName substringToIndex:model.areaName.length - 1];
//                                }
                                
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
                    
                    [[GHSaveDataTool shareInstance] saveSortCityDataWithArray:[cityArray copy]];
                    
                });
                
            } else {
                [SVProgressHUD dismiss];
            }
            
        }];
        
    }
    
}

- (void)setDelegate:(id<GHProvinceCityAreaViewControllerDelegate>)delegate {
    
    _delegate = delegate;
    
    [self getData];
    
}

/**
 获取定位数据
 */
- (void)getLocationData {
    
    if ([GHUserModelTool shareInstance].locationCityArea.length > 0) {
        
        GHAreaModel *provinceModel;
        GHAreaModel *cityModel;
        GHAreaModel *areaModel;
        
        for (GHAreaModel *pModel in self.provinceArray) {
            
            for (GHAreaModel *cModel in pModel.children) {
                
                if ([cModel.areaName isEqualToString:[GHUserModelTool shareInstance].locationCity]) {
                    
                    provinceModel = pModel;
                    cityModel = cModel;
                    
                    for (GHAreaModel *aModel in cModel.children) {
                        
                        if ([aModel.areaName isEqualToString:[GHUserModelTool shareInstance].locationCityArea]) {
                            areaModel = aModel;
                            break;
                        }
                        
                    }
                    
                    break;
                    
                }
                
            }
            
            if (cityModel) {
                break;
            }
            
        }
        
        if (provinceModel && cityModel && areaModel) {
            // 定位的区
            [self.delegate chooseFinishWithCountryModel:self.countryModel provinceModel:provinceModel cityModel:cityModel areaModel:areaModel areaLevel:4];
        } else {
             [self.delegate chooseFinishWithCountryModel:self.countryModel provinceModel:nil cityModel:nil areaModel:nil areaLevel:1];
        }
        

    } else if ([GHUserModelTool shareInstance].locationCity.length > 0) {
        // 定位的市
        
        GHAreaModel *provinceModel;
        GHAreaModel *cityModel;
        
        for (GHAreaModel *pModel in self.provinceArray) {
            
            for (GHAreaModel *cModel in pModel.children) {
                
                if ([cModel.areaName isEqualToString:[GHUserModelTool shareInstance].locationCity]) {
                    
                    provinceModel = pModel;
                    cityModel = cModel;
                    
                    break;
                    
                }
                
            }
            
            if (cityModel) {
                break;
            }
            
        }
        
        if (provinceModel && cityModel) {
            [self.delegate chooseFinishWithCountryModel:self.countryModel provinceModel:provinceModel cityModel:cityModel areaModel:nil areaLevel:3];
            
            
            [self tableView:self.provinceTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.provinceArray indexOfObject:provinceModel] inSection:0]];
            
            // 设置某项变为选中
            [self.provinceTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.provinceArray indexOfObject:provinceModel] inSection:0] animated:YES
                                          scrollPosition:UITableViewScrollPositionNone];
            

            
            
            [self tableView:self.cityTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.cityArray indexOfObject:cityModel] inSection:0]];
            
            // 设置某项变为选中
            [self.cityTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.cityArray indexOfObject:cityModel] inSection:0] animated:YES
                                          scrollPosition:UITableViewScrollPositionNone];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.provinceTableView scrollToRow:[self.provinceArray indexOfObject:provinceModel] inSection:0 atScrollPosition:UITableViewScrollPositionTop animated:false];
                [self.cityTableView scrollToRow:[self.cityArray indexOfObject:cityModel] inSection:0 atScrollPosition:UITableViewScrollPositionTop animated:false];
                [self.areaTableView scrollToTopAnimated:false];
            });

            
        } else {
             [self.delegate chooseFinishWithCountryModel:self.countryModel provinceModel:nil cityModel:nil areaModel:nil areaLevel:1];
        }
        

    } else {
        // 定位的国家
        [self.delegate chooseFinishWithCountryModel:self.countryModel provinceModel:nil cityModel:nil areaModel:nil areaLevel:1];
    }
    
}

- (void)setupUI {
    
    for (NSInteger index = 0; index < 3; index++) {
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        
        [self.view addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((SCREENWIDTH / 3.f) * index);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(SCREENWIDTH / 3.f);
        }];
        
        if (index == 0) {
            tableView.backgroundColor = UIColorHex(0xF6F4F4);
//            tableView.separatorColor = UIColorHex(0xCCCCCC);
//            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            self.provinceTableView = tableView;
        } else if (index == 1) {
            self.cityTableView = tableView;
        } else if (index == 2) {
            self.areaTableView = tableView;
        }
        
    }
    

    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.provinceTableView) {
        return self.provinceArray.count;
    } else if (tableView == self.cityTableView) {
        return self.cityArray.count;
    } else if (tableView == self.areaTableView) {
        return self.areaArray.count;
    }
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 45;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.provinceTableView) {
        
        return self.provinceHeaderView;
        
    } else if (tableView == self.cityTableView) {
        
        return self.cityHeaderView;
        
    } else if (tableView == self.areaTableView) {
        
        return self.areaHeaderView;
        
    }
    
    return nil;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.provinceTableView) {
        
        
        GHCommonChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        if (!cell) {
            
            cell = [[GHCommonChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            
            cell.backgroundColor = UIColorHex(0xF6F4F4);
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
            cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            
            
        }
        
        GHAreaModel *model;
        
        model = [self.provinceArray objectOrNilAtIndex:indexPath.row];
    
        cell.titleLabel.text = model.areaName;
        
        
        return cell;
        
        
    } else {
     
        GHCommonChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
        
        if (!cell) {
            
            cell = [[GHCommonChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell1"];
            
            cell.backgroundColor = UIColorHex(0xFFFFFF);
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
            cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            
        }
        
        GHAreaModel *model;
        
        if (tableView == self.cityTableView) {
            model = [self.cityArray objectOrNilAtIndex:indexPath.row];
        } else if (tableView == self.areaTableView) {
            model = [self.areaArray objectOrNilAtIndex:indexPath.row];
        }
        
        cell.titleLabel.text = model.areaName;
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.provinceTableView) {
        
        self.provinceModel = [self.provinceArray objectOrNilAtIndex:indexPath.row];
        
        self.cityArray = self.provinceModel.children;
        [self.cityTableView reloadData];
        
        if (self.cityArray.count) {
            
            // 设置某项变为选中
            [self.cityTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES
                                      scrollPosition:UITableViewScrollPositionNone];
            
            
            [self tableView:self.cityTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [self.cityTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
            

        }

 
    } else if (tableView == self.cityTableView) {
        
        self.cityModel = ((GHAreaModel *)[self.cityArray objectOrNilAtIndex:indexPath.row]);
        
        self.areaArray = self.cityModel.children;
        [self.areaTableView reloadData];
        
        if (self.areaArray.count) {
            
            if ([ISNIL(self.cityModel.areaName) hasSuffix:@"市"]) {
                [self.allAreaButton setTitle:[NSString stringWithFormat:@"%@全城", [ISNIL(self.cityModel.areaName) substringToIndex:ISNIL(self.cityModel.areaName).length - 1]] forState:UIControlStateNormal];
            } else {
                [self.allAreaButton setTitle:[NSString stringWithFormat:@"%@全城", ISNIL(self.cityModel.areaName)] forState:UIControlStateNormal];
            }
            
            
            
            [self.areaTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
            
        }
        
    } else if (tableView == self.areaTableView) {
        
        self.areaModel = [self.areaArray objectOrNilAtIndex:indexPath.row];

        NSLog(@"%@-%@-%@", self.provinceModel.areaName, self.cityModel.areaName, self.areaModel.areaName);
        
        if ([self.delegate respondsToSelector:@selector(chooseFinishWithCountryModel:provinceModel:cityModel:areaModel:areaLevel:)]) {
            [self.delegate chooseFinishWithCountryModel:self.countryModel provinceModel:self.provinceModel cityModel:self.cityModel areaModel:self.areaModel areaLevel:4];
        }
        
    }
    
}

- (void)clickAllAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(chooseFinishWithCountryModel:provinceModel:cityModel:areaModel:areaLevel:)]) {
        
        if (sender.tag == 1) {
            // 全国
            [self.delegate chooseFinishWithCountryModel:self.countryModel provinceModel:nil cityModel:nil areaModel:nil areaLevel:1];
        } else if (sender.tag == 2) {
            // 全省
            [self.delegate chooseFinishWithCountryModel:self.countryModel provinceModel:self.provinceModel cityModel:nil areaModel:nil areaLevel:2];
        } else if (sender.tag == 3) {
            // 全市
            [self.delegate chooseFinishWithCountryModel:self.countryModel provinceModel:self.provinceModel cityModel:self.cityModel areaModel:nil areaLevel:3];
        }
        
    }
    

    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.provinceTableView) {
        
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
        
    }
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
