//
//  GHAnswerTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAnswerTableViewCell.h"

#import "GHReplyModel.h"
@interface GHAnswerTableViewCell ()

@property (nonatomic, strong) UIImageView *userHeadPortraitImageView;

@property (nonatomic, strong) UILabel *userNicknameLabel;

@property (nonatomic, strong) UILabel *answerTimeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *replyView;

@property (nonatomic, strong) UILabel *firstReplyLabel;

@property (nonatomic, strong) UILabel *secondReplyLabel;

@property (nonatomic, strong) UILabel *thirdReplyLabel;

@property (nonatomic, strong) UIButton *allReplyButton;

@end

@implementation GHAnswerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
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
    [self.contentView addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(26);
        make.width.height.mas_equalTo(40);
        make.left.mas_equalTo(16);
    }];
    self.userHeadPortraitImageView = headPortraitImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = HM15;
    [self.contentView addSubview:nameLabel];
    
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
    [self.contentView addSubview:timeLabel];
    
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
    [self.contentView addSubview:contentLabel];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(78);
    }];
    self.contentLabel = contentLabel;
    
    UIView *replyView = [[UIView alloc] init];
    replyView.backgroundColor = UIColorHex(0xF2FCFB);
    replyView.layer.cornerRadius = 4;
    replyView.layer.masksToBounds = true;
    replyView.layer.borderColor = RGBACOLOR(0,202,171,0.2).CGColor;
    replyView.layer.borderWidth = .5;
    [self.contentView addSubview:replyView];
    
    [replyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(-55);
    }];
    self.replyView = replyView;
    
    UIButton *allReplyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    allReplyButton.titleLabel.font = H13;
    [allReplyButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [allReplyButton setImage:[UIImage imageNamed:@"personcenter_right_arrow"] forState:UIControlStateNormal];
    allReplyButton.transform = CGAffineTransformMakeScale(-1, 1);
    allReplyButton.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
    allReplyButton.imageView.transform = CGAffineTransformMakeScale(-1, 1);
    [replyView addSubview:allReplyButton];
    
    [allReplyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(18);
        make.bottom.mas_equalTo(-10);
    }];
    self.allReplyButton = allReplyButton;
    
    UIButton *replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    replyButton.titleLabel.font = HM13;
    [replyButton setTitle:@"回复" forState:UIControlStateNormal];
    [replyButton setTitleColor:kDefaultBlackTextColor forState:UIControlStateNormal];
    [self.contentView addSubview:replyButton];
    
    [replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(60);
    }];
    [replyButton addTarget:self action:@selector(clickReplyAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    for (NSInteger index = 0; index < 3; index++) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = H13;
        titleLabel.textColor = kDefaultBlackTextColor;
        titleLabel.numberOfLines = 1;
        [replyView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        
        if (index == 0) {
            
            self.firstReplyLabel = titleLabel;
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(10);
            }];
            
        } else if (index == 1) {
            
            self.secondReplyLabel = titleLabel;
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.firstReplyLabel.mas_bottom).offset(8);
            }];
            
        } else if (index == 2) {
            
            self.thirdReplyLabel = titleLabel;
            [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.secondReplyLabel.mas_bottom).offset(8);
            }];
            
        }
        
    }
    
    
}

- (void)setModel:(GHAnswerModel *)model {
    
    _model = model;
    
    self.userNicknameLabel.text = ISNIL(model.authorName);
    self.answerTimeLabel.text = [GHTimeDealTool getShowQuestionTimeWithTimeStr:ISNIL(model.createDate)];
    [self.userHeadPortraitImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.authorHeaderUrl)) placeholderImage:[UIImage imageNamed:@"personcenter_user_default"]];
    

    
    if (model.replyArray.count > 0) {
        
        self.replyView.hidden = false;
        
        self.firstReplyLabel.hidden = true;
        self.secondReplyLabel.hidden = true;
        self.thirdReplyLabel.hidden = true;
        
        self.allReplyButton.hidden = true;
        
        NSMutableParagraphStyle *paragraphStyle2 = [NSMutableParagraphStyle new];
        paragraphStyle2.maximumLineHeight = 18;
        paragraphStyle2.minimumLineHeight = 18;
        paragraphStyle2.lineBreakMode = NSLineBreakByTruncatingTail;
        
        for (NSInteger index = 0; index < model.replyArray.count; index++) {
            
            GHReplyModel *replyModel = [model.replyArray objectOrNilAtIndex:index];
            
            NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:%@",replyModel.authorName,ISNIL(replyModel.content)]];
            
            [attr2 addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle2} range:NSMakeRange(0, attr2.string.length)];
            [attr2 addAttributes:@{NSForegroundColorAttributeName: UIColorHex(0x54D8E0)} range:NSMakeRange(0, replyModel.authorName.length)];
            
//            if ([replyModel.isMeReply boolValue] == true) {
//
//                [attr2 addAttributes:@{NSForegroundColorAttributeName: UIColorHex(0xFF6188)} range:NSMakeRange(0, 3)];
//
//            } else {
//
//                if (replyModel.authorName.length > 0) {
//                    [attr2 addAttributes:@{NSForegroundColorAttributeName: UIColorHex(0x54D8E0)} range:NSMakeRange(0, replyModel.authorName.length + 2)];
//
//                }
//
//            }
            
            if (index == 0) {
                self.firstReplyLabel.hidden = false;
                self.firstReplyLabel.attributedText = attr2;
            } else if (index == 1) {
                self.secondReplyLabel.hidden = false;
                self.secondReplyLabel.attributedText = attr2;
            } else if (index == 2) {
                self.thirdReplyLabel.hidden = false;
                self.thirdReplyLabel.attributedText = attr2;
            }
            
        }
        
        if (model.replyArray.count > 3) {
            
            self.allReplyButton.hidden = false;
            
            [self.allReplyButton setTitle:[NSString stringWithFormat:@"查看全部%ld条回复 ", model.replyArray.count] forState:UIControlStateNormal];
            
        }
        
    } else {
        
        self.replyView.hidden = true;
        
        self.firstReplyLabel.hidden = true;
        self.secondReplyLabel.hidden = true;
        self.thirdReplyLabel.hidden = true;
        
        self.allReplyButton.hidden = true;
        
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
    
    [self.replyView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([model.contentHeight floatValue] + 10 + 80);
    }];
    
}

- (void)clickReplyAction {
    
    NSLog(@"回复");
    
    if ([self.delegate respondsToSelector:@selector(clickReplyAnswerActionWithAnswerModel:)]) {
        [self.delegate clickReplyAnswerActionWithAnswerModel:self.model];
    }
    
}

@end
