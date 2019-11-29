//
//  GHNSearchListViewController.m
//  掌上优医
//
//  Created by GH on 2019/2/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNSearchListViewController.h"

#import "GHNChooseTitleView.h"

#import "GHDocterDetailViewController.h"
#import "GHInformationDetailViewController.h"

#import "GHHospitalDetailViewController.h"

#import "GHArticleInformationModel.h"
#import "GHSearchHospitalModel.h"

#import "GHNSearchSicknessTableViewCell.h"
#import "GHNSearchDoctorTableViewCell.h"
#import "GHNSearchHospitalTableViewCell.h"
#import "GHNSearchInformationTableViewCell.h"

#import "GHProvinceCityAreaViewController.h"
#import "GHDoctorSortViewController.h"
#import "GHHospitalSortViewController.h"

#import "GHDoctorFilterViewController.h"
#import "GHHospitalFilterViewController.h"

#import "UIButton+touch.h"

#import "GHNDiseaseDetailViewController.h"

@interface GHNSearchListViewController ()<GHNChooseTitleViewDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, GHProvinceCityAreaViewControllerDelegate, GHDoctorSortViewControllerDelegate, GHHospitalSortViewControllerDelegate, GHDoctorFilterViewControllerDelegate, GHHospitalFilterViewControllerDelegate>

@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) UITextField *searchTextField;

@property (nonatomic, strong) GHNChooseTitleView *titleView;

@property (nonatomic, strong) NSMutableArray *tableViewArray;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) NSMutableArray *sicknessArray;
@property (nonatomic, assign) NSUInteger sicknessCurrentPage;
@property (nonatomic, assign) NSUInteger sicknessTotalPage;
@property (nonatomic, strong) UITableView *sicknessTableView;

@property (nonatomic, strong) NSMutableArray *doctorArray;
@property (nonatomic, assign) NSUInteger doctorCurrentPage;
@property (nonatomic, assign) NSUInteger doctorTotalPage;
@property (nonatomic, strong) UITableView *doctorTableView;

@property (nonatomic, strong) NSMutableArray *hospitalArray;
@property (nonatomic, assign) NSUInteger hospitalCurrentPage;
@property (nonatomic, assign) NSUInteger hospitalTotalPage;
@property (nonatomic, strong) UITableView *hospitalTableView;

@property (nonatomic, strong) NSMutableArray *informationArray;
@property (nonatomic, assign) NSUInteger informationCurrentPage;
@property (nonatomic, assign) NSUInteger informationTotalPage;
@property (nonatomic, strong) UITableView *informationTableView;

@property (nonatomic, strong) UIView *sicknessEmptyView;
@property (nonatomic, strong) UIView *doctorEmptyView;
@property (nonatomic, strong) UIView *hospitalEmptyView;
@property (nonatomic, strong) UIView *informationEmptyView;


@property (nonatomic, strong) UIView *doctorHeaderView;
@property (nonatomic, strong) UIView *hospitalHeaderView;
@property (nonatomic, strong) UIView *informationHeaderView;

@property (nonatomic, strong) UIButton *doctorLocationButton;
@property (nonatomic, strong) UIButton *doctorSortButton;
@property (nonatomic, strong) UIButton *doctorFilterButton;
@property (nonatomic, strong) UIView *doctorLocationView;
@property (nonatomic, strong) UIView *doctorSortView;
@property (nonatomic, strong) UIView *doctorFilterView;
@property (nonatomic, strong) UIViewController *doctorLocationContentViewController;
@property (nonatomic, strong) UIViewController *doctorSortContentViewController;
@property (nonatomic, strong) UIViewController *doctorFilterContentViewController;
@property (nonatomic, strong) NSString *doctorAreaId;
@property (nonatomic, assign) NSUInteger doctorAreaLevel;

@property (nonatomic, strong) NSString *doctorGrade;
@property (nonatomic, strong) NSString *doctorType;
@property (nonatomic, strong) NSString *doctorHospitalLevel;

@property (nonatomic, strong) UIButton *hospitalLocationButton;
@property (nonatomic, strong) UIButton *hospitalSortButton;
@property (nonatomic, strong) UIButton *hospitalFilterButton;
@property (nonatomic, strong) UIView *hospitalLocationView;
@property (nonatomic, strong) UIView *hospitalSortView;
@property (nonatomic, strong) UIView *hospitalFilterView;
@property (nonatomic, strong) UIViewController *hospitalLocationContentViewController;
@property (nonatomic, strong) UIViewController *hospitalSortContentViewController;
@property (nonatomic, strong) UIViewController *hospitalFilterContentViewController;
@property (nonatomic, strong) NSString *hospitalAreaId;
@property (nonatomic, assign) NSUInteger hospitalAreaLevel;

@property (nonatomic, strong) NSString *hospitalType;
@property (nonatomic, strong) NSString *hospitalGrade;

@property (nonatomic, strong) UIButton *informationSortButton;
@property (nonatomic, strong) UIView *informationSortView;

@property (nonatomic, strong) NSString *informationSort;

@property (nonatomic, strong) GHLocationStatusView *doctorLocationStatusView;

@property (nonatomic, strong) GHLocationStatusView *hospitalLocationStatusView;

@end

@implementation GHNSearchListViewController

- (GHLocationStatusView *)doctorLocationStatusView {
    
    if (!_doctorLocationStatusView) {
        _doctorLocationStatusView = [[GHLocationStatusView alloc] init];
        _doctorLocationStatusView.frame = CGRectMake(SCREENWIDTH * 1, SCREENHEIGHT - (53 - kBottomSafeSpace) - Height_NavBar - 44, SCREENWIDTH, 53 - kBottomSafeSpace);
        [self.scrollView addSubview:_doctorLocationStatusView];
        
//        [_doctorLocationStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(SCREENWIDTH);
//            make.left.mas_equalTo(SCREENWIDTH * 1);
//            make.bottom.mas_equalTo(0);
//            make.height.mas_equalTo(53 - kBottomSafeSpace);
//        }];
    }
    return _doctorLocationStatusView;
    
}

