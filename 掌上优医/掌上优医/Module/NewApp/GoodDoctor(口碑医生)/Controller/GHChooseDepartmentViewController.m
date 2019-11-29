//
//  GHChooseDepartmentViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/24.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHChooseDepartmentViewController.h"

#import "GHDepartmentFirstTableViewCell.h"

#import "GHDepartmentSecondTableViewCell.h"

#import "GHDepartmentModel.h"

#import "GHNewDepartMentModel.h"

@interface GHChooseDepartmentViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *departmentFirstTableView;

@property (nonatomic, strong) UITableView *departmentSecondTableView;

@property (nonatomic, strong) NSMutableArray *departmentFirstArray;

@property (nonatomic, strong) NSMutableArray *departmentSecondArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSString *parentId;

@property (nonatomic, assign) NSUInteger firstTag;

@property (nonatomic, assign) NSUInteger secondTag;

@property (nonatomic, strong) GHNewDepartMentModel *firstModel;

@end

@implementation GHChooseDepartmentViewController

- (NSMutableArray *)departmentFirstArray {
    
    if (!_departmentFirstArray) {
        _departmentFirstArray = [[NSMutableArray alloc] init];
    }
    return _departmentFirstArray;
    
}

- (NSMutableArray *)departmentSecondArray {
    
    if (!_departmentSecondArray) {
        _departmentSecondArray = [[NSMutableArray alloc] init];
    }
    return _departmentSecondArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"出诊科室";
    
    [self setupUI];
    // Do any additional setup after loading the view.
    
    [self getDataAction];
}

- (void)getDataAction {
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSystemparamDepartments withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            
            for (NSDictionary *info in response[@"data"][@"departmentList"]) {
                
                GHNewDepartMentModel *model = [[GHNewDepartMentModel alloc]initWithDictionary:(NSDictionary *)info[@"firstDepartment"] error:nil];
                
                NSArray *secondDepartmentList = info[@"secondDepartmentList"];
                
                for (NSInteger index = 0; index < secondDepartmentList.count; index ++) {
                    
                    NSDictionary *secondDic = [secondDepartmentList objectAtIndex:index];
                    
                    GHNewDepartMentModel *second = [[GHNewDepartMentModel alloc]initWithDictionary:secondDic error:nil];
                    [model.secondDepartmentList addObject:second];
                }
                
                [self.departmentFirstArray addObject:model];
                
            }
            
            
            
            
//            if (self.departmentArray.count == 0) {
//                [self loadingEmptyView];
//            }else{
//                [self hideEmptyView];
//            }
//
//            [SVProgressHUD dismiss];
//
//            NSMutableArray *firstDepartmentArray = [[NSMutableArray alloc] init];
//
//            NSInteger firstDepartmentTag = 0;
//
//            for (NSDictionary *info in response) {
//
//                GHDepartmentModel *model = [[GHDepartmentModel alloc] initWithDictionary:info error:nil];
//
//                if ([model.departmentLevel integerValue] == 1) {
//                    [firstDepartmentArray addObject:model];
//                } else if ([model.departmentLevel integerValue] == 2) {
//
//                    GHDepartmentModel *firstModel = [firstDepartmentArray objectOrNilAtIndex:firstDepartmentTag];
//
//                    if ([firstModel.modelId longValue] == [model.parentId longValue]) {
//
//                        [firstModel.children addObject:model];
//
//                    } else {
//
//                        GHDepartmentModel *firstModel = [firstDepartmentArray objectOrNilAtIndex:firstDepartmentTag + 1];
//
//                        if ([firstModel.modelId longValue] == [model.parentId longValue]) {
//
//                            [firstModel.children addObject:model];
//
//                            firstDepartmentTag = [firstDepartmentArray indexOfObject:firstModel];
//
//                        } else {
//
//                            for (GHDepartmentModel *firstModel in firstDepartmentArray) {
//
//                                if ([firstModel.modelId longValue] == [model.parentId longValue]) {
//
//                                    [firstModel.children addObject:model];
//
//                                    firstDepartmentTag = [firstDepartmentArray indexOfObject:firstModel];
//
//                                    break;
//
//                                }
//
//                            }
//
//                        }
//
//                    }
//
//                    if ([model.modelId integerValue] == [self.departmentId integerValue]) {
//
//                        self.firstTag = firstDepartmentTag;
//
//                        self.secondTag = [firstModel.children indexOfObject:model];
//
//                        model.isOpen = @(true);
//
//                    }
//
//                }
//
//            }
//
//            self.departmentFirstArray = [firstDepartmentArray mutableCopy];
            
            [self.departmentFirstTableView reloadData];
            
            [self tableView:self.departmentFirstTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:self.firstTag inSection:0]];
            
            [self.departmentFirstTableView scrollToRow:self.firstTag inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
            
            [self.departmentSecondTableView scrollToRow:self.secondTag inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
            
        }
        
    }];
    
}


