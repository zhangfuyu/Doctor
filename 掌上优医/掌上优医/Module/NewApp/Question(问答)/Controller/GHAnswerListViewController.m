//
//  GHAnswerListViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAnswerListViewController.h"

#import "GHAnswerTableViewCell.h"
#import "GHReplyTableViewCell.h"

#import "GHAnswerHeaderView.h"

#import "GHReplyListView.h"

#import "GHTextView.h"

#import "GHQuestionModel.h"

#import <IQKeyboardManager.h>

@interface GHAnswerListViewController ()<UITableViewDelegate, UITableViewDataSource, GHAnswerTableViewCellDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSUInteger totalPage;

@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) GHAnswerHeaderView *headerView;

@property (nonatomic, strong) GHReplyListView *replyListView;


@property (nonatomic, strong) UIView *textBgView;

@property (nonatomic, strong) GHTextView *textView;

@property (nonatomic, strong) UILabel *textViewCountLabel;

@property (nonatomic, strong) UIView *maskView;


@property (nonatomic, assign) BOOL isAnswerQuestion;

@property (nonatomic, strong) NSString *currentReplyAnswerId;

@property (nonatomic, strong) NSString *placeHolder;

@end

@implementation GHAnswerListViewController

- (UIView *)maskView {
    
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = RGBACOLOR(51, 51, 51, 0.2);
        [self.view addSubview:_maskView];
        
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    
    return _maskView;
    
}

- (UIView *)textBgView {
    
    if (!_textBgView) {
        
        _textBgView = [[UIView alloc] init];
        _textBgView.frame = CGRectMake(0, SCREENHEIGHT + 10, SCREENWIDTH, 163);
        _textBgView.backgroundColor = [UIColor whiteColor];
        _textBgView.layer.cornerRadius = 8;
        _textBgView.layer.masksToBounds = true;
        [self.view addSubview:_textBgView];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.titleLabel.font = H15;
        [cancelButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_textBgView addSubview:cancelButton];
        
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
            make.width.mas_equalTo(65);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
        }];
        [cancelButton addTarget:self action:@selector(clickTextBgCancelAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmButton.titleLabel.font = H15;
        [confirmButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [confirmButton setTitle:@"发布" forState:UIControlStateNormal];
        [_textBgView addSubview:confirmButton];
        
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
            make.width.mas_equalTo(65);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        [confirmButton addTarget:self action:@selector(clickTextBgConfirmAction) forControlEvents:UIControlEventTouchUpInside];
        
        GHTextView *answerTextView = [[GHTextView alloc] initWithFrame:CGRectMake(16, 45, SCREENWIDTH - 32, 80)];
        answerTextView.font = H15;
        answerTextView.textColor = kDefaultBlackTextColor;
        answerTextView.backgroundColor = kDefaultGaryViewColor;
        answerTextView.bounces = false;
        answerTextView.placeholderColor = UIColorHex(0xcccccc);
        answerTextView.layer.cornerRadius = 4;
        answerTextView.layer.masksToBounds = true;
        answerTextView.returnKeyType = UIReturnKeyDone;
        answerTextView.delegate = self;
        [_textBgView addSubview:answerTextView];
        
        self.textView = answerTextView;
        
    }
    return _textBgView;
    
}

- (void)clickTextBgCancelAction {
    
    self.textBgView.hidden = true;
    
}

- (void)clickTextBgConfirmAction {
    
    [self.textView resignFirstResponder];
    
    [self clickSubmitAction];
    
}

- (GHReplyListView *)replyListView {
    
    if (!_replyListView) {
        _replyListView = [[GHReplyListView alloc] init];
        [self.view addSubview:_replyListView];
        
        [_replyListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _replyListView;
    
}

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"问答";
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    [self setupUI];
    
    self.maskView.hidden = true;
    
  
    
    [self addRightButton:@selector(clickAnswerAction) title:@"回答"];
    
}



- (void)setupConfig {
    self.currentPage = 1;
    self.totalPage = 1;
    self.pageSize = 10;
}

- (void)refreshData{
    self.currentPage = 1;
    self.totalPage = 1;
    [self requsetData];
}

- (void)getMoreData{
    self.currentPage += self.pageSize;
    [self requsetData];
}

- (void)requsetData {
    
    if (self.currentPage > self.totalPage) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"pageSize"] = @(self.pageSize);
    params[@"page"] = @(self.currentPage);
    params[@"id"] = self.model.modelId;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiCirclePostidDiscuss withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            if (self.currentPage == 1) {
                
                [self.dataArray removeAllObjects];
                
            }
            
            for (NSDictionary *dicInfo in response[@"data"][@"answerList"]) {
                
                GHAnswerModel *model = [[GHAnswerModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                model.contentHeight = [NSNumber numberWithFloat:[model.content getShouldHeightWithContent:model.content withFont:H15 withWidth:SCREENWIDTH - 32  withLineHeight:21]];
                
                [self.dataArray addObject:model];
                
                NSArray *replyList = dicInfo[@"replyList"];
                if (replyList.count > 0) {
                    for (NSDictionary *againDic in replyList) {
                        GHReplyModel *againModle = [[GHReplyModel alloc]initWithDictionary:againDic error:nil];
                        againModle.contentHeight = [NSNumber numberWithFloat:[model.content getShouldHeightWithContent:model.content withFont:H13 withWidth:SCREENWIDTH - 32 - 20  withLineHeight:18]];
                        [model.replyArray addObject:againModle];
                    }
                }
                
                
//                if ([model.replyCount integerValue] > 0) {
//                    // 回复数大于 0, 则获取回复
//                    [self getReplyDataWithModelId:model];
//                }
                
            }
            
            if (((NSArray *)response[@"data"][@"answerList"]).count >0) {
            } else {
                self.currentPage --;
            }
            
            [self.tableView reloadData];
            
//            if (self.dataArray.count == 0) {
//                [self loadingEmptyView];
//            }else{
//                [self hideEmptyView];
//            }
            
        }
        
    }];
    
}