- (GHLocationStatusView *)hospitalLocationStatusView {
    
    if (!_hospitalLocationStatusView) {
        _hospitalLocationStatusView = [[GHLocationStatusView alloc] init];
        _hospitalLocationStatusView.frame = CGRectMake(SCREENWIDTH * 2, SCREENHEIGHT - (53 - kBottomSafeSpace) - Height_NavBar - 44, SCREENWIDTH, 53 - kBottomSafeSpace);
        [self.scrollView addSubview:_hospitalLocationStatusView];
        
//        [_hospitalLocationStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(SCREENWIDTH);
//            make.left.mas_equalTo(SCREENWIDTH * 2);
//            make.bottom.mas_equalTo(0);
//            make.height.mas_equalTo(53 - kBottomSafeSpace);
//        }];
    }
    return _hospitalLocationStatusView;
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.doctorLocationStatusView.hidden = [GHUserModelTool shareInstance].isHaveLocation;
    self.hospitalLocationStatusView.hidden = [GHUserModelTool shareInstance].isHaveLocation;
    
}

- (UIView *)informationHeaderView {
    
    if (!_informationHeaderView) {
        
        _informationHeaderView = [[UIView alloc] init];
        _informationHeaderView.backgroundColor = kDefaultGaryViewColor;
        _informationHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH, 52);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.titleLabel.font = H14;
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
        button.isIgnore = true;
        [button setTitle:@"排序" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"search_sort_down_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"search_sort_up_icon"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(clicklInformationSortAction:) forControlEvents:UIControlEventTouchUpInside];
        button.transform = CGAffineTransformMakeScale(-1, 1);
        button.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
        button.imageView.transform = CGAffineTransformMakeScale(-1, 1);
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
        [_informationHeaderView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(120);
        }];
        self.informationSortButton = button;
        
    }
    return _informationHeaderView;
    
}



- (UIView *)hospitalHeaderView {
    
    if (!_hospitalHeaderView) {
        
        _hospitalHeaderView = [[UIView alloc] init];
        _hospitalHeaderView.backgroundColor = [UIColor whiteColor];
        _hospitalHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH, 44);
        
        for (NSInteger index = 0; index < 3; index++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.titleLabel.font = H14;
            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
            [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
            button.isIgnore = true;
            
            if (index == 0) {
                [button setTitle:@"当前位置" forState:UIControlStateNormal];
                
                [button setImage:[UIImage imageNamed:@"search_sort_down_icon"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_sort_up_icon"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(clickHospitalLocationAction:) forControlEvents:UIControlEventTouchUpInside];
                self.hospitalLocationButton = button;
            } else if (index == 1) {
                [button setTitle:@"默认排序" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_sort_down_icon"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_sort_up_icon"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(clickHospitalSortAction:) forControlEvents:UIControlEventTouchUpInside];
                self.hospitalSortButton = button;
            } else if (index == 2) {
                [button setTitle:@"筛选" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_filter_icon"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(clickHospitalFilterAction:) forControlEvents:UIControlEventTouchUpInside];
                self.hospitalFilterButton = button;
            }
            
            button.transform = CGAffineTransformMakeScale(-1, 1);
            button.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
            button.imageView.transform = CGAffineTransformMakeScale(-1, 1);
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
            [button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -8)];
            
            [_hospitalHeaderView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.left.mas_equalTo(index * (SCREENWIDTH / 3.f));
                make.width.mas_equalTo(SCREENWIDTH / 3.f);
            }];
            
        }
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        [_hospitalHeaderView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *lineLabel2 = [[UILabel alloc] init];
        lineLabel2.backgroundColor = kDefaultLineViewColor;
        [_hospitalHeaderView addSubview:lineLabel2];
        
        [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREENWIDTH / 3.f);
            make.top.mas_equalTo(8);
            make.bottom.mas_equalTo(-8);
            make.width.mas_equalTo(1);
        }];
        
        UILabel *lineLabel3 = [[UILabel alloc] init];
        lineLabel3.backgroundColor = kDefaultLineViewColor;
        [_hospitalHeaderView addSubview:lineLabel3];
        
        [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREENWIDTH / 3.f * 2);
            make.top.mas_equalTo(8);
            make.bottom.mas_equalTo(-8);
            make.width.mas_equalTo(1);
        }];
    }
    
    return _hospitalHeaderView;
    
    
}

- (UIView *)doctorHeaderView {
    
    if (!_doctorHeaderView) {
        
        _doctorHeaderView = [[UIView alloc] init];
        _doctorHeaderView.backgroundColor = [UIColor whiteColor];
        _doctorHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH, 44);
        
        for (NSInteger index = 0; index < 3; index++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.titleLabel.font = H14;
            [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
            [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
            button.isIgnore = true;
            
            if (index == 0) {
                [button setTitle:@"当前位置" forState:UIControlStateNormal];
                
                [button setImage:[UIImage imageNamed:@"search_sort_down_icon"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_sort_up_icon"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(clickDoctorLocationAction:) forControlEvents:UIControlEventTouchUpInside];
                self.doctorLocationButton = button;
            } else if (index == 1) {
                [button setTitle:@"默认排序" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_sort_down_icon"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_sort_up_icon"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(clickDoctorSortAction:) forControlEvents:UIControlEventTouchUpInside];
                self.doctorSortButton = button;
            } else if (index == 2) {
                [button setTitle:@"筛选" forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"search_filter_icon"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(clickDoctorFilterAction:) forControlEvents:UIControlEventTouchUpInside];
                self.doctorFilterButton = button;
            }
            
            button.transform = CGAffineTransformMakeScale(-1, 1);
            button.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
            button.imageView.transform = CGAffineTransformMakeScale(-1, 1);
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
            [button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -8)];
            
            [_doctorHeaderView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.left.mas_equalTo(index * (SCREENWIDTH / 3.f));
                make.width.mas_equalTo(SCREENWIDTH / 3.f);
            }];
            
        }
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = kDefaultLineViewColor;
        [_doctorHeaderView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *lineLabel2 = [[UILabel alloc] init];
        lineLabel2.backgroundColor = kDefaultLineViewColor;
        [_doctorHeaderView addSubview:lineLabel2];
        
        [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREENWIDTH / 3.f);
            make.top.mas_equalTo(8);
            make.bottom.mas_equalTo(-8);
            make.width.mas_equalTo(1);
        }];
        
        UILabel *lineLabel3 = [[UILabel alloc] init];
        lineLabel3.backgroundColor = kDefaultLineViewColor;
        [_doctorHeaderView addSubview:lineLabel3];
        
        [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREENWIDTH / 3.f * 2);
            make.top.mas_equalTo(8);
            make.bottom.mas_equalTo(-8);
            make.width.mas_equalTo(1);
        }];
    }
    
    return _doctorHeaderView;
    
}

