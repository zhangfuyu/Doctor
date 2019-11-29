//
//  GHNewSearchTableView.m
//  掌上优医
//
//  Created by apple on 2019/8/2.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewSearchTableView.h"

@interface GHNewSearchTableView ()<UITableViewDelegate , UITableViewDataSource>

@end

@implementation GHNewSearchTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tableHeaderView = [UIView new];
        self.tableFooterView = [UIView new];
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return self;
}

#pragma mark -- delegate
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.thinkData.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier0 = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
        cell.textLabel.font = H15;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSRange range = [self.thinkData[indexPath.row] rangeOfString:self.searchText];
    NSMutableAttributedString *strin = [[NSMutableAttributedString alloc] initWithString:self.thinkData[indexPath.row]];
    [strin addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:range];
    cell.textLabel.attributedText = strin;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickResultBlock) {
        self.clickResultBlock(self.thinkData[indexPath.row]);
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;

}
- (void)setThinkData:(NSMutableArray *)thinkData
{
    _thinkData = thinkData;
    [self reloadData];
}

@end
