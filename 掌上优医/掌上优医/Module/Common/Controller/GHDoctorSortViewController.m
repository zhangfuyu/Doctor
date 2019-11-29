//
//  GHDoctorSortViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHDoctorSortViewController.h"
#import "GHNCommonChooseTableViewCell.h"

@interface GHDoctorSortViewController () <UITableViewDelegate, UITableViewDataSource>

/**
 <#Description#>
 */
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation GHDoctorSortViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    GHNCommonChooseModel *model1 = [[GHNCommonChooseModel alloc] init];
    
    if (self.isDefaultSortType) {
        model1.title = @"默认排序";
    } else {
        model1.title = @"综合排序";
    }
    
    
    model1.isCheck = false;
    
//    GHNCommonChooseModel *model2 = [[GHNCommonChooseModel alloc] init];
//    model2.title = @"评分最高";
//    model2.isCheck = false;
//
//    GHNCommonChooseModel *model3 = [[GHNCommonChooseModel alloc] init];
//    model3.title = @"离我最近";
//    model3.isCheck = false;
//
////    [self.dataArray addObject:model1];
//    [self.dataArray addObject:model2];
//    [self.dataArray addObject:model3];
    
    [self setIsAllCountry:NO];
    [self setupUI];

    
}
- (void)setIsAllCountry:(BOOL)isAllCountry
{
    _isAllCountry = isAllCountry;
    [self.dataArray removeAllObjects];
    
    GHNCommonChooseModel *model2 = [[GHNCommonChooseModel alloc] init];
    model2.title = @"评分最高";
    model2.isCheck = false;
    
    GHNCommonChooseModel *model3 = [[GHNCommonChooseModel alloc] init];
    model3.title = @"离我最近";
    model3.isCheck = false;
    
    
    if (isAllCountry) {
        [self.dataArray addObject:model2];
        
    }
    else
    {
        [self.dataArray addObject:model2];
        [self.dataArray addObject:model3];
        
    }
    
    [self.tableView reloadData];
}
- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
    
}

/**
 
 @param tableView tableView description
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHNCommonChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNCommonChooseTableViewCell"];
    
    if (!cell) {
        
        cell = [[GHNCommonChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNCommonChooseTableViewCell"];
        
    }
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (GHNCommonChooseModel *model in self.dataArray) {
        model.isCheck = false;
    }
    
    GHNCommonChooseModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    model.isCheck = true;
    
    [self.tableView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(chooseFinishDoctorSortWithSort:)]) {
        [self.delegate chooseFinishDoctorSortWithSort:ISNIL(model.title)];
        
        if ([model.title isEqualToString:@"默认排序"]) {
            [MobClick event:@"Sort_Doctor" label:@"医生默认排序"];
        } else if ([model.title isEqualToString:@"综合排序"]) {
            [MobClick event:@"Sort_Doctor" label:@"医生综合排序"];
        } else if ([model.title isEqualToString:@"评分最高"]) {
            [MobClick event:@"Sort_Doctor" label:@"医生评分排序"];
        } else if ([model.title isEqualToString:@"离我最近"]) {
            [MobClick event:@"Sort_Doctor" label:@"医生距离排序"];
        }
        
    }
    
}



@end
