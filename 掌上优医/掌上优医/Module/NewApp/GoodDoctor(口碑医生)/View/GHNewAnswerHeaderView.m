//
//  GHNewAnswerHeaderView.m
//  掌上优医
//
//  Created by apple on 2019/8/12.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewAnswerHeaderView.h"
#import "GHQuestionViewController.h"
#import "GHQuestionListViewController.h"

@interface GHNewAnswerHeaderView ()

@property (nonatomic , strong)UILabel *answerNumber;

@end

@implementation GHNewAnswerHeaderView

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
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:@"问答（共0条）"];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0, 2)];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(2, 5)];
        [attri addAttribute:NSFontAttributeName value:H15 range:NSMakeRange(0, 2)];
        [attri addAttribute:NSFontAttributeName value:H12 range:NSMakeRange(2, 5)];

        self.answerNumber.attributedText = attri;
        
        
        [self.answerNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(lineview.mas_top);
            
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
        [button addTarget:self action:@selector(cheakMoreAnswer) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(90, 50));
        }];
        
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clickBtn setTitle:@"发起问答" forState:UIControlStateNormal];
        clickBtn.titleLabel.font  = H12;
        [clickBtn setTitleColor:[UIColor colorWithHexString:@"6A70FD"] forState:UIControlStateNormal];
        clickBtn.layer.borderWidth = 1;
        clickBtn.layer.borderColor = [UIColor colorWithHexString:@"6A70FD"].CGColor;
        clickBtn.layer.cornerRadius = 15;
        [clickBtn addTarget:self action:@selector(clickPushAnswerView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clickBtn];
        
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90, 30));
            make.centerX.equalTo(self.mas_centerX);
            make.top.mas_equalTo(lineview.mas_bottom).offset(30);
        }];
        
        UIView *lineview3 = [[UIView alloc]init];
        lineview3.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        [self addSubview:lineview3];
        
        [lineview3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}
- (void)setProblemNums:(NSString *)problemNums
{
    _problemNums = problemNums;
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"问答（共%@条）",problemNums]];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0, 2)];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(2, 4+problemNums.length)];
    [attri addAttribute:NSFontAttributeName value:H15 range:NSMakeRange(0, 2)];
    [attri addAttribute:NSFontAttributeName value:H12 range:NSMakeRange(2, 4+problemNums.length)];
    
    self.answerNumber.attributedText = attri;
}

- (void)clickPushAnswerView
{
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHQuestionViewController *vc = [[GHQuestionViewController alloc] init];
        vc.doctorId = self.doctorId;
        //        vc.doctorName = self.doctorName;
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    
}

- (void)cheakMoreAnswer
{
    GHQuestionListViewController *vc = [[GHQuestionListViewController alloc] init];
    vc.doctorId = self.doctorId;
//    vc.doctorName = self.doctorName;
    [self.viewController.navigationController pushViewController:vc animated:true];
}

@end
