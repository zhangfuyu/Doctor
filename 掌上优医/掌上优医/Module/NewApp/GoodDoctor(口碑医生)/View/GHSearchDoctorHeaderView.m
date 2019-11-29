//
//  GHSearchDoctorHeaderView.m
//  掌上优医
//
//  Created by apple on 2019/10/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHSearchDoctorHeaderView.h"
#import "SDCycleScrollView.h"
#import "GHHomeBannerModel.h"
#import "GHNSearchHotViewController.h"
#import "GHHotDoctorView.h"

@interface GHSearchDoctorHeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *scrollView;

@property (nonatomic, strong) NSArray *bannerArray;

@property (nonatomic, strong) NSMutableArray *hotArry;


@end

@implementation GHSearchDoctorHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatui];
    }
    return self;
}
- (void)creatui
{
     SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, HScaleHeight(160)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
     scrollView.autoScrollTimeInterval = 5;
     scrollView.backgroundColor = [UIColor whiteColor];
     scrollView.currentPageDotColor = [UIColor whiteColor];
//     scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
     scrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:0.6];
     scrollView.pageControlBottomOffset = HScaleHeight(37 - 12);
     scrollView.pageDotColor = [UIColor colorWithWhite:1 alpha:.6];
     scrollView.currentPageDotColor = [UIColor whiteColor];
     scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
     scrollView.imageSize = CGSizeMake(SCREENWIDTH, HScaleHeight(160));
     [self addSubview:scrollView];
     self.scrollView = scrollView;
    
    
  UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
  searchButton.titleLabel.font = HScaleFont(15);
  [searchButton setTitle:@" 搜索医生姓名" forState:UIControlStateNormal];
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
        
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.font = HScaleFont(15);
    titleLabel2.textColor = kDefaultBlackTextColor;
    titleLabel2.text = @"医生热门推荐";
    [self addSubview:titleLabel2];
     [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(self.scrollView.mas_bottom).offset(HScaleHeight(41));
         make.height.mas_equalTo(HScaleHeight(15));
         make.left.mas_equalTo(15);
         make.right.mas_equalTo(-15);
         
     }];
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = kDefaultLineViewColor;
    [self addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(HScaleHeight(5));
    }];
     
}
- (void)setupRecommendDoctorModelArry:(NSMutableArray *)arry
{
    
    if (arry.count > 0) {
        if (self.hotArry.count > 0) {
            for (GHHotDoctorView *subview in self.hotArry) {
                [subview removeFromSuperview];
            }
            [self.hotArry removeAllObjects];
            [self updateSubviewWith:arry];

           
        }
        else
        {
            [self updateSubviewWith:arry];
            
        }
    }
}

- (void)updateSubviewWith:(NSMutableArray *)arry
{
    for (NSInteger index = 0; index < arry.count; index ++) {
        GHHotDoctorView *subview = [[GHHotDoctorView alloc]init];
        subview.frame = CGRectMake(index % 2 * (HScaleHeight(167) + HScaleHeight(11.5)) + HScaleHeight(15),HScaleHeight(215) + index / 2 * (HScaleHeight(100) + HScaleHeight(14)) + HScaleHeight(14), HScaleHeight(167), HScaleHeight(100));
        GHDoctorRecommendedModel *model = arry[index];
        model.index = [NSString stringWithFormat:@"%ld",index + 1] ;
        subview.model = model;
        [self addSubview:subview];
        [self.hotArry addObject:subview];
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
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    GHHomeBannerModel *model = [self.bannerArray objectOrNilAtIndex:index];
    
    if (model.activityUrl.length > 0) {
        
        GHCommonWebViewController *vc = [[GHCommonWebViewController alloc] init];
        vc.navTitle = @"大众星医";
        vc.urlStr = [ISNIL(model.activityUrl) stringByReplacingOccurrencesOfString:@" " withString:@""];;
        
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    }
    
}
- (void)clickSearchAction
{
    GHNSearchHotViewController *vc = [[GHNSearchHotViewController alloc] init];
       
    vc.type = GHNSearchHotType_Doctor;
       
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
- (NSMutableArray *)hotArry
{
    if (!_hotArry) {
        _hotArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _hotArry;
}
@end