- (void)getReplyDataWithModelId:(GHAnswerModel *)answerModel {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"pageSize"] = @(3);
    params[@"from"] = @(0);
    params[@"discussId"] = answerModel.modelId;
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiCircleDiscussidReply withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_JSON completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
       
        if (isSuccess) {
            
            [answerModel.replyArray removeAllObjects];
            
            for (NSDictionary *dic in response) {
                
                GHReplyModel *model = [[GHReplyModel alloc] initWithDictionary:dic error:nil];
                
                if (model == nil) {
                    continue;
                }
                
                if ([model.authorId longValue] == [[GHUserModelTool shareInstance].userInfoModel.modelId longValue]) {
                    // 是我回复的
                    model.isMeReply = @(true);
                    
                    model.showContent = [NSString stringWithFormat:@"我: %@", ISNIL(model.content)];
                    
                } else {
                    
                    model.isMeReply = @(false);
                    
                    model.showContent = [NSString stringWithFormat:@"%@: %@", ISNIL(model.authorName), ISNIL(model.content)];
                }
                
                model.contentHeight = [NSNumber numberWithFloat:[model.showContent getShouldHeightWithContent:model.content withFont:H13 withWidth:SCREENWIDTH - 32 - 20  withLineHeight:18]];
                
                [answerModel.replyArray addObject:model];
                
                [self.tableView reloadData];
                
            }
            
        }
        
    }];
    
    
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
    
    tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    [self setupTableHeaderView];
    
}

