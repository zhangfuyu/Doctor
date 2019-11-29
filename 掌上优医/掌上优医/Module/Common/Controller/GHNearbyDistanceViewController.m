//
//  GHNearbyDistanceViewController.m
//  掌上优医
//
//  Created by GH on 2018/10/31.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHNearbyDistanceViewController.h"
#import "GHCommonChooseTableViewCell.h"

extern NSString * const YZUpdateMenuTitleNote;

@interface GHNearbyDistanceViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GHNearbyDistanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 不限则是 10000公里
    self.titleArray = @[ @"1公里", @"3公里", @"5公里", @"10公里", @"20公里", @"不限"];
    
    [self setupUI];
    // Do any additional setup after loading the view.
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
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-15);
    }];
    
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorColor = UIColorHex(0xCCCCCC);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    
//    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//
//    // 设置某项变为选中
//    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES
//                                  scrollPosition:UITableViewScrollPositionNone];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleArray.count;
    
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
    
    GHCommonChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHCommonChooseTableViewCell"];
    
    if (!cell) {
        
        cell = [[GHCommonChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHCommonChooseTableViewCell"];
        
        cell.backgroundColor = UIColorHex(0xFFFFFF);
        cell.contentView.backgroundColor = UIColorHex(0xFFFFFF);
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        

        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        [selectedBackgroundView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(0);
        }];
        
        cell.selectedBackgroundView = selectedBackgroundView;
        
    }

    cell.lineLabel.hidden = false;
    cell.titleLabel.text = ISNIL([self.titleArray objectOrNilAtIndex:indexPath.row]);
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(chooseFinishNearby:)]) {
        [self.delegate chooseFinishNearby:ISNIL([self.titleArray objectOrNilAtIndex:indexPath.row])];
    }
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    
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
