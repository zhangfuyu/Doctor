//
//  GHNewCommentsHeaderView.m
//  掌上优医
//
//  Created by apple on 2019/8/12.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewCommentsHeaderView.h"
#import "GHDoctorCommentListViewController.h"
@interface GHNewCommentsHeaderView ()
@property (nonatomic , strong)UILabel *answerNumber;
@end


@implementation GHNewCommentsHeaderView




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
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        UIView *bigLineview = [[UIView alloc]init];
        bigLineview.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        [self addSubview:bigLineview];
        [bigLineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(5);
        }];
        
        UIView *lineview = [[UIView alloc]init];
        lineview.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        [self addSubview:lineview];
        
        [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(49);
        }];
        
        
        
        self.answerNumber = [[UILabel alloc]init];
        [self addSubview:self.answerNumber];
        
       
        
        
        [self.answerNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(lineview.mas_top);
            make.top.mas_equalTo(bigLineview.mas_bottom);
            
        }];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.titleLabel.font = H12;
        [button setTitle:@"查看更多" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"click_right"] forState:UIControlStateNormal];
        button.titleLabel.font = H12;
        button.transform = CGAffineTransformMakeScale(-1, 1);
        button.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
        button.imageView.transform = CGAffineTransformMakeScale(-1, 1);
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
        [button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -8)];
        [button addTarget:self action:@selector(clickMoreCommentAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(bigLineview.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(90, 50));
        }];
    }
    return self;
}
- (void)setModel:(GHSearchDoctorModel *)model
{
    _model = model;
    
    NSString *comment = [NSString stringWithFormat:@"患者评价（共%@条）",model.commentCount];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:comment];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0, 4)];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(4, comment.length - 4)];
    [attri addAttribute:NSFontAttributeName value:H15 range:NSMakeRange(0, 4)];
    [attri addAttribute:NSFontAttributeName value:H12 range:NSMakeRange(4, comment.length - 4)];
    
    self.answerNumber.attributedText = attri;
    
}
- (void)clickMoreCommentAction {
    
    GHDoctorCommentListViewController *vc = [[GHDoctorCommentListViewController alloc] init];
    vc.model = self.model;
    [self.viewController.navigationController pushViewController:vc animated:true];
    
}
@end
