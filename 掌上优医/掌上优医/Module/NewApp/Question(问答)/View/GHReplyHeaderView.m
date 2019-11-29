//
//  GHReplyHeaderView.m
//  掌上优医
//
//  Created by GH on 2019/5/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHReplyHeaderView.h"

@interface GHReplyHeaderView ()

@property (nonatomic, strong) UIImageView *userHeadPortraitImageView;

@property (nonatomic, strong) UILabel *userNicknameLabel;

@property (nonatomic, strong) UILabel *answerTimeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation GHReplyHeaderView

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 20;
    headPortraitImageView.layer.masksToBounds = true;
    headPortraitImageView.backgroundColor = kDefaultGaryViewColor;
    [self addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
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
        make.top.mas_equalTo(10);
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
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(0);
        make.right.mas_equalTo(-16);
    }];
    self.answerTimeLabel = timeLabel;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.backgroundColor = [UIColor whiteColor];
    contentLabel.font = H15;
    contentLabel.textColor = kDefaultBlackTextColor;
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(63);
    }];
    self.contentLabel = contentLabel;
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.textColor = kDefaultBlackTextColor;
    countLabel.font = HM15;
    countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:countLabel];
    
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(contentLabel.mas_bottom).offset(20);
        make.centerX.mas_equalTo(contentLabel);
    }];
    self.countLabel = countLabel;
    
    UILabel *leftLineLabel = [[UILabel alloc] init];
    leftLineLabel.backgroundColor = kDefaultLineViewColor;
    [self addSubview:leftLineLabel];
    
    [leftLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(countLabel.mas_left).offset(-12);
        make.centerY.mas_equalTo(countLabel);
    }];
    
    UILabel *rightLineLabel = [[UILabel alloc] init];
    rightLineLabel.backgroundColor = kDefaultLineViewColor;
    [self addSubview:rightLineLabel];
    
    [rightLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(-16);
        make.left.mas_equalTo(countLabel.mas_right).offset(12);
        make.centerY.mas_equalTo(countLabel);
    }];
    
    
}

- (void)setModel:(GHAnswerModel *)model {
    
    _model = model;
    
    self.userNicknameLabel.text = ISNIL(model.authorName);
    self.answerTimeLabel.text = [GHTimeDealTool getShowQuestionTimeWithTimeStr:ISNIL(model.createDate)];
    [self.userHeadPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.authorHeaderUrl)) placeholderImage:[UIImage imageNamed:@"personcenter_user_default"]];
    
    if (model.replyArray.count == 0) {
        self.countLabel.text = @"暂无回复";
    } else {
        self.countLabel.text = [NSString stringWithFormat:@"全部%ld条回复", model.replyArray.count];
    }
    
    
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = 21;
    paragraphStyle.minimumLineHeight = 21;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:ISNIL(model.content)];
    
    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, attr.string.length)];
    
    [attr addAttributes:@{NSFontAttributeName: H15} range:NSMakeRange(0, attr.string.length)];
    
    self.contentLabel.attributedText = attr;
    
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([model.contentHeight floatValue]);
    }];
    
}

@end
