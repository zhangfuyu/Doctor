//
//  GHArticleInformationTableViewCell.m
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHArticleInformationTableViewCell.h"

@interface GHArticleInformationTableViewCell ()

@property (nonatomic, strong) UIImageView *articleTopicImageView;

@property (nonatomic, strong) UILabel *articleTitleLabel;

@property (nonatomic, strong) UILabel *articleTimeLabel;

@property (nonatomic, strong) UIButton *articleBrowseButton;

@property (nonatomic, strong) UIButton *actionButton;

@end

@implementation GHArticleInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    self.backgroundColor = kDefaultGaryViewColor;
    self.contentView.backgroundColor = kDefaultGaryViewColor;
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 4;
    contentView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.24].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0,1);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 4;
    [self.contentView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-3);
    }];
    
    UIImageView *topicImageView = [[UIImageView alloc] init];
    topicImageView.contentMode = UIViewContentModeScaleAspectFill;
    topicImageView.backgroundColor = [UIColor whiteColor];
    topicImageView.layer.cornerRadius = 5;
    topicImageView.layer.masksToBounds = true;
    [contentView addSubview:topicImageView];
    
    [topicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
        
    }];
    self.articleTopicImageView = topicImageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.numberOfLines = 2;
    [contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topicImageView.mas_right).offset(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(topicImageView);
        make.height.mas_equalTo(54);
    }];
    self.articleTitleLabel = titleLabel;

    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = H12;
    timeLabel.textColor = UIColorHex(0x9F9F9F);
    [contentView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topicImageView.mas_right).offset(16);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(topicImageView.mas_bottom);
    }];
    self.articleTimeLabel = timeLabel;
    
    UIButton *browserButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [browserButton setTitleColor:UIColorHex(0x505151) forState:UIControlStateNormal];
//    [browserButton setImage:[UIImage imageNamed:@"ic_homepage_watch_unselected"] forState:UIControlStateNormal];
//    [browserButton setImage:[UIImage imageNamed:@"ic_homepage_watch_selected"] forState:UIControlStateSelected];
    browserButton.titleLabel.font = H12;
    browserButton.userInteractionEnabled = false;
    [contentView addSubview:browserButton];
    
    [browserButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(topicImageView.mas_bottom);
    }];
    self.articleBrowseButton = browserButton;
    
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:actionButton];
    
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.actionButton = actionButton;

    self.actionButton.hidden = true;
}

- (void)setDelegate:(id<GHArticleInformationTableViewCellDelegate>)delegate {
    
    _delegate = delegate;
    
    self.actionButton.hidden = false;
    
}

- (void)clickAction {
 
    if ([self.delegate respondsToSelector:@selector(clickInformationModelWithModel:)]) {
        [self.delegate clickInformationModelWithModel:self.model];
    }
    
}

- (void)setModel:(GHArticleInformationModel *)model {
    
    _model = model;
    
    [self.articleTopicImageView sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.frontCoverUrl))];
    self.articleTimeLabel.text = [GHTimeDealTool getShowTimeWithTimeStr:ISNIL(model.gmtCreate)];
    [self.articleBrowseButton setTitle:[NSString stringWithFormat:@"浏览  %ld", [model.visitCount integerValue]] forState:UIControlStateNormal];
    
    self.articleBrowseButton.selected = [model.isVisit boolValue];
    
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = 23;
    paragraphStyle.minimumLineHeight = 23;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSString *shouldStr = ISNIL(model.title);
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:shouldStr];
    
    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, shouldStr.length)];
    
    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, shouldStr.length)];
    
    [attr addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15]} range:NSMakeRange(0, shouldStr.length)];
    
    self.articleTitleLabel.attributedText = attr;
    
    if ([shouldStr widthForFont:[UIFont boldSystemFontOfSize:15]] > (SCREENWIDTH - 166)) {
        
        [self.articleTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(47);
        }];
        
    } else {
        
        [self.articleTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(29);
        }];
        
    }
    
}

@end
