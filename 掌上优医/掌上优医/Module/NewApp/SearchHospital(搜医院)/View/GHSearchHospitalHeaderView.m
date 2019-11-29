//
//  GHSearchHospitalHeaderView.m
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHSearchHospitalHeaderView.h"
#import "SDCycleScrollView.h"
#import "GHSearchHospitalButtonView.h"
#import "GHHomeBannerModel.h"
#import "GHSpecialDepartmentHospitalViewController.h"
#import "GHNSearchHotViewController.h"
#import "GHHospitalRecommendedModel.h"
#import "GHHotRecommendedView.h"


@interface GHSearchHospitalHeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *scrollView;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSArray *bannerArray;

@property (nonatomic, strong) GHHotRecommendedView *hotHospital;

@end

@implementation GHSearchHospitalHeaderView

- (instancetype)init {
    
    if (self = [super init]) {
        self.clipsToBounds = YES;
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(160)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    scrollView.autoScrollTimeInterval = 5;
    scrollView.showPageControl = YES;
    scrollView.isCornerRadius = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.currentPageDotColor = [UIColor whiteColor];
    scrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:0.6];
    scrollView.pageControlBottomOffset = HScaleHeight(37 - 12);
    scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    scrollView.imageSize = CGSizeMake(SCREENWIDTH, HScaleHeight(160));
    [self addSubview:scrollView];
    self.scrollView = scrollView;

    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.titleLabel.font = HScaleFont(15);
    [searchButton setTitle:@" 搜索医院名称" forState:UIControlStateNormal];
    [searchButton setTitleColor:UIColorHex(0x999999) forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"new_home_search_2"] forState:UIControlStateNormal];

    searchButton.backgroundColor = [UIColor whiteColor];
    searchButton.layer.cornerRadius = HScaleHeight(25);
    [self addSubview:searchButton];
       
    [searchButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];

    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleHeight(15));
        make.right.mas_equalTo(-HScaleHeight(15));
        make.height.mas_equalTo(HScaleHeight(50));
        make.centerY.mas_equalTo(self.scrollView.mas_bottom);
    }];
    [self addShadowToView:searchButton withColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.17]];
    

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = HScaleFont(15);
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.text = @"热门专科";
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scrollView.mas_bottom).offset(HScaleHeight(46.5));
        make.height.mas_equalTo(HScaleHeight(15));
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultLineViewColor;
    [self addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.scrollView.mas_bottom).offset(HScaleHeight(142));
        make.height.mas_equalTo(HScaleHeight(5));
    }];
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = kDefaultLineViewColor;
    [self addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(HScaleHeight(5));
    }];
    
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.font = HScaleFont(15);
    titleLabel2.textColor = kDefaultBlackTextColor;
    titleLabel2.text = @"医院热门推荐";
    [self addSubview:titleLabel2];
   
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineLabel.mas_bottom).offset(HScaleHeight(10.5));
        make.height.mas_equalTo(HScaleHeight(15));
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.hotHospital mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
    
        make.top.mas_equalTo(titleLabel2.mas_bottom);
    }];
    
}

- (void)setSpecialArray:(NSArray *)specialArray {
    
    if (_specialArray.count == 0) {
        
        _specialArray = specialArray;
        
        for (NSInteger index = 0; index < specialArray.count; index++) {
            
            GHHospitalSpecialDepartmentModel *model = [specialArray objectOrNilAtIndex:index];
            
            GHSearchHospitalButtonView *buttonView = [[GHSearchHospitalButtonView alloc] init];
            buttonView.model = model;
            buttonView.actionButton.tag = index;
            
            [self addSubview:buttonView];
            
            [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo((SCREENWIDTH - 20) / 5.f);
                make.top.mas_equalTo(self.scrollView.mas_bottom).offset(HScaleHeight(74));
                make.height.mas_equalTo(HScaleHeight(56));
                make.left.mas_equalTo(10 + ((SCREENWIDTH - 20) / 5.f) * index);
            }];
            
            [buttonView.actionButton addTarget:self action:@selector(clickSpecialAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }
    
}

- (void)clickSpecialAction:(UIButton *)sender {
    
    [MobClick event:@"Search_Hospital_Hot"];
    
    GHHospitalSpecialDepartmentModel *model = [self.specialArray objectOrNilAtIndex:sender.tag];
    
    GHSpecialDepartmentHospitalViewController *vc = [[GHSpecialDepartmentHospitalViewController alloc] init];
    vc.choiceDepartment = ISNIL(model.name);
    
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    GHHomeBannerModel *model = [self.bannerArray objectOrNilAtIndex:index];
    
    if (model.activityUrl.length > 0) {
        
        GHCommonWebViewController *vc = [[GHCommonWebViewController alloc] init];
        vc.navTitle = @"大众星医";
        vc.urlStr = [ISNIL(model.activityUrl) stringByReplacingOccurrencesOfString:@" " withString:@""];;
        
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    }
    
}
- (void)setupRecommendHospitalModelArry:(NSMutableArray *)arry
{
    
    if (arry.count == 2) {
        
        return;
    }
    if (arry.count > 2) {
        [self.hotHospital mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HScaleHeight(220));
        }];
    }
    else if (arry.count <= 2)
    {
        [self.hotHospital mas_updateConstraints:^(MASConstraintMaker *make) {
                   
            make.height.mas_equalTo(HScaleHeight(106));
         
        }];
    }
    [self.hotHospital recommendHospitalModelArry:arry];
}
- (void)setupScrollViewWithModelArray:(NSArray *)modelArray {
    
    self.bannerArray = modelArray;
    
    NSMutableArray *imageUrlArray = [[NSMutableArray alloc] init];
    for (GHHomeBannerModel *model in modelArray) {
        [imageUrlArray addObject:ISNIL(model.url)];
    }
    
    [self.scrollView setImageURLStringsGroup:imageUrlArray];
    
}
+ (NSMutableArray *)getmodelarry
{
    NSMutableArray *allarry = [NSMutableArray arrayWithCapacity:0];
    NSArray *titlearry = @[@"儿科",@"妇产科",@"皮肤科",@"美容整形科",@"口腔科"];
    NSArray *imagearry = @[@"pediatric",@"gynecology",@"dermatology",@"orthopaedic",@"kouqiangke"];
    for (NSInteger index = 0; index < titlearry.count; index ++) {
        GHHospitalSpecialDepartmentModel *model = [[GHHospitalSpecialDepartmentModel alloc]init];
        model.name = [titlearry objectAtIndex:index];
        model.iconUrl = imagearry[index];
//        if (index == 0) {
//            model.modelId = imagearry[index];
//        }
//        else if (index == 1)
//        {
//
//        }
//        else if (index == 2)
//        {
//
//        }
//        else if (index == 3)
//        {
//
//        }
//        else if (index == 4)
//        {
//
//        }
        [allarry addObject:model];
    
    }
    return allarry;
}
- (void)clickSearchAction {
    
    GHNSearchHotViewController *vc = [[GHNSearchHotViewController alloc] init];
    
    vc.type = GHNSearchHotType_Hospital;
    
    [self.viewController.navigationController pushViewController:vc animated:false];
    
}
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 1;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
    
}

- (GHHotRecommendedView *)hotHospital
{
    if (!_hotHospital) {
        _hotHospital = [[GHHotRecommendedView alloc]init];
        [self addSubview:_hotHospital];
    }
    return _hotHospital;
}
@end
