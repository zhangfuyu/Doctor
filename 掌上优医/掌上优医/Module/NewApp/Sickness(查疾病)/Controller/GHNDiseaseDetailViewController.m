//
//  GHNDiseaseDetailViewController.m
//  掌上优医
//
//  Created by GH on 2019/4/1.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNDiseaseDetailViewController.h"
#import "GHCommonShareView.h"
#import "GHDocterDetailViewController.h"

#import "GHZuJiSicknessModel.h"

#import "GHNSicknessDoctorListViewController.h"

#import "GHProvinceCityAreaViewController.h"
#import "GHDoctorSortViewController.h"
#import "GHDocterDetailViewController.h"
#import "GHNSearchDoctorTableViewCell.h"
#import "GHDoctorFilterViewController.h"

#import "UIButton+touch.h"

#import "GHNChooseTitleView.h"

#import "GHNDiseaseModel.h"

@interface GHNDiseaseDetailViewController ()<UITableViewDelegate, UITableViewDataSource, GHProvinceCityAreaViewControllerDelegate, GHDoctorSortViewControllerDelegate, GHDoctorFilterViewControllerDelegate, GHNChooseTitleViewDelegate, UIScrollViewDelegate>

/**
 <#Description#>
 */
@property (nonatomic, strong) GHNDiseaseModel *model;

@property (nonatomic, strong) GHCommonShareView *shareView;

@property (nonatomic, strong) NSString *urlStr;

@property (nonatomic, strong) UIView *tableHeaderView;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, strong) NSMutableArray *doctorArray;
@property (nonatomic, assign) NSUInteger doctorCurrentPage;
@property (nonatomic, assign) NSUInteger doctorTotalPage;
@property (nonatomic, strong) UITableView *doctorTableView;

@property (nonatomic, strong) UIView *doctorHeaderView;

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

@property (nonatomic, strong) GHLocationStatusView *locationStatusView;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *diseaseNameLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *diseaseDepartmentNameLabel;

@property (nonatomic, strong) UILabel *moveLineLabel;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, strong) UIScrollView *scrollView;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *contentLabelArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSMutableArray *arrowButtonArray;

/**
 <#Description#>
 */
@property (nonatomic, strong) UIView *tableFooterView;

/**
 <#Description#>
 */
@property (nonatomic, assign) CGFloat shouldDefaultHeaderViewHeight;

@end

@implementation GHNDiseaseDetailViewController

- (UIView *)tableFooterView {
    
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] init];
        
        _tableFooterView.backgroundColor = [UIColor whiteColor];
        
        _tableFooterView.frame = CGRectMake(0, 0, SCREENWIDTH, 265);
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_data"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_tableFooterView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(23);
            make.centerX.mas_equalTo(imageView.superview);
            make.size.mas_equalTo(CGSizeMake(300, 150));
        }];
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.font = H14;
        tipLabel.textColor = kDefaultGrayTextColor;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"暂无可推荐医生";
        [_tableFooterView addSubview:tipLabel];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(imageView.mas_bottom).offset(19);
            make.height.mas_equalTo(22);
        }];
        
    }
    return _tableFooterView;
    
}

- (NSMutableArray *)arrowButtonArray {
    
    if (!_arrowButtonArray) {
        _arrowButtonArray = [[NSMutableArray alloc] init];
    }
    return _arrowButtonArray;
    
}

- (NSMutableArray *)contentLabelArray {
    
    if (!_contentLabelArray) {
        _contentLabelArray = [[NSMutableArray alloc] init];
    }
    return _contentLabelArray;
    
}

- (NSMutableArray *)buttonArray {
    
    if (!_buttonArray) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
    
}

- (GHLocationStatusView *)locationStatusView {
    
    if (!_locationStatusView) {
        _locationStatusView = [[GHLocationStatusView alloc] init];
        [self.view addSubview:_locationStatusView];
        
        [_locationStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(53 - kBottomSafeSpace);
        }];
    }
    return _locationStatusView;
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.locationStatusView.hidden = [GHUserModelTool shareInstance].isHaveLocation;
    
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
                [button setTitle:@"离我最近" forState:UIControlStateNormal];
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
        
        UILabel *lineLabel4 = [[UILabel alloc] init];
        lineLabel4.backgroundColor = kDefaultLineViewColor;
        [_doctorHeaderView addSubview:lineLabel4];
        
        [lineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    
    return _doctorHeaderView;
    
}

