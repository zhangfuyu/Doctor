//
//  GHHomeCasesView.m
//  掌上优医
//
//  Created by apple on 2019/9/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHomeCasesView.h"
#import "GHGradientButton.h"
@interface GHHomeCasesView ()

@property (nonatomic ,strong)UIScrollView *scrollview;

@property (nonatomic , strong)NSMutableArray *itemBtnArr;

@property (nonatomic , strong) UIView *lineview;

@end

@implementation GHHomeCasesView

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
        
        
        UIImageView *backimage = [[UIImageView alloc]init];
        backimage.image = [UIImage imageNamed:@"mas_bottom"];
        [self addSubview:backimage];
        
        [backimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        
        
        
        self.scrollview = [[UIScrollView alloc]init];
        self.scrollview.backgroundColor = [UIColor whiteColor];
        
        self.scrollview.showsVerticalScrollIndicator = NO;
        self.scrollview.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:self.scrollview];
        self.scrollview.scrollEnabled = NO;
        
        [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];

        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

        maskLayer.frame = self.bounds;

        maskLayer.path = maskPath.CGPath;

        self.scrollview.layer.mask = maskLayer;
        
//        UIView *lineview = [[UIView alloc]init];
//        lineview.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
//        [self addSubview:lineview];
//        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(0);
//            make.height.mas_equalTo(.5);
//        }];
        
    }
    return self;
}

-(void)setTitleArry:(NSMutableArray *)titleArry
{
    _titleArry = titleArry;
    
    float scroWid = HScaleHeight(22);
    
    for (UIButton *choosebtn in self.itemBtnArr) {
        [choosebtn removeFromSuperview];
    }
    
    for (NSInteger index = 0; index < titleArry.count; index ++) {
        
        GHGradientButton *btn = [GHGradientButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        [btn setTitle:titleArry[index] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHexString:@"6A70FD"] forState:UIControlStateSelected];
        [btn setGradientColors:@[[UIColor colorWithHexString:@"827FFF"],[UIColor colorWithHexString:@"C461FE"]]];

       
        btn.titleLabel.font = HScaleBoldFont(18.67);
        [self.scrollview addSubview:btn];
        if (index == 0) {
           btn.selected = YES;
            
            self.lineview = [[UIView alloc]init];
            self.lineview.layer.cornerRadius = HScaleHeight(1);
            CAGradientLayer *gradient = [CAGradientLayer layer];
            //设置开始和结束位置(设置渐变的方向)
            gradient.startPoint = CGPointMake(0, 0);
            gradient.endPoint = CGPointMake(1, 0);
            gradient.frame =CGRectMake(0,0,HScaleHeight(30),HScaleHeight(2));
            gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"827FFF"].CGColor,(id)[UIColor colorWithHexString:@"C461FE"].CGColor,nil];
            [self.lineview.layer insertSublayer:gradient atIndex:0];
            [self.scrollview addSubview:self.lineview];
            [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(btn.mas_centerX);
                make.bottom.mas_equalTo(btn.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(HScaleHeight(30), HScaleHeight(2)));
            }];
       }
       else
       {
           [btn setGradientColors:@[[UIColor colorWithHexString:@"333333"]]];

       }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        float btnWid = [GHHomeCasesView getWidthWithString:titleArry[index] font:btn.titleLabel.font] + (HScaleHeight(19) * 2);
        
        btn.frame = CGRectMake(scroWid, 0, btnWid, CGRectGetHeight(self.bounds));
        
        scroWid += btnWid;
//        scroWid += 48;
        [self.itemBtnArr addObject:btn];
    }
    
    self.scrollview.contentSize = CGSizeMake(scroWid + 15, CGRectGetHeight(self.bounds));
}
- (void)setSelectBtnTag:(NSInteger)selectBtnTag
{
    _selectBtnTag = selectBtnTag;
    GHGradientButton *clickBtn = (GHGradientButton *)[self.itemBtnArr objectOrNilAtIndex:selectBtnTag];
    [self btnClick:clickBtn];
}
- (void)btnClick:(GHGradientButton *)sender
{
    for (GHGradientButton *clickBtn in self.itemBtnArr) {
        if (clickBtn.tag == sender.tag) {
            
            [self.lineview mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(sender.mas_centerX);
                make.bottom.mas_equalTo(sender.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(HScaleHeight(30), HScaleHeight(2)));
            }];
            
            clickBtn.selected = YES;
            [clickBtn setGradientColors:@[[UIColor colorWithHexString:@"827FFF"],[UIColor colorWithHexString:@"C461FE"]]];
            [clickBtn setNeedsDisplay];
        }
        else
        {
            clickBtn.selected = NO;
            [clickBtn setGradientColors:@[[UIColor colorWithHexString:@"333333"]]];
            [clickBtn setNeedsDisplay];
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
