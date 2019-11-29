//
//  GHTNewQuestionableViewCell.m
//  掌上优医
//
//  Created by apple on 2019/8/12.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHTNewQuestionableViewCell.h"
@interface GHTNewQuestionableViewCell ()

@property (nonatomic , strong)UILabel *titleLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *timeLabel;

@property (nonatomic , strong)UILabel *questionTyoeLabel;

@property (nonatomic , strong)UILabel *contentLabel;

@property (nonatomic , strong)UILabel *answerLabel;

@property (nonatomic , strong)UIImageView *headerImage;

@end

@implementation GHTNewQuestionableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(13);
            make.top.mas_equalTo(17);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.right.equalTo(self.answerLabel.mas_left).with.offset(-10);
            make.height.mas_equalTo(14);
        }];
        
      
        
        [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(36, 36));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headerImage.mas_right).offset(10);
//            make.right.mas_equalTo(-15- 60);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(self.headerImage.mas_top);
        }];
        
        [self.questionTyoeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_right).offset(5);
            make.centerY.mas_equalTo(self.nameLabel.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(53, 14));
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.bottom.mas_equalTo(self.headerImage.mas_bottom);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(12);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.headerImage.mas_bottom).offset(15);
            make.height.mas_equalTo(12);
        }];
        
    }
    return self;
}
- (void)setModel:(GHQuestionModel *)model
{
    _model = model;
    self.titleLabel.text = ISNIL(model.title);
     [self.headerImage sd_setImageWithURL:kGetImageURLWithString(ISNIL(model.authorHeaderUrl)) placeholderImage:[UIImage imageNamed:@"doctor_default_portail"]];
    self.nameLabel.text = ISNIL(model.authorName);
    self.questionTyoeLabel.text = @"医生回答";
    self.questionTyoeLabel.hidden = YES;
    self.timeLabel.text = ISNIL(model.createDate);
    self.contentLabel.text = ISNIL(model.content);
    
    self.answerLabel.text = [NSString stringWithFormat:@"%ld个回答", [model.answerNums integerValue]];

}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = H14;
        _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = H14;
        _nameLabel.textColor = [UIColor colorWithHexString:@"000000"];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = H12;
        _contentLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UILabel *)questionTyoeLabel
{
    if (!_questionTyoeLabel) {
        _questionTyoeLabel = [[UILabel alloc]init];
        _questionTyoeLabel.font = [UIFont systemFontOfSize:9];
        _questionTyoeLabel.textAlignment = NSTextAlignmentCenter;
        _questionTyoeLabel.textColor = [UIColor colorWithHexString:@"6A70FD"];
        _questionTyoeLabel.backgroundColor = [UIColor colorWithHexString:@"DCDDFF"];
        _questionTyoeLabel.layer.cornerRadius = 2;
        _questionTyoeLabel.clipsToBounds = YES;
        [self.contentView addSubview:_questionTyoeLabel];
    }
    return _questionTyoeLabel;
}

- (UILabel *)answerLabel
{
    if (!_answerLabel) {
        _answerLabel = [[UILabel alloc]init];
        _answerLabel.font = H12;
        _answerLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _answerLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_answerLabel];
    }
    return _answerLabel;
}
- (UIImageView *)headerImage
{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]init];
        _headerImage.layer.cornerRadius = 18;
        _headerImage.clipsToBounds = YES;
        [self.contentView addSubview:_headerImage];
    }
    return _headerImage;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