- (UIView *)informationSortView {
    
    if (!_informationSortView) {
        
        _informationSortView = [[UIView alloc] init];
        _informationSortView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _informationSortView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        [self.view addSubview:_informationSortView];
        
        UIView *popView = [[UIView alloc] init];
        popView.backgroundColor = [UIColor clearColor];
        popView.layer.masksToBounds = true;
        [_informationSortView addSubview:popView];
        
        [popView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(110);
            make.height.mas_equalTo(140);
            make.top.mas_equalTo(90);
            make.right.mas_equalTo(-30);
        }];
        
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.contentMode = UIViewContentModeScaleToFill;
        bgImageView.userInteractionEnabled = true;
        bgImageView.image = [UIImage imageNamed:@"doctorMoreBg"];
        [popView addSubview:bgImageView];
        
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        
        NSArray *titleArray = @[@"默认", @"浏览次数", @"收藏次数"];
        for (NSInteger index = 0; index < titleArray.count; index++) {
            
            UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
            actionButton.tag = index;
            [popView addSubview:actionButton];
            
            [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(40);
                make.top.mas_equalTo(index * 40 + 12);
            }];
            
            UILabel *lineLabel = [[UILabel alloc] init];
            lineLabel.backgroundColor = kDefaultGaryViewColor;
            [popView addSubview:lineLabel];
            
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(actionButton);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(1);
            }];
            
            if (index == 2) {
                lineLabel.hidden = true;
            }
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.font = H14;
            titleLabel.textColor = kDefaultBlackTextColor;
            titleLabel.text = ISNIL([titleArray objectOrNilAtIndex:index]);
            [popView addSubview:titleLabel];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(actionButton);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
            }];
            
            [actionButton addTarget:self action:@selector(clickInformationAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        UITapGestureRecognizer *noneTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOtherAction)];
        [popView addGestureRecognizer:noneTapGR];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [_informationSortView addGestureRecognizer:tapGR];
        
    }
    
    return _informationSortView;
    
}

- (void)clickOtherAction {
    
}

- (void)clickInformationAction:(UIButton *)sender {
    
    if (sender.tag == 1) {
        self.informationSort = @"浏览次数";
        [MobClick event:@"Sort_News" label:@"资讯浏览次数排序"];
    } else if (sender.tag == 2) {
        self.informationSort = @"收藏次数";
        [MobClick event:@"Sort_News" label:@"资讯收藏次数排序"];
    } else {
        self.informationSort = @"默认";
        [MobClick event:@"Sort_News" label:@"资讯默认排序"];
    }
    
    [self clickNoneView];
    
    [self refreshData];
    
}

- (UIView *)doctorLocationView {
    
    if (!_doctorLocationView) {
        _doctorLocationView = [[UIView alloc] init];
        _doctorLocationView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _doctorLocationView.frame = CGRectMake(0, 88, SCREENWIDTH, SCREENHEIGHT - 41 - Height_NavBar);
        [self.view addSubview:_doctorLocationView];
        
        GHProvinceCityAreaViewController *vc = [[GHProvinceCityAreaViewController alloc] init];
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, 338);
        vc.delegate = self;
        [_doctorLocationView addSubview:vc.view];
        
        self.doctorLocationContentViewController = vc;
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [_doctorLocationView addSubview:tapView];
        
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(vc.view.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [tapView addGestureRecognizer:tapGR];
    }
    
    return _doctorLocationView;
    
}

- (UIView *)hospitalLocationView {
    
    if (!_hospitalLocationView) {
        _hospitalLocationView = [[UIView alloc] init];
        _hospitalLocationView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _hospitalLocationView.frame = CGRectMake(0, 88, SCREENWIDTH, SCREENHEIGHT - 41 - Height_NavBar);
        [self.view addSubview:_hospitalLocationView];
        
        GHProvinceCityAreaViewController *vc = [[GHProvinceCityAreaViewController alloc] init];
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, 338);
        vc.delegate = self;
        [_hospitalLocationView addSubview:vc.view];
        
        self.hospitalLocationContentViewController = vc;
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [_hospitalLocationView addSubview:tapView];
        
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(vc.view.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [tapView addGestureRecognizer:tapGR];
    }
    
    return _hospitalLocationView;
    
}

- (UIView *)doctorSortView {
    
    if (!_doctorSortView) {
        _doctorSortView = [[UIView alloc] init];
        _doctorSortView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _doctorSortView.frame = CGRectMake(0, 88, SCREENWIDTH, SCREENHEIGHT - 41 - Height_NavBar);
        [self.view addSubview:_doctorSortView];
        
        GHDoctorSortViewController *vc = [[GHDoctorSortViewController alloc] init];
        vc.isDefaultSortType = true;
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, 90);
        
        vc.delegate = self;
        [_doctorSortView addSubview:vc.view];
        
        self.doctorSortContentViewController = vc;
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [_doctorSortView addSubview:tapView];
        
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(vc.view.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [tapView addGestureRecognizer:tapGR];
    }
    
    return _doctorSortView;
    
}

