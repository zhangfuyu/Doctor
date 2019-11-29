//
//  GHNewChooseRoleView.m
//  掌上优医
//
//  Created by apple on 2019/8/7.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "GHNewChooseRoleView.h"

@interface GHNewChooseRoleView ()

@property (nonatomic , strong)NSMutableArray *btnArry;
@property (nonatomic , strong)NSMutableArray *labelArry;


@end

@implementation GHNewChooseRoleView

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
        self.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        self.clipsToBounds = YES;
        [self creatUI];
    }
    return self;
}

- (void)setRolesType:(GHrolesType)rolesType
{
    _rolesType = rolesType;
    NSString *btntitle = @"";
    if (rolesType == GHrolesType_Doctor) {
        btntitle = @"医生";
    }
    else if (rolesType == GHrolesType_Hospital)
    {
        btntitle = @"医院";
    }
    else if (rolesType == GHrolesType_information)
    {
        btntitle = @"资讯";

    }
    else
    {
        btntitle = @"医院";
        _rolesType = 0;

    }
    
    for (NSInteger index = 0; index < self.btnArry.count; index ++) {
        
        UIButton *clickBtn = [self.btnArry objectAtIndex:index];
        UILabel *showLabe = [self.labelArry objectAtIndex:index];
        
        if ([clickBtn.titleLabel.text isEqualToString:btntitle]) {
            clickBtn.selected = YES;
            showLabe.hidden = NO;
            
            if (self.chooseRolesTypeBlock) {
                
                self.chooseRolesTypeBlock(_rolesType, clickBtn.titleLabel.text);
                
            }
        }
        else
        {
            clickBtn.selected = NO;
            showLabe.hidden = YES;
        }
        
    }
}
- (void)creatUI
{
    
    NSArray *rolesArry = [NSArray arrayWithObjects:@"医院",@"医生",@"资讯", nil];
    
    for (NSInteger index = 0; index < rolesArry.count; index ++) {
        
        UIButton *clickBrn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clickBrn setTitle:rolesArry[index] forState:UIControlStateNormal];
        [clickBrn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [clickBrn setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateSelected];
        clickBrn.titleLabel.font = [UIFont systemFontOfSize:16];
        [clickBrn addTarget:self action:@selector(clickSelecBtn:) forControlEvents:UIControlEventTouchUpInside];
        clickBrn.tag = 100 + index;
        [self addSubview:clickBrn];
        
        [clickBrn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREENWIDTH / 3.0 * index);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREENWIDTH / 3.0, 45));
            
        }];
        
        
        UILabel *backColorLabel = [[UILabel alloc]init];
        backColorLabel.layer.cornerRadius = 11.5;
        backColorLabel.layer.masksToBounds = YES;
        backColorLabel.backgroundColor = [UIColor colorWithHexString:@"6A70FD"];
        backColorLabel.tag = 200 + index;
        backColorLabel.hidden = YES;
        [self addSubview:backColorLabel];
        
        [backColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(11);
            make.size.mas_equalTo(CGSizeMake(55, 23));
            make.centerX.equalTo(clickBrn.mas_centerX);
        }];
        
        
        if (index == 0) {
            clickBrn.selected = YES;
            backColorLabel.hidden = NO;
            
        }
        
        [self bringSubviewToFront:clickBrn];
        
        [self.btnArry addObject:clickBrn];
        [self.labelArry addObject:backColorLabel];
        
    }
    
    UIView *linview = [[UIView alloc]init];
    linview.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
    [self addSubview:linview];
    [linview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    
    
    
    for (NSInteger index = 0; index < 3; index++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.titleLabel.font = H12;
        [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"6A70FD"] forState:UIControlStateSelected];
//        [button setTitleColor:kDefaultBlueColor forState:UIControlStateSelected];
//        button.isIgnore = true;
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(45);
            make.bottom.mas_equalTo(1);
            make.left.mas_equalTo(index * (SCREENWIDTH / 3.f));
            make.width.mas_equalTo(SCREENWIDTH / 3.f);
        }];
        
        [button setImage:[UIImage imageNamed:@"extension_down"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"extension_up"] forState:UIControlStateSelected];

        if (index == 0) {
            
            
            [button setTitle:[GHUserModelTool shareInstance].locationCity.length > 0? [GHUserModelTool shareInstance].locationCity:@"当前位置" forState:UIControlStateNormal];
            
            
            
            [button addTarget:self action:@selector(clickDoctorLocationAction:) forControlEvents:UIControlEventTouchUpInside];
            self.LocationButton = button;
            
            UILabel *lineLabel2 = [[UILabel alloc] init];
            lineLabel2.backgroundColor = kDefaultLineViewColor;
            [self addSubview:lineLabel2];
            
            [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(button.mas_right);
                make.centerY.equalTo(button.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(1, 14));
            }];
            
        } else if (index == 1) {
            [button setTitle:@"综合排序" forState:UIControlStateNormal];
           
            [button addTarget:self action:@selector(clickDoctorSortAction:) forControlEvents:UIControlEventTouchUpInside];
            
            self.SortButton = button;
            
            UILabel *lineLabel3 = [[UILabel alloc] init];
            lineLabel3.backgroundColor = kDefaultLineViewColor;
            [self addSubview:lineLabel3];
            
            [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(button.mas_right);
                make.centerY.equalTo(button.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(1, 14));
            }];
            
        } else if (index == 2) {
            [button setTitle:@"筛选" forState:UIControlStateNormal];
           
            [button addTarget:self action:@selector(clickDoctorFilterAction:) forControlEvents:UIControlEventTouchUpInside];
            
            self.FilterButton = button;
        }
        
        button.selected = NO;
        button.transform = CGAffineTransformMakeScale(-1, 1);
        button.titleLabel.transform = CGAffineTransformMakeScale(-1, 1);
        button.imageView.transform = CGAffineTransformMakeScale(-1, 1);
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
        [button setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -8)];
        
        
       
    }
    
    
}


