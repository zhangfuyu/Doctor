//
//  GHNewCasesView.m
//  掌上优医
//
//  Created by apple on 2019/8/7.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewCasesView.h"

@interface GHNewCasesView ()

@property (nonatomic ,strong)UIScrollView *scrollview;

@property (nonatomic , strong)NSMutableArray *itemBtnArr;

@end

@implementation GHNewCasesView

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
        
        self.scrollview = [[UIScrollView alloc]init];
        self.scrollview.backgroundColor = [UIColor whiteColor];
        
        self.scrollview.showsVerticalScrollIndicator = NO;
        self.scrollview.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:self.scrollview];
    
        
        [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        
        UIView *lineview = [[UIView alloc]init];
        lineview.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        [self addSubview:lineview];
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(.5);
        }];
        
    }
    return self;
}

-(void)setTitleArry:(NSMutableArray *)titleArry
{
    _titleArry = titleArry;
    
    float scroWid = 15;
    
    for (UIButton *choosebtn in self.itemBtnArr) {
        [choosebtn removeFromSuperview];
    }
    
    for (NSInteger index = 0; index < titleArry.count; index ++) {
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        [btn setTitle:titleArry[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"6A70FD"] forState:UIControlStateSelected];
        [btn setBackgroundColor:[UIColor colorWithHexString:@"F2F2F2"]];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 2;
        [self.scrollview addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        float btnWid = [GHNewCasesView getWidthWithString:titleArry[index] font:btn.titleLabel.font] + 18;

        btn.frame = CGRectMake(scroWid, 15, btnWid, 23);
        
        if (index == 0) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor colorWithHexString:@"DCDDFF"]];
            
        }
        scroWid += btnWid;
        scroWid += 10;
        [self.itemBtnArr addObject:btn];
    }
    if (scroWid + 5 < CGRectGetWidth(self.bounds)) {
            self.scrollview.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));

    }
    else
    {
        self.scrollview.contentSize = CGSizeMake(scroWid + 5, CGRectGetHeight(self.bounds));

    }
}

- (void)btnClick:(UIButton *)sender
{
    for (UIButton *clickBtn in self.itemBtnArr) {
        if (clickBtn.tag == sender.tag) {
            [clickBtn setBackgroundColor:[UIColor colorWithHexString:@"DCDDFF"]];
            clickBtn.selected = YES;
        }
        else
        {
            clickBtn.selected = NO;
            [clickBtn setBackgroundColor:[UIColor colorWithHexString:@"F2F2F2"]];

        }
    }
    
    //点击按钮在滑动视图中居中显示
//    CGRect centerRect = CGRectMake(sender.center.x - CGRectGetWidth(self.scrollview.bounds)/2, 0, CGRectGetWidth(self.scrollview.bounds), CGRectGetHeight(self.scrollview.bounds));
//    [self.scrollview scrollRectToVisible:centerRect animated:YES];
    
    
    if (self.clickTypeBlock) {
        self.clickTypeBlock(sender.titleLabel.text);
    }
}

- (NSMutableArray *)itemBtnArr
{
    if (!_itemBtnArr) {
        _itemBtnArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _itemBtnArr;
}
#pragma mark Private
/**
 计算字符串长度
 
 @param string string
 @param font font
 @return 字符串长度
 */
+ (CGFloat)getWidthWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}

@end