- (void)setupTableHeaderView {
 
    GHAnswerHeaderView *headerView = [[GHAnswerHeaderView alloc] init];
    
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 175 - 18 + [self.model.content getShouldHeightWithContent:self.model.content withFont:H13 withWidth:SCREENWIDTH - 78  withLineHeight:18]);
    
    headerView.model = self.model;
    
    self.headerView = headerView;
    self.tableView.tableHeaderView = headerView;
    
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHAnswerModel *answerModel = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    if (answerModel.replyArray.count == 0) {
        
        return [answerModel.contentHeight floatValue] + 81 + 55;
        
    } else {
        
        CGFloat shouldHeight = [answerModel.contentHeight floatValue] + 81 + 55 + 10 + 20 - 8;
        
        for (GHReplyModel *replyModel in answerModel.replyArray) {
            
            shouldHeight += ([replyModel.contentHeight floatValue] + 8);
            
        }
        
        if ([answerModel.replyCount integerValue] > 3) {
            
            shouldHeight += (12 + 18 + 10);
            
        }
        
        return shouldHeight;
        
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHAnswerTableViewCell"];
    
    if (!cell) {
        
        cell = [[GHAnswerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHAnswerTableViewCell"];
        
        cell.delegate = self;
        
    }
    
    cell.model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHAnswerModel *model = [self.dataArray objectOrNilAtIndex:indexPath.row];
    
    self.replyListView.model = model;
    
    self.replyListView.hidden = false;
    
}

- (void)clickReplyAnswerActionWithAnswerModel:(GHAnswerModel *)model {
    
    if ([GHUserModelTool shareInstance].isLogin) {

        NSLog(@"点击了回复回答");
        
        self.maskView.hidden = false;
        self.textBgView.hidden = false;
        self.placeHolder = [NSString stringWithFormat:@"回复%@", ISNIL(model.authorName)];
        self.textView.placeholder = self.placeHolder;
        [self.textView becomeFirstResponder];
        
        self.isAnswerQuestion = false;
        self.currentReplyAnswerId = model.modelId;
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }

    
}

- (void)clickAnswerAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        
        NSLog(@"点击了回答问题");
        
        self.maskView.hidden = false;
        self.textBgView.hidden = false;
        self.placeHolder = @"回答问题";
        self.textView.placeholder = self.placeHolder;
        [self.textView becomeFirstResponder];
        
        self.isAnswerQuestion = true;
        self.currentReplyAnswerId = nil;
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = false;
    
    [self addObservers];
    
    [self setupConfig];
    [self requsetData];
    
}

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *)notification
{
    
    NSLog(@"%@", notification);
    
    NSDictionary *info=[notification userInfo];
    
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat time = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:time animations:^{
       
        self.textBgView.mj_y = kbRect.origin.y - self.textBgView.height + 10;
        
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.maskView.hidden = true;
    
    self.textBgView.hidden = true;
    
    self.textBgView.mj_y = SCREENHEIGHT + 10;
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];

    [IQKeyboardManager sharedManager].enableAutoToolbar = true;
    
    [self removeObservers];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self clickSubmitAction];
        return NO;//这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (((GHTextView *)textView).hasText) { // textView.text.length
        ((GHTextView *)textView).placeholder = @"";
    } else {
        ((GHTextView *)textView).placeholder = ISNIL(self.placeHolder);
    }
    
}
// This is
- (void)clickSubmitAction {
    
    if (self.textView.text.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入您要回复的内容"];
        return;
        
    }
    
    if ([NSString isEmpty:self.textView.text] || [NSString stringContainsEmoji:self.textView.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的回复的内容,请勿输入特殊字符"];
        return;
    }
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
//    params[@"authorId"] = [GHUserModelTool shareInstance].userInfoModel.modelId;
//    params[@"authorName"] = ISNIL([GHUserModelTool shareInstance].userInfoModel.nickName).length ? [GHUserModelTool shareInstance].userInfoModel.nickName : ISNIL([GHUserModelTool shareInstance].userInfoModel.showPhoneNum);
//    params[@"authorProfileUrl"] = [GHUserModelTool shareInstance].userInfoModel.profilePhoto.length ? [GHUserModelTool shareInstance].userInfoModel.profilePhoto : nil;
    
    params[@"content"] = self.textView.text;
    
//    params[@"postId"] = self.model.modelId;
    
    NSString *url;
    
    if (self.isAnswerQuestion) {
        params[@"problemId"] = self.model.modelId;
        // 回答问题
        url = kApiCircleDiscuss;
        
        
    } else {
        // 回复回答
        url = kApiCircleReply;
        
        params[@"answerId"] = self.currentReplyAnswerId;
       
    }
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:url withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
       
        if (isSuccess) {
            
            self.textView.text = @"";
            
            if (self.isAnswerQuestion) {
                
                [SVProgressHUD showSuccessWithStatus:@"回答成功,感谢您的回答!"];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDoctorQuestionSuccess object:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self refreshData];
                });
                
            } else {
                
                [SVProgressHUD showSuccessWithStatus:@"回复成功,感谢您的回复!"];
                
                [self refreshData];
                
            }
            
            
            
        }
        
    }];
    
    
}


@end