- (void)clickSelecBtn:(UIButton *)sender
{
    
    
    self.rolesType = sender.tag- 100;
    if (self.chooseRolesTypeBlock) {
        
        self.chooseRolesTypeBlock(self.rolesType, sender.titleLabel.text);
        
    }
    
    
    for (NSInteger index = 0; index < self.btnArry.count; index ++) {
        
        UIButton *clickBtn = [self.btnArry objectAtIndex:index];
        UILabel *showLabe = [self.labelArry objectAtIndex:index];
        
        if (clickBtn.tag == sender.tag) {
            clickBtn.selected = YES;
            showLabe.hidden = NO;
        }
        else
        {
            clickBtn.selected = NO;
            showLabe.hidden = YES;
        }
        
    }
}


- (void)clickDoctorLocationAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.SortButton.selected = NO;
    self.FilterButton.selected = NO;
    
    if (self.chooseConditionsBlock) {
        self.chooseConditionsBlock(GHconditions_Location);
    }

}

- (void)clickDoctorSortAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.LocationButton.selected = NO;
    self.FilterButton.selected = NO;
    
    if (self.chooseConditionsBlock) {
        self.chooseConditionsBlock(GHconditions_Sorting);
    }
}

- (void)clickDoctorFilterAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.LocationButton.selected = NO;
    self.SortButton.selected = NO;
    if (self.chooseConditionsBlock) {
        self.chooseConditionsBlock(GHconditions_Screening);
    }
}

- (void)setLocationtext:(NSString *)locationtext
{
    
    _locationtext = locationtext;

    [self resetbtnSelect];
    
    if (locationtext.length != 0) {
        [self.LocationButton setTitle:locationtext forState:UIControlStateNormal];

    }
}

- (void)setSortText:(NSString *)sortText
{
    _sortText = sortText;
    
    [self resetbtnSelect];
    
    if (sortText.length != 0) {
        [self.SortButton setTitle:sortText forState:UIControlStateNormal];
        
    }
}

- (void)resetbtnSelect
{
    self.LocationButton.selected = NO;
    self.SortButton.selected = NO;
    self.FilterButton.selected = NO;
}

- (NSMutableArray *)btnArry
{
    if (!_btnArry) {
        _btnArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _btnArry;
}

- (NSMutableArray *)labelArry
{
    if (!_labelArry) {
        _labelArry = [NSMutableArray arrayWithCapacity:0];
    }
    return _labelArry;
}
@end
