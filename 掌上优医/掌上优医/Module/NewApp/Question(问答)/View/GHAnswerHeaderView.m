//
//  GHAnswerHeaderView.m
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAnswerHeaderView.h"

@interface GHAnswerHeaderView ()

@property (nonatomic, strong) UIImageView *userHeadPortraitImageView;

@property (nonatomic, strong) UILabel *userNicknameLabel;

@property (nonatomic, strong) UILabel *questionTimeLabel;

@property (nonatomic, strong) UILabel *questionTitleLabel;

@property (nonatomic, strong) UILabel *questionDescriptionLabel;

@property (nonatomic, strong) UILabel *answerCountLabel;

@end

@implementation GHAnswerHeaderView

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 20;
    headPortraitImageView.layer.masksToBounds = true;
    headPortraitImageView.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(26);
        make.width.height.mas_equalTo(40);
        make.left.mas_equalTo(16);
    }];
    self.userHeadPortraitImageView = headPortraitImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = HM15;
    [self addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(10);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(28);
        make.right.mas_equalTo(-16);
    }];
    self.userNicknameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = kDefaultGrayTextColor;
    timeLabel.font = H12;
    [self addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(10);
        make.height.mas_equalTo(17);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(-16);
    }];
    self.questionTimeLabel = timeLabel;
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:lineLabel2];
    
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(80);
        make.height.mas_equalTo(1);
    }];
    
    UIView *questionView = [[UIView alloc] init];
    questionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:questionView];
    
    [questionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(81);
    }];
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    tipsLabel.font = H13;
    tipsLabel.textColor = [UIColor whiteColor];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.backgroundColor = UIColorHex(0x01D4B9);
    tipsLabel.layer.cornerRadius = 4;
    tipsLabel.layer.masksToBounds = true;
    tipsLabel.text = @"问";
    [questionView addSubview:tipsLabel];
    
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(25);
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(12);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = HM15;
    [questionView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(tipsLabel);
        make.left.mas_equalTo(tipsLabel.mas_right).offset(21);
        make.right.mas_equalTo(-16);
    }];
    self.questionTitleLabel = titleLabel;
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = kDefaultGrayTextColor;
    descLabel.font = H13;
    descLabel.numberOfLines = 0;
    [questionView addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (void)setModel:(GHQuestionModel *)model {
    
    _model = model;
    
    self.userNicknameLabel.text = ISNIL(model.authorName);
    self.questionTimeLabel.text = [GHTimeDealTool getShowQuestionTimeWithTimeStr:ISNIL(model.createDate)];
    [self.userHeadPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.authorHeaderUrl)) placeholderImage:[UIImage imageNamed:@"personcenter_user_default"]];
    
    self.questionTitleLabel.text = ISNIL(model.title);
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = 18;
    paragraphStyle.minimumLineHeight = 18;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:ISNIL(self.model.content)];
    
    [attr2 addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr2.string.length)];
    
    self.questionDescriptionLabel.attributedText = attr2;
    
    self.questionDescriptionLabel.text = ISNIL(model.content);
    
    self.answerCountLabel.text = [NSString stringWithFormat:@"%ld 个回答", [model.answerNums integerValue]];

    
}

@end
