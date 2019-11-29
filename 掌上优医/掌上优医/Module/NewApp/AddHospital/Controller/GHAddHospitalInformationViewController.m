//
//  GHAddHospitalInformationViewController.m
//  掌上优医
//
//  Created by GH on 2019/6/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAddHospitalInformationViewController.h"
#import "GHAddHospitalInformationTableViewCell.h"

@interface GHAddHospitalInformationViewController () <UITableViewDelegate, UITableViewDataSource, GHAddHospitalInformationTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GHAddHospitalInformationViewController

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"医院咨讯";
    
    [self addRightButton:@selector(clickSaveAction) title:@"保存"];
    
    [self setupUI];
    
    if (self.dataArray.count == 0) {
        GHHospitalInformationModel *model = [[GHHospitalInformationModel alloc] init];
        [self.dataArray addObject:model];
        
        [self.tableView reloadData];
    }
    
}

- (void)clickSaveAction {
    
    if ([self.delegate respondsToSelector:@selector(finishSaveHospitalInformationWithArray:)]) {
        
        BOOL isCanSave = true;
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for (NSInteger index = 0; index < self.dataArray.count; index++) {
            
            GHAddHospitalInformationTableViewCell *cell = (GHAddHospitalInformationTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            
            [cell syncModel];
            
            if (cell.model.title.length == 0) {

                continue;
                
            }
            
            [array addObject:cell.model];

        }

        if (array.count == 0) {
            
            [SVProgressHUD showErrorWithStatus:@"请添加您想添加的医院资讯"];
            
            return;
            
        }
        
        for (GHHospitalInformationModel *model in array) {
            
            if (model.title.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入资讯标题"];
                isCanSave = false;
                break;
            }
            
            if (model.h5url.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入链接地址"];
                isCanSave = false;
                break;
            }
            
        }
        
        if (isCanSave == true) {
            
            [self.delegate finishSaveHospitalInformationWithArray:[array copy]];
            
            [self.navigationController popViewControllerAnimated:true];
            
        }
        
    }
    
}

- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.backgroundColor = kDefaultGaryViewColor;
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
    
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 328;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHAddHospitalInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"GHAddHospitalInformationTableViewCell_%ld", indexPath.row]];
    
    if (!cell) {
        
        cell = [[GHAddHospitalInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"GHAddHospitalInformationTableViewCell_%ld", indexPath.row]];
        
        cell.delegate = self;
        
    }
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    cell.index = indexPath.row;
    
    return cell;
    
}

- (void)clickDeleteWithTag:(NSInteger)tag {
    
    for (NSInteger index = 0; index < self.dataArray.count; index++) {
        
        GHAddHospitalInformationTableViewCell *cell = (GHAddHospitalInformationTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        
        [cell syncModel];
        
    }
    
    [self.dataArray removeObjectAtIndex:tag];
    
    if (self.dataArray.count == 0) {
        [self clickAddHospitalInformationAction];
    }
    
    [self.tableView reloadData];
    
}

- (void)clickAddHospitalInformationAction {
    
    GHHospitalInformationModel *model = [[GHHospitalInformationModel alloc] init];
    [self.dataArray addObject:model];
    
    [self.tableView reloadData];
    
}

@end
