//
//  GHMyCollectionInformationTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/2/21.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHMyCollectionInformationTableViewCell.h"

@interface GHMyCollectionInformationTableViewCell ()<UIAlertViewDelegate>


@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *cancelCollectionButton;

@property (nonatomic, strong) UIButton *maskButton;

@property (nonatomic, strong) UIAlertView *deleteAlertView;



@end

@implementation GHMyCollectionInformationTableViewCell

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
        make.bottom.mas_equalTo(-3);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kDefaultBlackTextColor;
    nameLabel.font = HM15;
    [contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.height.mas_equalTo(21);
        make.top.mas_equalTo(14);
        make.right.mas_equalTo(-12);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = kDefaultGrayTextColor;
    timeLabel.font = H13;
    [contentView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.height.mas_equalTo(19);
        make.bottom.mas_equalTo(-14);
        make.right.mas_equalTo(-12);
    }];
    self.timeLabel = timeLabel;
    
  
    
    [self addDeleteButton];
    
}

- (void)setModel:(GHMyCollectionInformationModel *)model {
    
    _model = model;
    
    self.nameLabel.text = model.title;
    self.timeLabel.text = [NSString stringWithFormat:@"发布时间: %@", [GHTimeDealTool getShowTimeWithTimeStr:ISNIL(model.gmtCreate)]];


    
}

- (void)addDeleteButton {
    
    UIButton *failButton = [UIButton buttonWithType:UIButtonTypeCustom];
    failButton.backgroundColor = kDefaultGaryViewColor;
    failButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [failButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [failButton setTitle:@"取消收藏" forState:UIControlStateNormal];
    [failButton setImage:[UIImage imageNamed:@"collection_delete"] forState:UIControlStateNormal];
    failButton.frame = CGRectMake(SCREENWIDTH, 10, 64, 74);
    [failButton addTarget:self action:@selector(clickDeleteTaskAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:failButton];
    self.cancelCollectionButton = failButton;
    
    
    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeAction)];
    swipeGR.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.contentView addGestureRecognizer:swipeGR];
    
    
    UISwipeGestureRecognizer *swipeGR2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeAction)];
    swipeGR2.direction = UISwipeGestureRecognizerDirectionRight;
    [self.contentView addGestureRecognizer:swipeGR2];
    
    UIButton *maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    maskButton.hidden = true;
    [maskButton addTarget:self action:@selector(rightSwipeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:maskButton];
    
    [maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.maskButton = maskButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rightSwipeAction) name:@"kNotificationCollectionDoctorCellShouldReset" object:nil];
    
}

- (void)clickDeleteTaskAction {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"取消收藏" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self deleteTask];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
        [self rightSwipeAction];
    }];
    
    // 2.2 添加按钮
    [alertController addAction:deleteAction];
    [alertController addAction:cancelAction];
    
    // 3.显示警报控制器
    [self.viewController presentViewController:alertController animated:YES completion:nil];
    
    //    self.deleteAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否取消收藏该医生" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //    [self.deleteAlertView show];
}

- (void)rightSwipeAction {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.mj_x = 0;
        self.cancelCollectionButton.mj_x = SCREENWIDTH;
    }];
    self.maskButton.hidden = true;
    
}

- (void)leftSwipeAction {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationCollectionDoctorCellShouldReset" object:nil];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.mj_x = -80;
        self.cancelCollectionButton.mj_x = SCREENWIDTH - 80;
    }];
    self.maskButton.hidden = false;
    
}

//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//
//    if (alertView == self.deleteAlertView) {
//
//        if (buttonIndex == 1) {
//            [self deleteTask];
//        } else {
//            [self rightSwipeAction];
//        }
//
//    }
//
//}

- (void)deleteTask {
    
    [self rightSwipeAction];
    
    [SVProgressHUD showWithStatus:kDefaultTipsText];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = ISNIL(self.model.modelId);

    [SVProgressHUD showWithStatus:kDefaultTipsText];

    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_DELETE withUrl:kApiMyFavoriteNews  withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {

        if (isSuccess) {

            [SVProgressHUD dismiss];

            [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];

            if ([self.delegate respondsToSelector:@selector(cancelCollectionSuccessShouldReloadData)]) {
                [self.delegate cancelCollectionSuccessShouldReloadData];
            }

        }

    }];


   
    
}



@end