- (UIView *)hospitalSortView {
    
    if (!_hospitalSortView) {
        _hospitalSortView = [[UIView alloc] init];
        _hospitalSortView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _hospitalSortView.frame = CGRectMake(0, 88, SCREENWIDTH, SCREENHEIGHT - 41 - Height_NavBar);
        [self.view addSubview:_hospitalSortView];
        
        GHHospitalSortViewController *vc = [[GHHospitalSortViewController alloc] init];
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, 180);
        vc.delegate = self;
        [_hospitalSortView addSubview:vc.view];
        
        self.hospitalSortContentViewController = vc;
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [_hospitalSortView addSubview:tapView];
        
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(vc.view.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [tapView addGestureRecognizer:tapGR];
    }
    
    return _hospitalSortView;
    
}

- (UIView *)doctorFilterView {
    
    if (!_doctorFilterView) {
        _doctorFilterView = [[UIView alloc] init];
        _doctorFilterView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _doctorFilterView.frame = CGRectMake(0, 88, SCREENWIDTH, SCREENHEIGHT - 41 - Height_NavBar);
        [self.view addSubview:_doctorFilterView];
        
        GHDoctorFilterViewController *vc = [[GHDoctorFilterViewController alloc] init];
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, 368);
        vc.delegate = self;
        [_doctorFilterView addSubview:vc.view];
        
        self.doctorFilterContentViewController = vc;
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [_doctorFilterView addSubview:tapView];
        
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(vc.view.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [tapView addGestureRecognizer:tapGR];
    }
    
    return _doctorFilterView;
    
}

- (UIView *)hospitalFilterView {
    
    if (!_hospitalFilterView) {
        _hospitalFilterView = [[UIView alloc] init];
        _hospitalFilterView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _hospitalFilterView.frame = CGRectMake(0, 88, SCREENWIDTH, SCREENHEIGHT - 41 - Height_NavBar);
        [self.view addSubview:_hospitalFilterView];
        
        GHHospitalFilterViewController *vc = [[GHHospitalFilterViewController alloc] init];
        vc.view.frame = CGRectMake(0, 0, SCREENWIDTH, 328);
        vc.delegate = self;
        [_hospitalFilterView addSubview:vc.view];
        
        self.hospitalFilterContentViewController = vc;
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        [_hospitalFilterView addSubview:tapView];
        
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(vc.view.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoneView)];
        [tapView addGestureRecognizer:tapGR];
    }
    
    return _hospitalFilterView;
    
}

//- (void)chooseFinishDoctorFilter:(NSString *)filter {
//
//    self.doctorGrade = filter;
//
//    [self clickNoneView];
//
//    [self refreshData];
//
//}

- (void)chooseFinishDoctorPosition:(NSString *)position doctorType:(NSString *)doctorType hospitalLevel:(NSString *)hospitalLevel {
    
    self.doctorGrade = position;
    self.doctorType = doctorType;
    self.doctorHospitalLevel = hospitalLevel;
    
    [self clickNoneView];
    
    [self refreshData];
    
}

- (void)chooseFinishHospitalType:(NSString *)type level:(NSString *)level {
    
    self.hospitalType = type;
    
    self.hospitalGrade = level;
    
    [self clickNoneView];
    
    [self refreshData];
    
}

- (void)chooseFinishDoctorSortWithSort:(NSString *)sort {
    
    [self.doctorSortButton setTitle:ISNIL(sort) forState:UIControlStateNormal];
    
    [self clickNoneView];
    
    [self refreshData];
    
}

- (void)chooseFinishHospitalSortWithSort:(NSString *)sort {
    
    [self.hospitalSortButton setTitle:ISNIL(sort) forState:UIControlStateNormal];
    
    [self clickNoneView];
    
    [self refreshData];
    
}

- (void)clicklInformationSortAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
    }
    
    self.informationSortView.hidden = !sender.selected;
    
}

- (void)clickDoctorLocationAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
    }
    
    self.doctorLocationView.hidden = !sender.selected;
    
}

- (void)clickDoctorSortAction:(UIButton *)sender {
 
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
    }
    
    self.doctorSortView.hidden = !sender.selected;
    
}

- (void)clickDoctorFilterAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
    }
    
    self.doctorFilterView.hidden = !sender.selected;
    
}

- (void)clickHospitalLocationAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
    }
    
    self.hospitalLocationView.hidden = !sender.selected;
    
}

- (void)clickHospitalSortAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
    }
    
    self.hospitalSortView.hidden = !sender.selected;
    
}

- (void)clickHospitalFilterAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
    }
    
    self.hospitalFilterView.hidden = !sender.selected;
    
}

- (void)clickInformationSortAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
    }
    
    self.informationSortView.hidden = !sender.selected;
    
}


- (void)clickNoneView {
    
    self.doctorLocationView.hidden = true;
    self.doctorLocationButton.selected = false;
    
    self.doctorSortView.hidden = true;
    self.doctorSortButton.selected = false;
    
    self.doctorFilterView.hidden = true;
    self.doctorFilterButton.selected = false;
    
    self.hospitalLocationView.hidden = true;
    self.hospitalLocationButton.selected = false;
    
    self.hospitalSortView.hidden = true;
    self.hospitalSortButton.selected = false;
    
    self.hospitalFilterView.hidden = true;
    self.hospitalFilterButton.selected = false;
    
    self.informationSortView.hidden = true;
    self.informationSortButton.selected = false;
    
//    [self.searchTextField resignFirstResponder];
    [self.searchTextField resignFirstResponder];
    
}


- (UIView *)sicknessEmptyView{
    
    if (!_sicknessEmptyView) {
        _sicknessEmptyView = [[UIView alloc] init];
        _sicknessEmptyView.userInteractionEnabled = NO;
        _sicknessEmptyView.frame = CGRectMake(SCREENWIDTH * 0, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_sicknessEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_search"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_sicknessEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无搜索结果";
        [_sicknessEmptyView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
            make.height.mas_equalTo(60);
        }];
        
        _sicknessEmptyView.hidden = YES;
        _sicknessEmptyView.userInteractionEnabled = false;
    }
    return _sicknessEmptyView;
    
}

