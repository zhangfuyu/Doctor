//
//  GHHomeTopCollectionReusableView.m
//  掌上优医
//
//  Created by GH on 2019/2/18.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHomeTopCollectionReusableView.h"
#import "SDCycleScrollView.h"
#import "GHHomeModuleButtonView.h"

#import "GHNSearchSicknessViewController.h"
#import "GHNSearchDoctorViewController.h"
#import "GHSearchHospitalViewController.h"
#import "GHNInformationListViewController.h"

#import "GHNDiseaseListViewController.h"

#import "GHHomeBannerModel.h"

@interface GHHomeTopCollectionReusableView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *scrollView;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSArray *bannerArray;

@end

@implementation GHHomeTopCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
    
}

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}


- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];

    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(184)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    scrollView.autoScrollTimeInterval = 5;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.currentPageDotColor = [UIColor whiteColor];
    scrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:0.6];
    scrollView.pageControlBottomOffset = 12;
    scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    scrollView.imageSize = CGSizeMake(SCREENWIDTH - 16 * 2, HScaleHeight(160));
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(HScaleHeight(-40));
        make.height.mas_equalTo(HScaleHeight(10));
    }];
    
    
    NSArray *imageArray = @[@"home_sickness", @"home_doctor", @"home_hospital", @"home_information"];
    NSArray *titleArray = @[@"查疾病", @"找医生", @"搜医院", @"星医讲堂"];
    
    for (NSInteger index = 0; index < titleArray.count; index++) {
        
        GHHomeModuleButtonView *buttonView = [[GHHomeModuleButtonView alloc] initWithImageName:[imageArray objectOrNilAtIndex:index] withTitle:[titleArray objectOrNilAtIndex:index]];
        
        [self addSubview:buttonView];
        
        [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo((SCREENWIDTH - 32 - 18) / 4.f);
            make.top.mas_equalTo(scrollView.mas_bottom);
            make.bottom.mas_equalTo(lineLabel.mas_top).offset(HScaleHeight(-12));
            make.left.mas_equalTo(16 + ((SCREENWIDTH - 32 - 18) / 4.f + 6) * index);
        }];
        
        switch (index) {
            case 0:
                [buttonView.actionButton addTarget:self action:@selector(clickSicknessAction) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                [buttonView.actionButton addTarget:self action:@selector(clickDoctorAction) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                [buttonView.actionButton addTarget:self action:@selector(clickHospitalAction) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 3:
                [buttonView.actionButton addTarget:self action:@selector(clickInformationAction) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            default:
                break;
        }
        
    }
    

    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"精选内容"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 18] ? [UIFont fontWithName:@"PingFangSC-Semibold" size: 18] : [UIFont  systemFontOfSize:18],NSForegroundColorAttributeName: kDefaultBlackTextColor}];
    
    titleLabel.attributedText = string;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(25);
        make.bottom.mas_equalTo(0);
        
        
    }];

    
}

// 查疾病
- (void)clickSicknessAction {
    
    [MobClick event:@"Search_Disease"];
    
    GHNDiseaseListViewController *vc = [[GHNDiseaseListViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

// 找医生
- (void)clickDoctorAction {
    
    [MobClick event:@"Search_Doctor"];
    
    GHNSearchDoctorViewController *vc = [[GHNSearchDoctorViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

// 找医院
- (void)clickHospitalAction {
    
    [MobClick event:@"Search_Hospital"];
    
    GHSearchHospitalViewController *vc = [[GHSearchHospitalViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:false];
    
}

// 优医讲堂
- (void)clickInformationAction {
    
    [MobClick event:@"Search_News"];
    
    GHNInformationListViewController *vc = [[GHNInformationListViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:false];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    GHHomeBannerModel *model = [self.bannerArray objectOrNilAtIndex:index];
    
    if (model.activityUrl.length > 0) {
        
        GHCommonWebViewController *vc = [[GHCommonWebViewController alloc] init];
        vc.navTitle = @"活动详情";
        vc.urlStr = ISNIL(model.activityUrl);
        vc.shareTitle = ISNIL(model.desc);
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    }
    
}

- (void)setupScrollViewWithModelArray:(NSArray *)modelArray {
    
    self.bannerArray = modelArray;
    
    NSMutableArray *imageUrlArray = [[NSMutableArray alloc] init];
    for (GHHomeBannerModel *model in modelArray) {
        [imageUrlArray addObject:ISNIL(model.url)];
    }
    
    [self.scrollView setImageURLStringsGroup:imageUrlArray];
    
}


@end
