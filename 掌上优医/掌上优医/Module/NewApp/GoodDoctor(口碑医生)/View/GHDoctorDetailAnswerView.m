//
//  GHDoctorDetailAnswerView.m
//  掌上优医
//
//  Created by GH on 2019/5/23.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHDoctorDetailAnswerView.h"
#import "GHQuestionViewController.h"
#import "GHQuestionListViewController.h"

@interface GHDoctorDetailAnswerView ()

@property (nonatomic, strong) UIView *questionView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UILabel *answerCountLabel;

@end

@implementation GHDoctorDetailAnswerView

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeScaleToFill;
    iconImageView.image = [UIImage imageNamed:@"icon_doctor_detail_question"];
    [self addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(32);
        make.top.mas_equalTo(12);
        make.centerX.mas_equalTo(self);
    }];
    
    UIButton *questionsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    questionsButton.titleLabel.font = H14;
    questionsButton.backgroundColor = kDefaultBlueColor;
    questionsButton.layer.cornerRadius = 4;
    questionsButton.layer.masksToBounds = true;
    [questionsButton setTitle:@"我要提问" forState:UIControlStateNormal];
    [self addSubview:questionsButton];
    
    [questionsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(81);
        make.bottom.mas_equalTo(-12);
    }];
    
    [questionsButton addTarget:self action:@selector(clickQuestionAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *questionView = [[UIView alloc] init];
    questionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:questionView];
    
    [questionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    self.questionView = questionView;
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.font = H13;
    tipsLabel.textColor = [UIColor whiteColor];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.backgroundColor = UIColorHex(0x01D4B9);
    tipsLabel.layer.cornerRadius = 4;
    tipsLabel.layer.masksToBounds = true;
    tipsLabel.text = @"问答";
    [questionView addSubview:tipsLabel];
    
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(38);
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(12);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = HM15;
    [questionView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(tipsLabel);
        make.left.mas_equalTo(tipsLabel.mas_right).offset(8);
        make.right.mas_equalTo(-16);
    }];
    self.titleLabel = titleLabel;
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = kDefaultGrayTextColor;
    descLabel.font = H13;
    [questionView addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(19);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(4);
        make.left.mas_equalTo(titleLabel);
        make.right.mas_equalTo(-16);
    }];
    self.descLabel = descLabel;
    
    
    UILabel *answerCountLabel = [[UILabel alloc] init];
    answerCountLabel.textColor = kDefaultGrayTextColor;
    answerCountLabel.font = H12;
    [questionView addSubview:answerCountLabel];
    
    [answerCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(descLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(titleLabel);
        make.right.mas_equalTo(-16);
    }];
    self.answerCountLabel = answerCountLabel;
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:actionButton];
    
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    [actionButton addTarget:self action:@selector(clickQuestionAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.questionView.hidden = true;
//    self.titleLabel.text = @"小孩头痛发热应该注意什么？";
//    self.descLabel.text = @"小孩发热应该注意通风、不要穿太多、注意...小孩发热应该注意通风、不要穿太多、注意...";
//    self.answerCountLabel.text = @"7个回答";
}

- (void)setModel:(GHQuestionModel *)model {
    
    _model = model;
    
    self.questionView.hidden = false;
    
    self.titleLabel.text = ISNIL(model.title);
    
    self.descLabel.text = ISNIL(model.content);
    
    self.answerCountLabel.text = [NSString stringWithFormat:@"%ld个回答", [model.discussCount integerValue]];
    
}

- (void)clickQuestionAction {
    
    if (self.questionView.hidden == true) {
        
        NSLog(@"我要提问");
        
        if ([GHUserModelTool shareInstance].isLogin) {
            
            GHQuestionViewController *vc = [[GHQuestionViewController alloc] init];
            vc.doctorId = self.doctorId;
            vc.doctorName = self.doctorName;
            [self.viewController.navigationController pushViewController:vc animated:true];
            
        } else {
            
            GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
            [self.viewController presentViewController:vc animated:true completion:nil];
            
        }
        

        
    } else {
        
        NSLog(@"问答列表");
        
        GHQuestionListViewController *vc = [[GHQuestionListViewController alloc] init];
        vc.doctorId = self.doctorId;
        vc.doctorName = self.doctorName;
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    }
    

    
}

@end