- (UIView *)doctorEmptyView{
    
    if (!_doctorEmptyView) {
        _doctorEmptyView = [[UIView alloc] init];
        _doctorEmptyView.userInteractionEnabled = NO;
        _doctorEmptyView.frame = CGRectMake(SCREENWIDTH * 1, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_doctorEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_search"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_doctorEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无搜索结果";
        [_doctorEmptyView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
            make.height.mas_equalTo(60);
        }];
        
        _doctorEmptyView.hidden = YES;
        _doctorEmptyView.userInteractionEnabled = false;
    }
    return _doctorEmptyView;
    
}

- (UIView *)hospitalEmptyView{
    
    if (!_hospitalEmptyView) {
        _hospitalEmptyView = [[UIView alloc] init];
        _hospitalEmptyView.userInteractionEnabled = NO;
        _hospitalEmptyView.frame = CGRectMake(SCREENWIDTH * 2, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_hospitalEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_search"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_hospitalEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无搜索结果";
        [_hospitalEmptyView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
            make.height.mas_equalTo(60);
        }];
        
        _hospitalEmptyView.hidden = YES;
        _hospitalEmptyView.userInteractionEnabled = false;
    }
    return _hospitalEmptyView;
    
}

- (UIView *)informationEmptyView{
    
    if (!_informationEmptyView) {
        _informationEmptyView = [[UIView alloc] init];
        _informationEmptyView.userInteractionEnabled = NO;
        _informationEmptyView.frame = CGRectMake(SCREENWIDTH * 3, 90, SCREENWIDTH, self.scrollView.contentSize.height);
        [self.scrollView addSubview:_informationEmptyView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_search"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_informationEmptyView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.centerX.mas_equalTo(imageView.superview);
            make.size.mas_equalTo(CGSizeMake(300, 110));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无搜索结果";
        [_informationEmptyView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
            make.height.mas_equalTo(60);
        }];
        
        _informationEmptyView.hidden = YES;
        _informationEmptyView.userInteractionEnabled = false;
    }
    return _informationEmptyView;
    
}

- (NSMutableArray *)sicknessArray {
    
    if (!_sicknessArray) {
        _sicknessArray = [[NSMutableArray alloc] init];
    }
    return _sicknessArray;
    
}

- (NSMutableArray *)doctorArray {
    
    if (!_doctorArray) {
        _doctorArray = [[NSMutableArray alloc] init];
    }
    return _doctorArray;
    
}

- (NSMutableArray *)hospitalArray {
    
    if (!_hospitalArray) {
        _hospitalArray = [[NSMutableArray alloc] init];
    }
    return _hospitalArray;
    
}

- (NSMutableArray *)informationArray {
    
    if (!_informationArray) {
        _informationArray = [[NSMutableArray alloc] init];
    }
    return _informationArray;
    
}

- (NSMutableArray *)tableViewArray {
    
    if (!_tableViewArray) {
        _tableViewArray = [[NSMutableArray alloc] init];
    }
    return _tableViewArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupConfig];
    
    [self setupNavigationBar];
    
    [self setupUI];
    
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidAppear:) name:kNotificationWillEnterForeground object:nil];
    
}

- (void)setupConfig{
    
    self.pageSize = 10;
    self.sicknessTotalPage = 1;
    self.doctorTotalPage = 1;
    self.hospitalTotalPage = 1;
    self.informationTotalPage = 1;
    self.sicknessCurrentPage = 0;
    self.doctorCurrentPage = 0;
    self.hospitalCurrentPage = 0;
    self.informationCurrentPage = 0;
    
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    NSArray *titleArray = @[@"疾病", @"医生", @"医院", @"资讯"];
    
    GHNChooseTitleView *titleView = [[GHNChooseTitleView alloc] initWithTitleArray:titleArray];
    titleView.delegate = self;
    [self.view addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREENWIDTH * titleArray.count, SCREENHEIGHT - Height_NavBar - 44 + kBottomSafeSpace);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - Height_NavBar - 44 + kBottomSafeSpace);
    scrollView.delegate = self;
    scrollView.scrollEnabled = false;
    [self.view addSubview:scrollView];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tag = index;
        tableView.backgroundColor = kDefaultGaryViewColor;
        tableView.frame = CGRectMake(SCREENWIDTH * index, 0, SCREENWIDTH, scrollView.contentSize.height);
        
        [scrollView addSubview:tableView];
        
        [self.tableViewArray addObject:tableView];
        
        if (index == 0) {
            self.sicknessTableView = tableView;
        } else if (index == 1) {
            self.doctorTableView = tableView;
        } else if (index == 2){
            self.hospitalTableView = tableView;
        } else if (index == 3){
            self.informationTableView = tableView;
        }
        
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
        
    }
    
    self.scrollView = scrollView;
    
    self.doctorHeaderView.hidden = false;
    self.hospitalHeaderView.hidden = false;
    self.informationHeaderView.hidden = false;
    
    [self clickNoneView];
    
}