- (UIView *)doctorLocationView {
    
    if (!_doctorLocationView) {
        _doctorLocationView = [[UIView alloc] init];
        _doctorLocationView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _doctorLocationView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 41 - Height_NavBar);
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

- (UIView *)doctorSortView {
    
    if (!_doctorSortView) {
        _doctorSortView = [[UIView alloc] init];
        _doctorSortView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _doctorSortView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 41 - Height_NavBar);
        [self.view addSubview:_doctorSortView];
        
        GHDoctorSortViewController *vc = [[GHDoctorSortViewController alloc] init];
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

- (UIView *)doctorFilterView {
    
    if (!_doctorFilterView) {
        _doctorFilterView = [[UIView alloc] init];
        _doctorFilterView.backgroundColor = RGBACOLOR(51,51,51,0.2);
        _doctorFilterView.frame = CGRectMake(0, 44, SCREENWIDTH, SCREENHEIGHT - 41 - Height_NavBar);
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


- (void)chooseFinishDoctorSortWithSort:(NSString *)sort {
    
    [self.doctorSortButton setTitle:ISNIL(sort) forState:UIControlStateNormal];
    
    [self clickNoneView];
    
    [self refreshData];
    
}

- (void)clickDoctorLocationAction:(UIButton *)sender {
    
    if (sender.selected == true) {
        
        [self clickNoneView];
        
        sender.selected = false;
        
    } else {
        
        [self clickNoneView];
        
        sender.selected = true;
        
        [self reloadTableViewLocation];
        
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
        
        [self reloadTableViewLocation];
        
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
        
        [self reloadTableViewLocation];
        
    }
    
    self.doctorFilterView.hidden = !sender.selected;
    
}

- (void)reloadTableViewLocation {
    
    if (self.doctorTableView.contentOffset.y < self.tableHeaderView.height) {
        [self.doctorTableView setContentOffset:CGPointMake(0, self.tableHeaderView.height) animated:false];
    }
    
}


- (void)clickNoneView {
    
    self.doctorLocationView.hidden = true;
    self.doctorLocationButton.selected = false;
    
    self.doctorSortView.hidden = true;
    self.doctorSortButton.selected = false;
    
    self.doctorFilterView.hidden = true;
    self.doctorFilterButton.selected = false;
    
}

- (NSMutableArray *)doctorArray {
    
    if (!_doctorArray) {
        _doctorArray = [[NSMutableArray alloc] init];
    }
    return _doctorArray;
    
}

- (GHCommonShareView *)shareView {
    
    if (!_shareView) {
        _shareView = [[GHCommonShareView alloc] init];
        _shareView.title = ISNIL(self.sicknessName);
        _shareView.desc = @"了解医疗知识，关注健康生活。";
        _shareView.urlString = self.urlStr;
        [self.view addSubview:_shareView];
        
        [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        _shareView.hidden = true;
    }
    return _shareView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"疾病详情";
    
//    self.navigationItem.title = ISNIL(self.sicknessName);
    
    self.urlStr = [[GHNetworkTool shareInstance] getSicknessDetailURLWithSicknessId:ISNIL(self.sicknessId)];
    
    [self addRightButton:@selector(clickShareAction) image:[UIImage imageNamed:@"bg_sickness_share"]];
    
    [self setupConfig];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidAppear:) name:kNotificationWillEnterForeground object:nil];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = ISNIL(self.sicknessId);
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiDisease withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:false withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
        
        if (isSuccess) {
            
            self.model = [[GHNDiseaseModel alloc] initWithDictionary:response error:nil];
 
            self.model.firstDepartmentName = [[self.model.departmentNames componentsSeparatedByString:@","] componentsJoinedByString:@" | "];
            
            GHZuJiSicknessModel *model = [[GHZuJiSicknessModel alloc] init];
            
            model.modelId = ISNIL(self.sicknessId);
            model.diseaseName = ISNIL(self.model.diseaseName);
            model.symptom = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.symptom)];
            model.firstDepartmentName = ISNIL(self.model.firstDepartmentName);
            
            if (model) {
                [[GHSaveDataTool shareInstance] addObject:model withType:GHSaveDataType_Sickness];
            }
            

            
            if (ISNIL(self.model.summary).length == 0) {
                self.model.summary = @"<p>暂无</p>";
            }
            
            if (ISNIL(self.model.symptom).length == 0) {
                self.model.symptom = @"<p>暂无</p>";
            }
            
            if (ISNIL(self.model.pathogeny).length == 0) {
                self.model.pathogeny = @"<p>暂无</p>";
            }
            
            if (ISNIL(self.model.diagnosis).length == 0) {
                self.model.diagnosis = @"<p>暂无</p>";
            }
            
            if (ISNIL(self.model.treatment).length == 0) {
                self.model.treatment = @"<p>暂无</p>";
            }
            
            NSString *htmlHeader = @"<style>p{text-indent: 20px;}</style><html><body style='font-size: 15px;'>";
            
            NSString *htmlFooter = @"</body></html>";

//            self.model.summary = [NSString stringWithFormat:@"%@%@%@", htmlHeader, self.model.summary, htmlFooter];
//
//            self.model.symptom = [NSString stringWithFormat:@"%@%@%@", htmlHeader, self.model.symptom, htmlFooter];
//
//            self.model.pathogeny = [NSString stringWithFormat:@"%@%@%@", htmlHeader, self.model.pathogeny, htmlFooter];
//
//            self.model.diagnosis = [NSString stringWithFormat:@"%@%@%@", htmlHeader, self.model.diagnosis, htmlFooter];
//
//            self.model.treatment = [NSString stringWithFormat:@"%@%@%@", htmlHeader, self.model.treatment, htmlFooter];
            
            
            self.model.summary = [NSString stringWithFormat:@"%@%@%@", htmlHeader, [GHFilterHTMLTool filterHTMLPTag:self.model.summary], htmlFooter];

            self.model.symptom = [NSString stringWithFormat:@"%@%@%@", htmlHeader, [GHFilterHTMLTool filterHTMLPTag:self.model.symptom], htmlFooter];

            self.model.pathogeny = [NSString stringWithFormat:@"%@%@%@", htmlHeader, [GHFilterHTMLTool filterHTMLPTag:self.model.pathogeny], htmlFooter];

            self.model.diagnosis = [NSString stringWithFormat:@"%@%@%@", htmlHeader, [GHFilterHTMLTool filterHTMLPTag:self.model.diagnosis], htmlFooter];

            self.model.treatment = [NSString stringWithFormat:@"%@%@%@", htmlHeader, [GHFilterHTMLTool filterHTMLPTag:self.model.treatment], htmlFooter];
            
            
            
            [self setupUI];
        }
        
    }];
    
}

