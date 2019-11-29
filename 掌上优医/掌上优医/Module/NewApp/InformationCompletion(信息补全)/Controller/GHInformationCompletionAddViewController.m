//
//  GHInformationCompletionAddViewController.m
//  掌上优医
//
//  Created by GH on 2019/6/5.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHInformationCompletionAddViewController.h"
#import "GHHospitalInformationCompletionSubmitView.h"

@interface GHInformationCompletionAddViewController ()<GHHospitalInformationCompletionSubmitViewDelegate>

@property (nonatomic, strong) GHHospitalInformationCompletionSubmitView *subView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *otherContentView;

@end

@implementation GHInformationCompletionAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"信息补全";
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = false;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [self.view addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(.5);
    }];
    
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    self.contentView = contentView;
    
    UIView *otherContentView = [[UIView alloc] init];
    otherContentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:otherContentView];
    
    [otherContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];
    self.otherContentView = otherContentView;
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(otherContentView.mas_bottom).offset(10);
    }];
    
    
    GHHospitalInformationCompletionSubmitView *view = [[GHHospitalInformationCompletionSubmitView alloc] init];
    view.model = self.model;
    view.delegate = self;
    [self.otherContentView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    self.subView = view;
    
    [self.otherContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(view.contentHeight);
    }];
    
}


- (void)updateSubmitViewWithHeight:(CGFloat)height {
    
    [self.otherContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
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
