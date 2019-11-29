//
//  GHMustUpdate.m
//  掌上优医
//
//  Created by apple on 2019/9/10.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHMustUpdate.h"

@implementation GHMustUpdate

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
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
        
        UIImageView *bigimage = [[UIImageView alloc]initWithFrame:CGRectZero];
        bigimage.image = [UIImage imageNamed:@"mustUpdate"];
        [self addSubview:bigimage];
        
        [bigimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(300, 334));
        }];
        
        
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clickBtn addTarget:self action:@selector(pushAppStory) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clickBtn];
        
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(300, 334));
        }];
        
    }
    return self;
}
- (void)pushAppStory
{
    NSString *str = kAppStoreItunesurl;//[NSString stringWithFormat:
                     
                     //@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1455600264"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    self.frame = window.bounds;
    [window addSubview:self];
}
@end
