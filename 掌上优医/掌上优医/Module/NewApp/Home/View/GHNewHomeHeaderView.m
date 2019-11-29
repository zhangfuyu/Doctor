//
//  GHNewHomeHeaderView.m
//  掌上优医
//
//  Created by apple on 2019/7/31.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewHomeHeaderView.h"

#import "SDCycleScrollView.h"
#import "GHHomeModuleButtonView.h"

#import "GHNSearchSicknessViewController.h"
#import "GHNSearchDoctorViewController.h"
#import "GHSearchHospitalViewController.h"
#import "GHNInformationListViewController.h"

#import "GHNDiseaseListViewController.h"

#import "GHHomeBannerModel.h"
#import "GHSearchViewController.h"
#import "GHNewNInformationViewController.h"
#import "GHShareWebViewController.h"
#import "GHHomeHotCommentViewController.h"

#import "GHNewSearchDoctorViewController.h"

@interface GHNewHomeHeaderView()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *scrollView;

/**
 <#Description#>
 */
@property (nonatomic, strong) NSArray *bannerArray;


@end

@implementation GHNewHomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self setupUI];

    }
    return self;
}
- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backimage = [[UIImageView alloc]init];
    backimage.image = [UIImage imageNamed:@"矩形 14"];
    [self addSubview:backimage];
    
    [backimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(HScaleHeight(41));
    }];
    
    
     NSArray *imageArray = @[@"home_sickness", @"home_doctor",@"home_hospital" , @"home_information"];
        NSArray *titleArray = @[@"查疾病", @"找医生", @"搜医院", @"健康直播"];
        
        for (NSInteger index = 0; index < titleArray.count; index++) {
            
            GHHomeModuleButtonView *buttonView = [[GHHomeModuleButtonView alloc] initWithImageName:[imageArray objectOrNilAtIndex:index] withTitle:[titleArray objectOrNilAtIndex:index]];
            
            [self addSubview:buttonView];
            
            [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
                
    //            make.width.mas_equalTo((SCREENWIDTH - 32) / 3.0 );
                make.width.mas_equalTo((SCREENWIDTH - HScaleHeight(30)) / 4.f);
                make.top.mas_equalTo(HScaleHeight(13));
    //            make.bottom.mas_equalTo(lineLabel.mas_top).offset(HScaleHeight(-12));
                make.height.mas_equalTo(HScaleHeight(60));
                make.left.mas_equalTo(16 + ((SCREENWIDTH - HScaleHeight(30)) / 4.f) * index);
    //            make.left.mas_equalTo(16 + (SCREENWIDTH - 32) / 3.f  * index);
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
                    [buttonView.actionButton addTarget:self action:@selector(Healthlive) forControlEvents:UIControlEventTouchUpInside];
                    break;
                    
                default:
                    break;
            }
            
        }
        
    
    
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(HScaleHeight(15), HScaleHeight(92) , SCREENWIDTH - HScaleHeight(30), HScaleHeight(154)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    scrollView.autoScrollTimeInterval = 5;
    scrollView.isCornerRadius = YES;
    scrollView.layer.cornerRadius = HScaleHeight(5);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.currentPageDotColor = [UIColor whiteColor];
//    scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    scrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:0.6];
    scrollView.pageControlBottomOffset = 12;
    scrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:.6];
    scrollView.currentPageDotColor = [UIColor whiteColor];
    scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    scrollView.imageSize = CGSizeMake(SCREENWIDTH - HScaleHeight(30), HScaleHeight(154));
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
//    UILabel *lineLabel = [[UILabel alloc] init];
//    lineLabel.backgroundColor = kDefaultLineViewColor;
//    [self addSubview:lineLabel];
//    
//    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(self.mas_bottom);
//        make.height.mas_equalTo(HScaleHeight(10));
//    }];
    
    
   GHHomeModuleButtonView *buttonView = [[GHHomeModuleButtonView alloc] initWithImageName:@"矩形 9_slices" withTitle:@"疾病"];
   [buttonView.actionButton addTarget:self action:@selector(clickSicknessAction) forControlEvents:UIControlEventTouchUpInside];

   [self addSubview:buttonView];
              
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HScaleHeight(77));
        make.top.mas_equalTo(scrollView.mas_bottom).offset(HScaleHeight(46));
        make.height.mas_equalTo(HScaleHeight(60));
        make.width.mas_equalTo(HScaleHeight(49));
    }];
    
    GHHomeModuleButtonView *doctorView = [[GHHomeModuleButtonView alloc] initWithImageName:@"医生" withTitle:@"医生"];
    [doctorView.actionButton addTarget:self action:@selector(clickDoctorAction) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:doctorView];
               
     [doctorView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(HScaleHeight(41));
         make.top.mas_equalTo(scrollView.mas_bottom).offset(HScaleHeight(123));
         make.height.mas_equalTo(HScaleHeight(60));
         make.width.mas_equalTo(HScaleHeight(49));
     }];
    
    GHHomeModuleButtonView *hospitalView = [[GHHomeModuleButtonView alloc] initWithImageName:@"医院" withTitle:@"医院"];
    [hospitalView.actionButton addTarget:self action:@selector(clickHospitalAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hospitalView];
               
     [hospitalView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(HScaleHeight(65));
         make.top.mas_equalTo(scrollView.mas_bottom).offset(HScaleHeight(204));
         make.height.mas_equalTo(HScaleHeight(60));
         make.width.mas_equalTo(HScaleHeight(49));
     }];
    
    
    GHHomeModuleButtonView *evaluation = [[GHHomeModuleButtonView alloc] initWithImageName:@"评论" withTitle:@"评价"];
    [evaluation.actionButton addTarget:self action:@selector(homehotcomment) forControlEvents:UIControlEventTouchUpInside];

       [self addSubview:evaluation];
                  
        [evaluation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-HScaleHeight(75));
            make.top.mas_equalTo(scrollView.mas_bottom).offset(HScaleHeight(46));
            make.height.mas_equalTo(HScaleHeight(60));
            make.width.mas_equalTo(HScaleHeight(49));
        }];
    
    GHHomeModuleButtonView *information = [[GHHomeModuleButtonView alloc] initWithImageName:@"资讯" withTitle:@"资讯"];
    [information.actionButton addTarget:self action:@selector(clickInformationAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:information];
               
     [information mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.mas_equalTo(self.mas_right).offset(-HScaleHeight(41));
         make.top.mas_equalTo(scrollView.mas_bottom).offset(HScaleHeight(123));
         make.height.mas_equalTo(HScaleHeight(60));
         make.width.mas_equalTo(HScaleHeight(49));
     }];
    
    GHHomeModuleButtonView *goods = [[GHHomeModuleButtonView alloc] initWithImageName:@"商品" withTitle:@"商品"];
    [goods.actionButton addTarget:self action:@selector(goodsInformationAction) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:goods];
                  
        [goods mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-HScaleHeight(67));
            make.top.mas_equalTo(scrollView.mas_bottom).offset(HScaleHeight(204));
            make.height.mas_equalTo(HScaleHeight(60));
            make.width.mas_equalTo(HScaleHeight(49));
        }];
    
    
    UIImageView *ai_image = [[UIImageView alloc]init];
    ai_image.image = [UIImage imageNamed:@"矩形_AI"];
    [self addSubview:ai_image];
    
    [ai_image mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(scrollView.mas_bottom).offset(HScaleHeight(82));
           make.size.mas_equalTo(CGSizeMake(HScaleHeight(156), HScaleHeight(156)));
           make.centerX.mas_equalTo(self.mas_centerX);
       }];
    
    UIButton *aiButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [aiButton addTarget:self action:@selector(clickSearchAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:aiButton];
    [aiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scrollView.mas_bottom).offset(HScaleHeight(82));
      make.size.mas_equalTo(CGSizeMake(HScaleHeight(156), HScaleHeight(156)));
      make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
//    UILabel *titleLabel = [[UILabel alloc] init];
//    [self addSubview:titleLabel];
//    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"精选内容"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 18] ? [UIFont fontWithName:@"PingFangSC-Semibold" size: 18] : [UIFont  systemFontOfSize:18],NSForegroundColorAttributeName: kDefaultBlackTextColor}];
//    
//    titleLabel.attributedText = string;
//    
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(-15);
//        make.height.mas_equalTo(25);
//        make.bottom.mas_equalTo(0);
//        
//        
//    }];
    
    
}
//评价
- (void)homehotcomment
{
    [self.viewController.navigationController pushViewController:[GHHomeHotCommentViewController new] animated:YES];
}
//智能搜索
- (void)clickSearchAction {
    
    [MobClick event:@"Home_Search"];
    
    GHSearchViewController *vc = [[GHSearchViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:false];
    
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
    
    GHNewSearchDoctorViewController *vc = [[GHNewSearchDoctorViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}

// 找医院
- (void)clickHospitalAction {
    
    [MobClick event:@"Search_Hospital"];
    
    GHSearchHospitalViewController *vc = [[GHSearchHospitalViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:false];
    
}
//健康直播
- (void)Healthlive
{
    GHShareWebViewController *shareweb = [[GHShareWebViewController alloc]init];
    shareweb.titleText = @"健康直播";
    shareweb.shareText = @"专家在线科普，健康生活由您掌控";
    shareweb.urlStr = [[GHNetworkTool shareInstance]getShareWebViewWith:@"living.html"];;
    [self.viewController.navigationController pushViewController:shareweb animated:YES];
}
- (void)goodsInformationAction
{
    GHShareWebViewController *shareweb = [[GHShareWebViewController alloc]init];
    shareweb.titleText = @"星医严选";
    shareweb.shareText = @"多重专业测试，严选产品供您选择";
    shareweb.urlStr = @"https://shop44441773.youzan.com/v2/feature/3RJoXwD3hT";//[[GHNetworkTool shareInstance]getShareWebViewWith:@"shopping.html"];;
    [self.viewController.navigationController pushViewController:shareweb animated:YES];
}
// 优医讲堂
- (void)clickInformationAction {
    
    [MobClick event:@"Search_News"];
    
//    GHNInformationListViewController *vc = [[GHNInformationListViewController alloc] init];
    GHNewNInformationViewController *vc = [[GHNewNInformationViewController alloc] init];
    vc.title = @"医疗头条";
    vc.vcCanScroll = YES;
    vc.isShowHomepush = YES;
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
