//
//  GHCoinRecordTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHCoinRecordTableViewCell.h"

@interface GHCoinRecordTableViewCell ()

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *timeLabel;

/**
 <#Description#>
 */
@property (nonatomic, strong) UILabel *coinLabel;

@end

@implementation GHCoinRecordTableViewCell

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
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(0);
    }];
    
    UILabel *coinLabel = [[UILabel alloc] init];
    coinLabel.textColor = UIColorHex(0xFEAE05);
    coinLabel.font = H16;
    coinLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:coinLabel];
    
    [coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.centerY.mas_equalTo(view);
        make.height.mas_equalTo(30);
    }];
    self.coinLabel = coinLabel;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.font = H16;
    [view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(23);
        make.right.mas_equalTo(coinLabel.mas_left).offset(-5);
    }];
    self.titleLabel = titleLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = kDefaultGrayTextColor;
    timeLabel.font = H13;
    [view addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.height.mas_equalTo(19);
        make.right.mas_equalTo(coinLabel.mas_left).offset(-5);
    }];
    self.timeLabel = timeLabel;
    
    
    
}

- (void)setModel:(GHCoinRecordModel *)model {
    
    _model = model;
    
    if ([model.balanceChangeType integerValue] == 1) {
        
        self.coinLabel.text = [NSString stringWithFormat:@"+%ld星医分", [model.amount integerValue]];
        
    } else if ([model.balanceChangeType integerValue] == 2) {
        
        self.coinLabel.text = [NSString stringWithFormat:@"-%ld星医分", [model.amount integerValue]];
        
    }
    
    self.titleLabel.text = ISNIL(model.transactionDesc);
    
    self.timeLabel.text = ISNIL(model.gmtCreate);
    
}

@end
