//
//  GHNewCommentsFootView.m
//  掌上优医
//
//  Created by apple on 2019/8/12.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewCommentsFootView.h"
#import "GHDoctorInfoErrorViewController.h"

@implementation GHNewCommentsFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
       
        
        UIButton *errorButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        errorButton.titleLabel.font = H14;
//        [errorButton setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
//        [errorButton setTitle:@" 更新信息" forState:UIControlStateNormal];
//        [errorButton setImage:[UIImage imageNamed:@"icon_hospital_error"] forState:UIControlStateNormal];
//        errorButton.backgroundColor = [UIColor colorWithHexString:@"D8DAFF"];
        errorButton.layer.cornerRadius = 4;
        [self addSubview:errorButton];
        
        [errorButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(45);
            make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 30, 45));
        }];
        [errorButton addTarget:self action:@selector(clickInfoErrorAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIImageView *leftimage = [[UIImageView alloc]init];
          leftimage.image = [UIImage imageNamed:@"new_icon_hospital_error"];
          [self addSubview:leftimage];
          
          [leftimage mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(15);
              make.size.mas_equalTo(CGSizeMake(14, 14));
              make.centerY.mas_equalTo(errorButton.mas_centerY);
          }];
          
          UILabel *textlabel = [[UILabel alloc]init];
          textlabel.text = @"医生信息补全";
          textlabel.textColor = [UIColor colorWithHexString:@"6A70FD"];
          textlabel.font = H14;
          [self addSubview:textlabel];
          
          [textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(leftimage.mas_right).offset(5);
              make.height.mas_equalTo(14);
              make.centerY.mas_equalTo(leftimage.mas_centerY);

          }];
               
        
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textColor = [UIColor colorWithHexString:@"999999"];
        textLabel.font = H12;
        textLabel.text = @"资料来源于网络，仅供参考";
        textLabel.userInteractionEnabled = YES;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(errorButton.mas_bottom).offset(15);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickmianze)];
        [textLabel addGestureRecognizer:tapGR];
        
        
        
    }
    
    return self;

}
- (void)clickmianze
{
    GHCommonWebViewController *vc = [[GHCommonWebViewController alloc] init];
    vc.navTitle = @"大众星医用户协议";
        vc.urlStr = [[GHNetworkTool shareInstance] getGdisclaimerURL];
//    vc.urlStr = @"http://share.zsu1.com/relief.html";
    
    [self.viewController.navigationController pushViewController:vc animated:true];
}

- (void)clickInfoErrorAction {
    
    if ([GHUserModelTool shareInstance].isLogin) {
        
        GHDoctorInfoErrorViewController *vc = [[GHDoctorInfoErrorViewController alloc] init];
        vc.realModel = self.model;
        [self.viewController.navigationController pushViewController:vc animated:true];
        
    } else {
        
        GHNLoginViewController *vc = [[GHNLoginViewController alloc] init];
        [self.viewController presentViewController:vc animated:true completion:nil];
        
    }
    
}
@end