- (void)setupConfig{
    
    self.pageSize = 10;
    self.doctorTotalPage = 1;
    self.doctorCurrentPage = 0;
    
}


- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.backgroundColor = [UIColor whiteColor];
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
    self.doctorTableView = tableView;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    self.doctorHeaderView.hidden = false;
    self.doctorLocationView.hidden = true;
    
    [self clickNoneView];
    
    [self setupTableHeaderView];
    
    [self clickTypeButtonAction:[self.buttonArray firstObject]];
    
}

- (void)setupTableHeaderView {
    
    self.shouldDefaultHeaderViewHeight = 355 - 70;
    
    CGFloat titleViewShouldHeight = 32;
    
    CGFloat nameShouldHeight = [ISNIL(self.model.diseaseName) heightForFont:HM16 width:SCREENWIDTH - 32];
    
    CGFloat departmentHeight = [[NSString stringWithFormat:@"就诊科室: %@", ISNIL(self.model.firstDepartmentName)] heightForFont:H14 width:SCREENWIDTH - 32];
    
    titleViewShouldHeight += nameShouldHeight;
    
    titleViewShouldHeight += departmentHeight;
    
    self.shouldDefaultHeaderViewHeight += titleViewShouldHeight;
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = kDefaultGaryViewColor;
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, self.shouldDefaultHeaderViewHeight);
    
    UIView *sicknessTitleView = [[UIView alloc] init];
    sicknessTitleView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:sicknessTitleView];
    
    [sicknessTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(titleViewShouldHeight);
    }];
    
    UILabel *sicknessNameLabel = [[UILabel alloc] init];
    sicknessNameLabel.font = HM15;
    sicknessNameLabel.textColor = kDefaultBlackTextColor;
    sicknessNameLabel.text = ISNIL(self.model.diseaseName);
    sicknessNameLabel.numberOfLines = 0;
    [sicknessTitleView addSubview:sicknessNameLabel];
    
    [sicknessNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13);
        make.height.mas_equalTo(nameShouldHeight);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    
    UILabel *sicknessDepartmentNameLabel = [[UILabel alloc] init];
    sicknessDepartmentNameLabel.font = H13;
    sicknessDepartmentNameLabel.textColor = kDefaultGrayTextColor;
    sicknessDepartmentNameLabel.text = [NSString stringWithFormat:@"就诊科室: %@", ISNIL(self.model.firstDepartmentName)];
    sicknessDepartmentNameLabel.numberOfLines = 0;
    [sicknessTitleView addSubview:sicknessDepartmentNameLabel];
    
    [sicknessDepartmentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sicknessNameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(departmentHeight);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    self.diseaseDepartmentNameLabel = sicknessDepartmentNameLabel;
    
    UIView *buttonView = [[UIView alloc] init];
    buttonView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:buttonView];
    
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(sicknessTitleView.mas_bottom).offset(10);
        make.height.mas_equalTo(45);
    }];
    
    NSArray *titleArray = @[@"概述", @"症状", @"病因", @"诊断", @"治疗"];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:ISNIL([titleArray objectOrNilAtIndex:index]) forState:UIControlStateNormal];
        [button setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
        [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
        button.titleLabel.font = HM16;
        button.tag = index;
        [buttonView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(sicknessTitleView.mas_bottom).offset(10);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(index * (SCREENWIDTH / titleArray.count));
            make.width.mas_equalTo(SCREENWIDTH / titleArray.count);
        }];
        
        [self.buttonArray addObject:button];
        
        [button addTarget:self action:@selector(clickTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (index == 0) {
            
            UILabel *moveLineLabel = [[UILabel alloc] init];
            moveLineLabel.backgroundColor = kDefaultBlueColor;
            moveLineLabel.frame = CGRectMake((0 * (SCREENWIDTH / 5.f)) + ((SCREENWIDTH / 5.f) * .5) - 16, 42, 32, 2);
            [buttonView addSubview:moveLineLabel];
            
            self.moveLineLabel = moveLineLabel;
            
        }
        
    }
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = kDefaultGaryViewColor;
    [buttonView addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.right.left.mas_equalTo(0);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, 135 - 70 + (self.shouldDefaultHeaderViewHeight - 285), SCREENWIDTH, 155);
    scrollView.contentSize = CGSizeMake(SCREENWIDTH * titleArray.count, scrollView.height);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    scrollView.scrollEnabled = false;
    
    [headerView addSubview:scrollView];
    
    self.scrollView = scrollView;
    
    NSArray *contentArray = @[ISNIL(self.model.summary),
                              ISNIL(self.model.symptom),
                              ISNIL(self.model.pathogeny),
                              ISNIL(self.model.diagnosis),
                              ISNIL(self.model.treatment)];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = H15;
        contentLabel.textColor = kDefaultBlackTextColor;
        contentLabel.numberOfLines = 0;
        [scrollView addSubview:contentLabel];

        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.maximumLineHeight = 21;
        paragraphStyle.minimumLineHeight = 21;
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;

        NSString *shouldGoodAtStr = ISNIL([contentArray objectOrNilAtIndex:index]);

        NSAttributedString *attr = [[NSAttributedString alloc] initWithData:[shouldGoodAtStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        
        contentLabel.attributedText = attr;

        contentLabel.frame = CGRectMake(16 + (SCREENWIDTH * index), 10, SCREENWIDTH - 32, scrollView.height - 20);

        [self.contentLabelArray addObject:contentLabel];
        
        contentLabel.backgroundColor = [UIColor whiteColor];
        
        
        if ([attr boundingRectWithSize:CGSizeMake(contentLabel.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height > contentLabel.height) {
            
            UIButton *arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [arrowButton setImage:[UIImage imageNamed:@"ic_yiyuanzhuye_gengduo"] forState:UIControlStateNormal];
            [arrowButton setImage:[UIImage imageNamed:@"ic_yiyuanzhuye_shouqi"] forState:UIControlStateSelected];
            arrowButton.backgroundColor = [UIColor whiteColor];
            arrowButton.tag = index;
            arrowButton.isIgnore = true;
            [scrollView addSubview:arrowButton];
            
            arrowButton.frame = CGRectMake(SCREENWIDTH * index, scrollView.height - 35, SCREENWIDTH, 35);
            
            [arrowButton addTarget:self action:@selector(clickOpenAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.arrowButtonArray addObject:arrowButton];
            
        } else {
            
            UIButton *arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [arrowButton setImage:[UIImage imageNamed:@"ic_yiyuanzhuye_gengduo"] forState:UIControlStateNormal];
            [arrowButton setImage:[UIImage imageNamed:@"ic_yiyuanzhuye_shouqi"] forState:UIControlStateSelected];
            arrowButton.backgroundColor = [UIColor whiteColor];
            arrowButton.tag = index;
            arrowButton.isIgnore = true;
            [scrollView addSubview:arrowButton];
            
            arrowButton.frame = CGRectMake(SCREENWIDTH * index, scrollView.height - 35, SCREENWIDTH, 35);
            
            [arrowButton addTarget:self action:@selector(clickOpenAction:) forControlEvents:UIControlEventTouchUpInside];
            arrowButton.hidden = true;
            [self.arrowButtonArray addObject:arrowButton];
            
            contentLabel.height = [attr boundingRectWithSize:CGSizeMake(contentLabel.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height ;
            
        }
        
    }
    
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(55);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HM18;
    titleLabel.text = @"医生推荐";
    titleLabel.textColor = kDefaultBlackTextColor;
    [titleView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(16);
        make.top.bottom.mas_equalTo(0);
    }];
    
    self.tableHeaderView = headerView;
    
    self.doctorTableView.tableHeaderView = headerView;
    
}

- (void)clickOpenAction:(UIButton *)sender {
    
    NSArray *contentArray = @[[GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.summary)],
                              [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.symptom)],
                              [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.pathogeny)],
                              [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.diagnosis)],
                              [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.treatment)]];
    
    UILabel *contentLabel = [self.contentLabelArray objectOrNilAtIndex:sender.tag];
    UIButton *arrowButton = [self.arrowButtonArray objectOrNilAtIndex:sender.tag];
    
    if (sender.selected == false) {
        
        contentLabel.height = [contentLabel.attributedText boundingRectWithSize:CGSizeMake(contentLabel.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height ;
        
        self.scrollView.frame = CGRectMake(0, 135 - 70 + (self.shouldDefaultHeaderViewHeight - 285), SCREENWIDTH, contentLabel.height + 20 + 35 - 30);
        self.scrollView.contentSize = CGSizeMake(SCREENWIDTH * contentArray.count, self.scrollView.height);
        
        arrowButton.frame = CGRectMake(SCREENWIDTH * sender.tag, self.scrollView.height - 35, SCREENWIDTH, 35);
        
        self.tableHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH, self.scrollView.mj_y + 65 + self.scrollView.height);
        self.doctorTableView.tableHeaderView = self.tableHeaderView;
        
        sender.selected = true;
        
    } else {
        
        self.scrollView.frame = CGRectMake(0, 135 - 70 + (self.shouldDefaultHeaderViewHeight - 285), SCREENWIDTH, 155);
        self.scrollView.contentSize = CGSizeMake(SCREENWIDTH * contentArray.count, self.scrollView.height);
        
        contentLabel.frame = CGRectMake(16 + (SCREENWIDTH * sender.tag), 10, SCREENWIDTH - 32, self.scrollView.height - 20);
        arrowButton.frame = CGRectMake(SCREENWIDTH * sender.tag, self.scrollView.height - 35, SCREENWIDTH, 35);
        
        contentLabel.height = [contentLabel.attributedText boundingRectWithSize:CGSizeMake(contentLabel.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height ;
        
        self.tableHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH, self.shouldDefaultHeaderViewHeight);
        self.doctorTableView.tableHeaderView = self.tableHeaderView;
        
        sender.selected = false;
        
        [self.doctorTableView scrollToTopAnimated:false];
        
    }
    
    
    
}


//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    // 停止类型1、停止类型2
//    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
//    if (scrollToScrollStop) {
//        [self scrollViewDidEndScroll];
//    }
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (!decelerate) {
//        // 停止类型3
//        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
//        if (dragToDragStop) {
//            [self scrollViewDidEndScroll];
//        }
//    }
//}
//
//- (void)scrollViewDidEndScroll {
//
//    NSLog(@"停止滚动了！！！");
//
//
//    [self clickTypeButtonAction:[self.buttonArray objectOrNilAtIndex:((NSInteger)self.scrollView.contentOffset.x / SCREENWIDTH)]];
//
//}

- (void)clickTypeButtonAction:(UIButton *)sender {
    
    for (UIButton *button in self.buttonArray) {
        button.selected = false;
    }
    
    sender.selected = true;
    
    [UIView animateWithDuration:.3 animations:^{
        self.moveLineLabel.mj_x = (sender.tag * (SCREENWIDTH / 5.f)) + ((SCREENWIDTH / 5.f) * .5) - 16;
    }];
    
    [self.scrollView setContentOffset:CGPointMake(SCREENWIDTH * sender.tag, 0) animated:true];
    
    
    
    NSArray *contentArray = @[[GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.summary)],
                              [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.symptom)],
                              [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.pathogeny)],
                              [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.diagnosis)],
                              [GHFilterHTMLTool filterHTMLEMTag:ISNIL(self.model.treatment)]];
    
    UILabel *contentLabel = [self.contentLabelArray objectOrNilAtIndex:sender.tag];
    UIButton *arrowButton = [self.arrowButtonArray objectOrNilAtIndex:sender.tag];
    
    if (arrowButton.selected == true) {
        
        contentLabel.height = [contentLabel.attributedText boundingRectWithSize:CGSizeMake(contentLabel.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height ;
        
        self.scrollView.frame = CGRectMake(0, 135 - 70 + (self.shouldDefaultHeaderViewHeight - 285), SCREENWIDTH, contentLabel.height + 20 + 35 - 30);
        self.scrollView.contentSize = CGSizeMake(SCREENWIDTH * contentArray.count, self.scrollView.height);
        
        arrowButton.frame = CGRectMake(SCREENWIDTH * sender.tag, self.scrollView.height - 35, SCREENWIDTH, 35);
        
        self.tableHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH, self.scrollView.mj_y + 65 + self.scrollView.height);
        self.doctorTableView.tableHeaderView = self.tableHeaderView;
        
    } else {
        
        if (arrowButton.hidden == true) {
            
            contentLabel.height = [contentLabel.attributedText boundingRectWithSize:CGSizeMake(contentLabel.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height ;
            
            self.scrollView.frame = CGRectMake(0, 135 - 70 + (self.shouldDefaultHeaderViewHeight - 285), SCREENWIDTH, contentLabel.height + 20 - 30);
            
            
            
            self.scrollView.contentSize = CGSizeMake(SCREENWIDTH * contentArray.count, self.scrollView.height);
            
            arrowButton.frame = CGRectMake(SCREENWIDTH * sender.tag, self.scrollView.height - 35, SCREENWIDTH, 35);
            
            self.tableHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH, self.scrollView.mj_y + 65 + self.scrollView.height);
            self.doctorTableView.tableHeaderView = self.tableHeaderView;
            
        } else {
            
            self.scrollView.frame = CGRectMake(0, 135 - 70 + (self.shouldDefaultHeaderViewHeight - 285), SCREENWIDTH, 155);
            self.scrollView.contentSize = CGSizeMake(SCREENWIDTH * contentArray.count, self.scrollView.height);
            
            contentLabel.frame = CGRectMake(16 + (SCREENWIDTH * sender.tag), 10, SCREENWIDTH - 32, self.scrollView.height - 20);
            arrowButton.frame = CGRectMake(SCREENWIDTH * sender.tag, self.scrollView.height - 35, SCREENWIDTH, 35);
            
            contentLabel.height = [contentLabel.attributedText boundingRectWithSize:CGSizeMake(contentLabel.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height ;
            
            self.tableHeaderView.frame = CGRectMake(0, 0, SCREENWIDTH, self.shouldDefaultHeaderViewHeight);
            self.doctorTableView.tableHeaderView = self.tableHeaderView;

            
        }

        
        
        
        
    }
    
}

- (void)clickShareAction {
    
    self.shareView.hidden = false;
    
}

- (void)refreshData{
    
    self.doctorCurrentPage = 0;
    self.doctorTotalPage = 1;
    //    if (self.doctorArray.count) {
    //        [self.doctorTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionNone animated:false];
    //    }
    
    [self requestData];
    
}

- (void)getMoreData{
    
    self.doctorCurrentPage += self.pageSize;
    
    [self requestData];
    
}

- (void)requestData {
    
    if (self.doctorCurrentPage > self.doctorTotalPage) {
        [self.doctorTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    //    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"pageSize"] = @(self.pageSize);
    params[@"from"] = @(self.doctorCurrentPage);
    
    if ([self.doctorSortButton.currentTitle isEqualToString:@"评分最高"]) {
        params[@"sortType"] = @(3);
    } else if ([self.doctorSortButton.currentTitle isEqualToString:@"离我最近"]) {
        params[@"sortType"] = @(2);
    } else {
        params[@"sortType"] = @(10);
    }
    
    params[@"doctorGrade"] = self.doctorGrade.length ? self.doctorGrade : nil;
    
    params[@"medicineType"] = self.doctorType.length ? self.doctorType : nil;
    
    params[@"hospitalLevel"] = self.doctorHospitalLevel.length ? self.doctorHospitalLevel : nil;
    
    params[@"areaId"] = self.doctorAreaId;
    params[@"areaLevel"] = @(self.doctorAreaLevel);
    params[@"lat"] = @([GHUserModelTool shareInstance].locationLatitude > 0 ? [GHUserModelTool shareInstance].locationLatitude : 30.3751);
    params[@"lng"] = @([GHUserModelTool shareInstance].locationLongitude > 0 ? [GHUserModelTool shareInstance].locationLongitude : 120.1236);
    
    params[@"departmentId"] = self.model.departmentIds;
    params[@"departmentLevel"] = @(2);
    
    
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
                
                self.doctorTableView.tableFooterView = self.tableFooterView;
                
                if (!self.doctorTableView.scrollsToTop) {
                    [self.doctorTableView scrollToBottomAnimated:false];
                }
                
                
            }else{
                
                self.doctorTableView.tableFooterView = nil;
                
            }
            
        }
        
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.doctorArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 185;
    
//    return 164;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.doctorHeaderView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    GHNSearchDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHNSearchDoctorTableViewCell"];
    
    if (!cell) {
        cell = [[GHNSearchDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHNSearchDoctorTableViewCell"];
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    cell.model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    GHDocterDetailViewController *vc = [[GHDocterDetailViewController alloc] init];
    GHSearchDoctorModel *model = [self.doctorArray objectOrNilAtIndex:indexPath.row];
    vc.doctorId = model.modelId;
    vc.distance = model.distance;
    [self.navigationController pushViewController:vc animated:true];
    
    
}

- (void)chooseFinishWithCountryModel:(GHAreaModel *)countryModel provinceModel:(GHAreaModel *)provinceModel cityModel:(GHAreaModel *)cityModel areaModel:(GHAreaModel *)areaModel areaLevel:(NSInteger)areaLevel {
    
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
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
}


@end