- (void)refreshData{
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        self.sicknessCurrentPage = 0;
        self.sicknessTotalPage = 1;
        if (self.sicknessArray.count) {
            [self.sicknessTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        self.doctorCurrentPage = 0;
        self.doctorTotalPage = 1;
        if (self.doctorArray.count) {
            [self.doctorTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 2) {
        self.hospitalCurrentPage = 0;
        self.hospitalTotalPage = 1;
        if (self.hospitalArray.count) {
            [self.hospitalTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 3) {
        self.informationCurrentPage = 0;
        self.informationTotalPage = 1;
        if (self.informationArray.count) {
            [self.informationTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
        }
    }
    
    [self requestData];
    
}

- (void)getMoreData{
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        self.sicknessCurrentPage += self.pageSize;
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        self.doctorCurrentPage += self.pageSize;
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 2) {
        self.hospitalCurrentPage += self.pageSize;
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 3) {
        self.informationCurrentPage += self.pageSize;
    }
    
    [self requestData];
    
}

- (void)requestData {
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 0) {
        
        if (self.sicknessCurrentPage > self.sicknessTotalPage) {
            [self.sicknessTableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
//        [SVProgressHUD showWithStatus:kDefaultTipsText];
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"search"] = ISNIL(self.searchKey);
        params[@"pageSize"] = @(self.pageSize);
        params[@"from"] = @(self.sicknessCurrentPage);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchDisease withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            [self.sicknessTableView.mj_header endRefreshing];
            [self.sicknessTableView.mj_footer endRefreshing];
            
            if (isSuccess) {
                
                [SVProgressHUD dismiss];
                
                if (self.sicknessCurrentPage == 0) {
                    
                    [self.sicknessArray removeAllObjects];
                    
                }
                
                for (NSDictionary *dicInfo in response) {
                    
                    GHSearchSicknessModel *model = [[GHSearchSicknessModel alloc] initWithDictionary:dicInfo error:nil];
                    
                    if (model == nil) {
                        continue;
                    }
                    
                    [self.sicknessArray addObject:model];
                    
                }
                
                if (((NSArray *)response).count >= self.pageSize) {
                    self.sicknessTotalPage = self.sicknessArray.count + 1;
                } else {
                    self.sicknessTotalPage = self.sicknessCurrentPage;
                }
                
                [self.sicknessTableView reloadData];
                
                if (self.sicknessArray.count == 0) {
                    self.sicknessEmptyView.hidden = false;
                }else{
                    self.sicknessEmptyView.hidden = true;
                }
                
            }
            
        }];

        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        
        if (self.doctorCurrentPage > self.doctorTotalPage) {
            [self.doctorTableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
//        [SVProgressHUD showWithStatus:kDefaultTipsText];
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"search"] = ISNIL(self.searchKey);
        params[@"pageSize"] = @(self.pageSize);
        params[@"from"] = @(self.doctorCurrentPage);
        
        if ([self.doctorSortButton.currentTitle isEqualToString:@"评分最高"]) {
            params[@"sortType"] = @(3);
        } else if ([self.doctorSortButton.currentTitle isEqualToString:@"离我最近"]) {
            params[@"sortType"] = @(2);
        } else {
            params[@"sortType"] = @(1);
        }
        
        params[@"doctorGrade"] = self.doctorGrade.length ? self.doctorGrade : nil;
        
        params[@"medicineType"] = self.doctorType.length ? self.doctorType : nil;
        
        params[@"hospitalLevel"] = self.doctorHospitalLevel.length ? self.doctorHospitalLevel : nil;
        
        params[@"areaId"] = self.doctorAreaId;
        params[@"areaLevel"] = @(self.doctorAreaLevel);
        params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
        params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchDoctor withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            [self.doctorTableView.mj_header endRefreshing];
            [self.doctorTableView.mj_footer endRefreshing];
            
            if (isSuccess) {
                
                [SVProgressHUD dismiss];
                
                if (self.doctorCurrentPage == 0) {
                    
                    [self.doctorArray removeAllObjects];
                    
                }
                
                for (NSDictionary *dicInfo in response) {
                    
                    GHSearchDoctorModel *model = [[GHSearchDoctorModel alloc] initWithDictionary:dicInfo error:nil];
                    
                    if (model == nil) {
                        continue;
                    }

                    [self.doctorArray addObject:model];
                    
                }
                
                if (((NSArray *)response).count >= self.pageSize) {
                    self.doctorTotalPage = self.doctorArray.count + 1;
                } else {
                    self.doctorTotalPage = self.doctorCurrentPage;
                }
                
                [self.doctorTableView reloadData];
                
                if (self.doctorArray.count == 0) {
                    self.doctorEmptyView.hidden = false;
                }else{
                    self.doctorEmptyView.hidden = true;
                }
                
            }
            
        }];
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 2) {
        
        if (self.hospitalCurrentPage > self.hospitalTotalPage) {
            [self.hospitalTableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
//        [SVProgressHUD showWithStatus:kDefaultTipsText];
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"search"] = ISNIL(self.searchKey);
        params[@"pageSize"] = @(self.pageSize);
        params[@"page"] = @(self.hospitalCurrentPage);
        

        
        if ([self.hospitalSortButton.currentTitle isEqualToString:@"评分最高"]) {
            params[@"sortType"] = @(1);
        } else if ([self.hospitalSortButton.currentTitle isEqualToString:@"离我最近"]) {
            params[@"sortType"] = @(2);
        }
        else if ([self.hospitalSortButton.currentTitle isEqualToString:@"服务优先"])
        {
            params[@"sortType"] = @(3);
        }
        else if ([self.hospitalSortButton.currentTitle isEqualToString:@"环境优先"])
        {
            params[@"sortType"] = @(4);
            
        }
        
        params[@"hospitalCategory"] = self.hospitalType.length ? self.hospitalType : nil;
        
        NSMutableArray *levelArray = [[NSMutableArray alloc] init];
        
        for (NSString *level in [self.hospitalGrade componentsSeparatedByString:@","]) {
            
            if ([level isEqualToString:@"三级医院"]) {
                [levelArray addObject:@"3"];
            } else if ([level isEqualToString:@"二级医院"]) {
                [levelArray addObject:@"2"];
            } else if ([level isEqualToString:@"一级医院"]) {
                [levelArray addObject:@"1"];
            }
            
        }
        
        NSString *levelString = [levelArray componentsJoinedByString:@","];
        
        params[@"hospitalLevel"] = levelString.length ? levelString : nil;
        
        
        params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
        params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchHospital withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            [self.hospitalTableView.mj_header endRefreshing];
            [self.hospitalTableView.mj_footer endRefreshing];
            
            if (isSuccess) {
                
                [SVProgressHUD dismiss];
                
                if (self.hospitalCurrentPage == 0) {
                    
                    [self.hospitalArray removeAllObjects];
                    
                }
                
                for (NSDictionary *dicInfo in response) {
                    
                    GHSearchHospitalModel *model = [[GHSearchHospitalModel alloc] initWithDictionary:dicInfo[@"hospital"] error:nil];
                    model.distance = dicInfo[@"distance"];
                    
                    if (model == nil) {
                        continue;
                    }
                    
                    [self.hospitalArray addObject:model];
                    
                }
                
                if (((NSArray *)response).count >= self.pageSize) {
                    self.hospitalTotalPage = self.hospitalArray.count + 1;
                } else {
                    self.hospitalTotalPage = self.hospitalCurrentPage;
                }
                
                [self.hospitalTableView reloadData];
                
                if (self.hospitalArray.count == 0) {
                    self.hospitalEmptyView.hidden = false;
                }else{
                    self.hospitalEmptyView.hidden = true;
                }
                
            }
            
        }];
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 3) {
        
        if (self.informationCurrentPage > self.informationTotalPage) {
            [self.informationTableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        
//        [SVProgressHUD showWithStatus:kDefaultTipsText];
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"search"] = ISNIL(self.searchKey);
        params[@"pageSize"] = @(self.pageSize);
        params[@"from"] = @(self.informationCurrentPage);

        if ([self.informationSort isEqualToString:@"浏览次数"]) {
            params[@"sortType"] = @(6);
        } else if ([self.informationSort isEqualToString:@"收藏次数"]) {
            params[@"sortType"] = @(7);
        } else {
            params[@"sortType"] = @(1);
        }
        
//        排序方式 [1:默认排序 6:浏览最多 7:收藏最多]
        
        [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSearchNews withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
            
            [self.informationTableView.mj_header endRefreshing];
            [self.informationTableView.mj_footer endRefreshing];
            
            if (isSuccess) {
                
                [SVProgressHUD dismiss];
                
                if (self.informationCurrentPage == 0) {
                    
                    [self.informationArray removeAllObjects];
                    
                }
                
                for (NSDictionary *dicInfo in response) {
                    
                    GHArticleInformationModel *model = [[GHArticleInformationModel alloc] initWithDictionary:dicInfo error:nil];
                    
                    if (model == nil) {
                        continue;
                    }
                    
                    [self.informationArray addObject:model];
                    
                }
                
                if (((NSArray *)response).count >= self.pageSize) {
                    self.informationTotalPage = self.informationArray.count + 1;
                } else {
                    self.informationTotalPage = self.informationCurrentPage;
                }
                
                [self.informationTableView reloadData];
                
                if (self.informationArray.count == 0) {
                    self.informationEmptyView.hidden = false;
                }else{
                    self.informationEmptyView.hidden = true;
                }
                
            }
            
        }];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.doctorTableView) {
        return self.doctorArray.count;
    } else if (tableView == self.hospitalTableView) {
        return self.hospitalArray.count;
    } else if (tableView == self.informationTableView) {
        return self.informationArray.count;
    } else if (tableView == self.sicknessTableView) {
        return self.sicknessArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.doctorTableView) {
        return 185;
//        return 164;
    } else if (tableView == self.hospitalTableView) {
        return 126;
    } else if (tableView == self.informationTableView) {
        return 87;
    } else if (tableView == self.sicknessTableView) {
        return 87;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.doctorTableView) {
        return 44;
    } else if (tableView == self.hospitalTableView) {
        return 44;
    } else if (tableView == self.informationTableView) {
        return 52;
    } else if (tableView == self.sicknessTableView) {
        return 0;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.doctorTableView) {
        return self.doctorHeaderView;
    } else if (tableView == self.hospitalTableView) {
        return self.hospitalHeaderView;
    } else if (tableView == self.informationTableView) {
        return self.informationHeaderView;
    } else if (tableView == self.sicknessTableView) {
        return [UIView new];
    }
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.doctorTableView) {
        
        GHNSearchDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchDoctorTableViewCell"];
        
        if (!cell) {
            cell = [[GHNSearchDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchDoctorTableViewCell"];
        }
        
        cell.model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
      
    } else if (tableView == self.hospitalTableView) {
        
        GHNSearchHospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchHospitalTableViewCell"];
        
        if (!cell) {
            cell = [[GHNSearchHospitalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchHospitalTableViewCell"];
        }
        
        cell.model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
    } else if (tableView == self.informationTableView) {
        
        GHNSearchInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchInformationTableViewCell"];
        
        if (!cell) {
            cell = [[GHNSearchInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchInformationTableViewCell"];
        }
        
        cell.model = [self.informationArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
      
    } else if (tableView == self.sicknessTableView) {
        
        
        GHNSearchSicknessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchSicknessTableViewCell"];
        
        if (!cell) {
            cell = [[GHNSearchSicknessTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchSicknessTableViewCell"];
        }
        
        cell.model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];
        
        return cell;
        
    }
    
    return [UITableViewCell new];
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.doctorTableView) {
        
        GHDocterDetailViewController *vc = [[GHDocterDetailViewController alloc] init];
        GHSearchDoctorModel *model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
        vc.doctorId = model.modelId;
        vc.distance = model.distance;
        [self.navigationController pushViewController:vc animated:true];
        
    } else if (tableView == self.hospitalTableView) {
        
        GHSearchHospitalModel *model = [self.hospitalArray objectOrNilAtIndex:indexPath.row];
        
        GHHospitalDetailViewController *vc = [[GHHospitalDetailViewController alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:true];
        
    } else if (tableView == self.informationTableView) {
        
        GHInformationDetailViewController *vc = [[GHInformationDetailViewController alloc] init];
        GHArticleInformationModel *model = [self.informationArray objectOrNilAtIndex:indexPath.row];
        vc.informationId = model.modelId;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:true];
        
    } else if (tableView == self.sicknessTableView) {
        
        
        GHNDiseaseDetailViewController *vc = [[GHNDiseaseDetailViewController alloc] init];
        GHSearchSicknessModel *model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];
        vc.sicknessId = ISNIL(model.modelId);
        vc.sicknessName = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.diseaseName)];
        vc.departmentName = ISNIL(model.firstDepartmentName);
        vc.symptom = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.symptom)];
        [self.navigationController pushViewController:vc animated:true];
        
    }
    
}

- (void)chooseFinishWithCountryModel:(GHAreaModel *)countryModel provinceModel:(GHAreaModel *)provinceModel cityModel:(GHAreaModel *)cityModel areaModel:(GHAreaModel *)areaModel areaLevel:(NSInteger)areaLevel {
    
    if (self.scrollView.contentOffset.x == SCREENWIDTH * 1) {
        
        if (areaLevel == 4) {
            [self.doctorLocationButton setTitle:ISNIL(areaModel.areaName) forState:UIControlStateNormal];
            self.doctorAreaId = areaModel.modelId;
        } else if (areaLevel == 3) {
            [self.doctorLocationButton setTitle:ISNIL(cityModel.areaName) forState:UIControlStateNormal];
            self.doctorAreaId = cityModel.modelId;
        } else if (areaLevel == 2) {
            [self.doctorLocationButton setTitle:ISNIL(provinceModel.areaName) forState:UIControlStateNormal];
            self.doctorAreaId = provinceModel.modelId;
        } else if (areaLevel == 1) {
            [self.doctorLocationButton setTitle:@"全国" forState:UIControlStateNormal];
            self.doctorAreaId = countryModel.modelId;
        }
        
        self.doctorAreaLevel = areaLevel;

        [self clickNoneView];
        
        [self refreshData];
        
    } else if (self.scrollView.contentOffset.x == SCREENWIDTH * 2) {
        
        if (areaLevel == 4) {
            [self.hospitalLocationButton setTitle:ISNIL(areaModel.areaName) forState:UIControlStateNormal];
            self.hospitalAreaId = areaModel.modelId;
        } else if (areaLevel == 3) {
            [self.hospitalLocationButton setTitle:ISNIL(cityModel.areaName) forState:UIControlStateNormal];
            self.hospitalAreaId = cityModel.modelId;
        } else if (areaLevel == 2) {
            [self.hospitalLocationButton setTitle:ISNIL(provinceModel.areaName) forState:UIControlStateNormal];
            self.hospitalAreaId = provinceModel.modelId;
        } else if (areaLevel == 1) {
            [self.hospitalLocationButton setTitle:@"全国" forState:UIControlStateNormal];
            self.hospitalAreaId = countryModel.modelId;
        }
        
        self.hospitalAreaLevel = areaLevel;
        
        [self clickNoneView];
        
        [self refreshData];
        
    } else {
        
        if (areaLevel == 4) {
            
            [self.hospitalLocationButton setTitle:ISNIL(areaModel.areaName) forState:UIControlStateNormal];
            self.hospitalAreaId = areaModel.modelId;
            
            [self.doctorLocationButton setTitle:ISNIL(areaModel.areaName) forState:UIControlStateNormal];
            self.doctorAreaId = areaModel.modelId;
            
        } else if (areaLevel == 3) {
            
            [self.hospitalLocationButton setTitle:ISNIL(cityModel.areaName) forState:UIControlStateNormal];
            self.hospitalAreaId = cityModel.modelId;
            
            [self.doctorLocationButton setTitle:ISNIL(cityModel.areaName) forState:UIControlStateNormal];
            self.doctorAreaId = cityModel.modelId;
            
        } else if (areaLevel == 2) {
            
            [self.hospitalLocationButton setTitle:ISNIL(provinceModel.areaName) forState:UIControlStateNormal];
            self.hospitalAreaId = provinceModel.modelId;
            
            [self.doctorLocationButton setTitle:ISNIL(provinceModel.areaName) forState:UIControlStateNormal];
            self.doctorAreaId = provinceModel.modelId;
            
        } else if (areaLevel == 1) {
            
            [self.hospitalLocationButton setTitle:@"全国" forState:UIControlStateNormal];
            self.hospitalAreaId = countryModel.modelId;
            
            [self.doctorLocationButton setTitle:@"全国" forState:UIControlStateNormal];
            self.doctorAreaId = countryModel.modelId;
            
        }
        
        self.hospitalAreaLevel = areaLevel;
        self.doctorAreaLevel = areaLevel;
        
        [self clickNoneView];
        
    }
    

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.searchTextField resignFirstResponder];
    
}

/**
 每当点击顶部按钮便刷新列表
 
 @param tag <#tag description#>
 */
- (void)clickButtonWithTag:(NSInteger)tag {
    
    [self clickNoneView];
    
    [self.scrollView setContentOffset:CGPointMake(SCREENWIDTH * tag, 0) animated:NO];
    [self refreshData];
    
}

- (void)clickSearchAction {
    
    if (self.searchTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您要搜索的内容"];
        return;
    }
    
    if (self.searchTextField.text.length > 40) {
        [SVProgressHUD showErrorWithStatus:@"搜索的内容不得大于40字"];
        return;
    }
    
    if ([NSString isEmpty:self.searchTextField.text] || [NSString stringContainsEmoji:self.searchTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的搜索内容"];
        return;
    }
    
    if (self.searchTextField.text.length) {
        
        self.searchKey = self.searchTextField.text;
        [self.searchTextField resignFirstResponder];
        
        [self refreshData];
        
        [self clickNoneView];
        
    }
    
}

- (void)clickCancelAction {
    
    [self.searchTextField resignFirstResponder];
    
    [self.searchTextField resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:true];
    
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
    searchTextField.placeholder = @"搜索疾病、医生、医院、资讯";
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
    
    searchTextField.text = ISNIL(self.searchKey);
    [navigationView addSubview:searchTextField];
    
    UIImageView *searchIconImageView = [[UIImageView alloc] init];
    searchIconImageView.contentMode = UIViewContentModeCenter;
    searchIconImageView.image = [UIImage imageNamed:@"home_search"];
    searchIconImageView.size = CGSizeMake(35, 35);
//    searchIconImageView.size = CGSizeMake(Height_NavBar - Height_StatusBar - 10, Height_NavBar - Height_StatusBar - 10);
    
    searchTextField.leftView = searchIconImageView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(56);
        make.height.mas_equalTo(35);
        make.centerY.mas_equalTo(navigationView);
        make.right.mas_equalTo(-64);
    }];
    [searchTextField addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    self.searchTextField = searchTextField;
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    searchButton.titleLabel.font = H16;
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:searchButton];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(searchTextField.mas_right);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backBtn.showsTouchWhenHighlighted = NO;
    [backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backBtn];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationView.hidden = false;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
//    [self hideLeftButton];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationView.hidden = true;
    
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}

@end
