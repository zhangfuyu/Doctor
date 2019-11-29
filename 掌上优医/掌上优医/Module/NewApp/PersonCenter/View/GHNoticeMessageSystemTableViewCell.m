//
//  GHNoticeMessageSystemTableViewCell.m
//  掌上优医
//
//  Created by GH on 2018/11/1.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHNoticeMessageSystemTableViewCell.h"

@interface GHNoticeMessageSystemTableViewCell ()

@property (nonatomic, strong) UIImageView *headPortraitImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation GHNoticeMessageSystemTableViewCell

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
    
    self.contentView.backgroundColor = kDefaultGaryViewColor;
    self.backgroundColor = kDefaultGaryViewColor;
    
    
    UIImageView *headPortraitImageView = [[UIImageView alloc] init];
    headPortraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    headPortraitImageView.layer.cornerRadius = 20;
    headPortraitImageView.layer.masksToBounds = true;
    [self.contentView addSubview:headPortraitImageView];
    
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.width.height.mas_equalTo(40);
        make.left.mas_equalTo(16);
    }];
    self.headPortraitImageView = headPortraitImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = H17;
    [self.contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headPortraitImageView.mas_right).offset(12);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(headPortraitImageView);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = UIColorHex(0xAAAAAA);
    timeLabel.font = H12;
    timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(headPortraitImageView);
    }];
    self.timeLabel = timeLabel;
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = true;
    [self.contentView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(45);
        make.right.mas_equalTo(-62);
        make.top.mas_equalTo(65);
    }];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = H15;
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:contentLabel];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(8);
        make.right.bottom.mas_equalTo(-12);
    }];
    self.contentLabel = contentLabel;
    
}

- (void)setupContentText:(NSString *)text {
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = 21;
    paragraphStyle.minimumLineHeight = 21;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} range:NSMakeRange(0, text.length)];
    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, text.length)];
    
    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, text.length)];
    
    
    self.contentLabel.attributedText = attr;
    
}

- (void)setModel:(GHNoticeSystemModel *)model {
    
    _model = model;
    
    
    self.headPortraitImageView.image = [UIImage imageNamed:@"img_entry page_logo"];
    self.nameLabel.text = @"大众星医";
    
    [self setupContentText:ISNIL(model.content)];
    
//    NSString *birthdayStr = ISNIL(self.model.birthday);
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
//    NSDate *birthdayDate = [dateFormatter dateFromString:birthdayStr];
//    cell.descLabel.text = [birthdayDate stringWithFormat:@"yyyy-MM-dd"];
    
    self.timeLabel.text = [GHTimeDealTool getUTCFormateLocalDate:ISNIL(model.createDate)];
    
}

@end
