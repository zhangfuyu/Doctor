//
//  GHQuestionTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHQuestionTableViewCell.h"

@interface GHQuestionTableViewCell ()

@property (nonatomic, strong) UILabel *questionTitleLabel;

@property (nonatomic, strong) UILabel *questionDescriptionLabel;

@property (nonatomic, strong) UILabel *answerCountLabel;

@end

@implementation GHQuestionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.contentView.backgroundColor = kDefaultGaryViewColor;
    
    UIView *questionView = [[UIView alloc] init];
    questionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:questionView];
    
    [questionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
    }];
    
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
    self.questionTitleLabel = titleLabel;
    
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
    self.questionDescriptionLabel = descLabel;
    
    
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
    

    
}

- (void)setModel:(GHQuestionModel *)model  {
    
    _model = model;
    
    self.questionTitleLabel.text = ISNIL(model.title);
    self.questionDescriptionLabel.text = ISNIL(model.content);
    self.answerCountLabel.text = [NSString stringWithFormat:@"%ld个回答", [model.answerNums integerValue]];
    
}

@end
