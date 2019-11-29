//
//  GHAddHospitalViewController.m
//  掌上优医
//
//  Created by GH on 2019/5/30.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAddHospitalViewController.h"

#import "GHNChooseTitleView.h"

#import "GHAddHospitalView.h"


@interface GHAddHospitalViewController () <GHNChooseTitleViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) GHNChooseTitleView *titleView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) GHAddHospitalView *zhensuoView;

@property (nonatomic, strong) GHAddHospitalView *zhuankeView;

@property (nonatomic, strong) GHAddHospitalView *zongheView;


@end

@implementation GHAddHospitalViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加医院";
    
    [self setupUI];
    
}

- (void)setupUI {
    
    UILabel *topLineLabel = [[UILabel alloc] init];
    topLineLabel.backgroundColor = kDefaultLineViewColor;
    [self.view addSubview:topLineLabel];
    
    [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    NSArray *titleArray = @[@"诊所", @"专科医院", @"综合医院"];
    
    GHNChooseTitleView *titleView = [[GHNChooseTitleView alloc] initWithTitleArray:titleArray];
    titleView.delegate = self;
    [self.view addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(58);
    }];
    
    UILabel *bottomLineLabel = [[UILabel alloc] init];
    bottomLineLabel.backgroundColor = kDefaultLineViewColor;
    [self.view addSubview:bottomLineLabel];
    
    [bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(titleView.mas_bottom);
        make.height.mas_equalTo(10);
    }];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREENWIDTH * titleArray.count, SCREENHEIGHT - Height_NavBar - 78 + kBottomSafeSpace);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, 78, SCREENWIDTH, SCREENHEIGHT - Height_NavBar - 78 + kBottomSafeSpace);
    scrollView.delegate = self;
    scrollView.scrollEnabled = false;
    [self.view addSubview:scrollView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        GHAddHospitalView *addView = [[GHAddHospitalView alloc] init];
        addView.frame =  CGRectMake(SCREENWIDTH * index, 0, SCREENWIDTH, scrollView.contentSize.height);
        addView.type = index;
        [scrollView addSubview:addView];
        
        if (index == 0) {
            self.zhensuoView = addView;
        } else if (index == 1){
            self.zhuankeView = addView;
        } else if (index == 2){
            self.zongheView = addView;
        }
        
    }
    
    self.scrollView = scrollView;
    
}

- (void)clickButtonWithTag:(NSInteger)tag {
    
    [self.scrollView setContentOffset:CGPointMake(SCREENWIDTH * tag, 0) animated:NO];
    
}

@end
