//
//  GHHotRecommendedView.m
//  掌上优医
//
//  Created by apple on 2019/10/30.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHotRecommendedView.h"
#import "GHHotHospitalView.h"

@interface GHHotRecommendedView ()

@property (nonatomic , strong) UIScrollView *scroview;

@property (nonatomic , strong) NSMutableArray *hotArry;

@end

@implementation GHHotRecommendedView

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
        
    
        [self.scroview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
        
    }
    return self;
}
- (void)recommendHospitalModelArry:(NSMutableArray *)arry
{
    
    if (arry.count >= 2) {
        self.scroview.contentSize = CGSizeMake(HScaleHeight(538), CGRectGetHeight(self.bounds));
    }
    
    if (arry.count > 0) {
        if (self.hotArry.count > 0) {
            for (GHHotHospitalView *subview in self.hotArry) {
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
        GHHotHospitalView *subview = [[GHHotHospitalView alloc]init];
        subview.frame = CGRectMake(index % 2 * (HScaleHeight(248) + HScaleHeight(12)) + HScaleHeight(15), index / 2 * (HScaleHeight(90) + HScaleHeight(14)) + HScaleHeight(13), HScaleHeight(248), HScaleHeight(90));
        subview.model = arry[index];
        [self.scroview addSubview:subview];
        [self.hotArry addObject:subview];
    }
}
- (NSMutableArray *)hotArry
{
    if (!_hotArry) {
        _hotArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _hotArry;
}


- (UIScrollView *)scroview
{
    if (!_scroview) {
        _scroview = [[UIScrollView alloc]init];
        _scroview.showsVerticalScrollIndicator = NO;
        _scroview.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scroview];
    }
    return _scroview;
}

@end
