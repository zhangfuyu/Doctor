//
//  GHReplyTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHReplyTableViewCell.h"

@interface GHReplyTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GHReplyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H13;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
        make.right.mas_equalTo(-26);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-8);
    }];
    self.titleLabel = titleLabel;
    
}

- (void)setModel:(GHReplyModel *)model {
    
    _model = model;
    
    NSMutableParagraphStyle *paragraphStyle2 = [NSMutableParagraphStyle new];
    paragraphStyle2.maximumLineHeight = 18;
    paragraphStyle2.minimumLineHeight = 18;
    paragraphStyle2.lineBreakMode = NSLineBreakByTruncatingTail;
    
//    NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:ISNIL(model.showContent)];
    NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:%@",model.authorName,ISNIL(model.content)]];

    [attr2 addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle2} range:NSMakeRange(0, attr2.string.length)];
    [attr2 addAttributes:@{NSForegroundColorAttributeName: UIColorHex(0x54D8E0)} range:NSMakeRange(0, model.authorName.length)];
    
//    if ([model.isMeReply boolValue] == true) {
//
//        [attr2 addAttributes:@{NSForegroundColorAttributeName: UIColorHex(0xFF6188)} range:NSMakeRange(0, 3)];
//
//    } else {
//
//        [attr2 addAttributes:@{NSForegroundColorAttributeName: UIColorHex(0x54D8E0)} range:NSMakeRange(0, model.authorName.length + 2)];
//
//    }
    
    self.titleLabel.attributedText = attr2;
    
}

@end
