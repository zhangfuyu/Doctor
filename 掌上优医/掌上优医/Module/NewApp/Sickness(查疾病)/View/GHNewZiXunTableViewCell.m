//
//  GHNewZiXunTableViewCell.m
//  掌上优医
//
//  Created by apple on 2019/9/19.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNewZiXunTableViewCell.h"
@interface GHNewZiXunTableViewCell ()

@property (nonatomic , strong)UIView *bigBackView;

@property (nonatomic , strong)UIImageView *headerimage;

@property (nonatomic , strong)UILabel *titleLabel;

@property (nonatomic , strong)UILabel *timeLabel;

@property (nonatomic , strong)UILabel *numberLabel;

@end

@implementation GHNewZiXunTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.bigBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-5);
            make.right.mas_equalTo(-15);
        }];
        
        [self.headerimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(100);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerimage.mas_top).offset(6);
            make.left.mas_equalTo(self.headerimage.mas_right).offset(20);
            make.right.mas_equalTo(-10);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.headerimage.mas_bottom).offset(-6);
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.width.mas_equalTo(70);
        }];
        
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(self.headerimage.mas_bottom).offset(-6);
            make.left.mas_equalTo(self.timeLabel.mas_right).offset(10);
            
        }];
    }
    return self;
}
- (void)setModel:(GHNewZiXunModel *)model
{
    _model = model;
    
    [self.headerimage sd_setImageWithURL:[NSURL URLWithString:model.frontCoverUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = model.title;
   
    NSString *timestr = [[model.createTime componentsSeparatedByString:@" "] firstObject];
    self.timeLabel.text = timestr;
    self.numberLabel.text = [NSString stringWithFormat:@"浏览 %@   收藏 %@",model.visitCount,model.favoriteCount];
//    self.numberLabel.text = [NSString stringWithFormat:@"浏览 %@",model.visitCount];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)bigBackView
{
    if (!_bigBackView) {
        _bigBackView = [[UIView alloc]init];
        _bigBackView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        
        _bigBackView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
        _bigBackView.layer.shadowOffset = CGSizeMake(0,0);
        _bigBackView.layer.shadowOpacity = 1;
        _bigBackView.layer.shadowRadius = 5;
        _bigBackView.layer.cornerRadius = 5;
        [self.contentView addSubview:_bigBackView];
    }
    return _bigBackView;
}
- (UIImageView *)headerimage
{
    if (!_headerimage) {
        _headerimage = [[UIImageView alloc]init];
        _headerimage.layer.cornerRadius = 5;
        _headerimage.contentMode = UIViewContentModeScaleAspectFill;
        _headerimage.layer.masksToBounds = YES;
        [self.bigBackView addSubview:_headerimage];
    }
    return _headerimage;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self.bigBackView addSubview:_titleLabel];
        
    }
    return _titleLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [self.bigBackView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _numberLabel.textAlignment = NSTextAlignmentRight;
        _numberLabel.font = [UIFont systemFontOfSize:12];
        [self.bigBackView addSubview:_numberLabel];
    }
    return _numberLabel;
}
@end
