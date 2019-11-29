//
//  GHNSearchSicknessTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/2/26.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNSearchSicknessTableViewCell.h"

@interface GHNSearchSicknessTableViewCell ()


@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation GHNSearchSicknessTableViewCell

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
    contentView.layer.shadowOffset = CGSizeMake(0,2);
    contentView.layer.shadowOpacity = 1;
    contentView.layer.shadowRadius = 4;
    [self.contentView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-4);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = HM15;
    [contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(14);
        make.right.mas_equalTo(-16);
    }];
    self.nameLabel = nameLabel;
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H13;
    titleLabel.layer.cornerRadius = 2;
    titleLabel.layer.masksToBounds = true;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"症状";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = UIColorHex(0x54D8E0);
    [contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.bottom.mas_equalTo(-16);
        make.width.mas_equalTo(32);
    }];
    
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = kDefaultGrayTextColor;
    descLabel.font = H13;
    [contentView addSubview:descLabel];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_right).offset(8);
        make.height.mas_equalTo(19);
        make.centerY.mas_equalTo(titleLabel);
        make.right.mas_equalTo(-12);
    }];
    self.descLabel = descLabel;
    
}

- (void)setModel:(GHSearchSicknessModel *)model {
    
    _model = model;
    
    self.nameLabel.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.diseaseName)];
    self.descLabel.text = [GHFilterHTMLTool filterHTMLEMTag:ISNIL(model.symptom)];
    
//    self.nameLabel.attributedText = [NSAttributedString getAttributedStringWithSearchString:ISNIL(model.diseaseName)];
//    self.descLabel.attributedText = [NSAttributedString getAttributedStringWithSearchString:ISNIL(model.symptom)];
    
}

@end