- (void)setupUI {
    
    UITableView *departmentFirstTableView = [[UITableView alloc] init];
    departmentFirstTableView.delegate = self;
    departmentFirstTableView.dataSource = self;
    departmentFirstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    departmentFirstTableView.backgroundColor = kDefaultGaryViewColor;
    [self.view addSubview:departmentFirstTableView];
    
    [departmentFirstTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREENWIDTH / 2.f);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.departmentFirstTableView = departmentFirstTableView;
    
    
    UITableView *departmentSecondTableView = [[UITableView alloc] init];
    departmentSecondTableView.delegate = self;
    departmentSecondTableView.dataSource = self;
    departmentSecondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    departmentSecondTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:departmentSecondTableView];
    
    [departmentSecondTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(SCREENWIDTH / 2.f);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.departmentSecondTableView = departmentSecondTableView;
    
    UILabel *lineLabel1 = [[UILabel alloc] init];
    lineLabel1.backgroundColor = kDefaultGaryViewColor;
    [self.view addSubview:lineLabel1];
    
    [lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = UIColorHex(0xEFEFEF);
    [self.view addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
        make.left.mas_equalTo(SCREENWIDTH / 2.f - 0.5);
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.departmentFirstTableView) {
        return self.departmentFirstArray.count;
    } else {
        return self.departmentSecondArray.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.departmentFirstTableView) {

        GHDepartmentFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHDepartmentFirstTableViewCell"];
        
        if (!cell) {
            cell = [[GHDepartmentFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHDepartmentFirstTableViewCell"];
        }
        
        GHNewDepartMentModel *model = [self.departmentFirstArray objectOrNilAtIndex:indexPath.row];
        
        if ([model.isOpen integerValue] == true) {
            cell.contentView.backgroundColor = [UIColor whiteColor];
        } else {
            cell.contentView.backgroundColor = kDefaultGaryViewColor;
        }
        
        cell.titleLabel.text = ISNIL(model.departmentName);
        
        return cell;
        
    } else {
        
        GHDepartmentSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHDepartmentSecondTableViewCell"];
        
        if (!cell) {
            cell = [[GHDepartmentSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHDepartmentSecondTableViewCell"];
        }
        
        GHNewDepartMentModel *model = [self.departmentSecondArray objectOrNilAtIndex:indexPath.row];
        
        if ([model.isOpen integerValue] == true) {
            cell.titleLabel.textColor = kDefaultBlueColor;
            cell.contentView.backgroundColor = kDefaultGaryViewColor;
        } else {
            cell.titleLabel.textColor = kDefaultBlackTextColor;
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        cell.titleLabel.text = ISNIL(model.departmentName);
        
        return cell;

    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.departmentFirstTableView) {
        
        for (NSInteger index = 0; index < self.departmentFirstArray.count; index++) {
            
            GHNewDepartMentModel *model = [self.departmentFirstArray objectOrNilAtIndex:index];
            
            if (index == indexPath.row) {
                model.isOpen = @(true);
                self.departmentSecondArray = model.secondDepartmentList;
                continue;
            }
            
            model.isOpen = @(false);
            
        }
        
        self.firstModel = [self.departmentFirstArray objectOrNilAtIndex:indexPath.row];
        
        [self.departmentFirstTableView reloadData];
        [self.departmentSecondTableView reloadData];
        
    } else {
        
        if ([self.delegate respondsToSelector:@selector(chooseDepartmentWithSecondName:withSecondId:withFirstName:withFirstId:)]) {
            
            GHNewDepartMentModel *secondModel = [self.departmentSecondArray objectOrNilAtIndex:indexPath.row];
            
            [self.delegate chooseDepartmentWithSecondName:secondModel.departmentName withSecondId:secondModel.modelid withFirstName:self.firstModel.departmentName withFirstId:self.firstModel.modelid];
            
        }
        
        [self.navigationController popViewControllerAnimated:true];
        
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
