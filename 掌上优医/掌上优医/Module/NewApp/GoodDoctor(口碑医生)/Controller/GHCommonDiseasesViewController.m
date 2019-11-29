//
//  GHCommonDiseasesViewController.m
//  掌上优医
//
//  Created by apple on 2019/10/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHCommonDiseasesViewController.h"
#import "GHSecondDepartModel.h"
#import "GHGoodDoctorDepartmentTableViewCell.h"
#import "GHSicknessDoctorListViewController.h"

@interface GHCommonDiseasesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)NSMutableArray *sicknessArray;
@property (nonatomic, strong) NSArray *sicknessColorArray;

@end

@implementation GHCommonDiseasesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sicknessArray = [NSMutableArray arrayWithCapacity:0];
    self.sicknessColorArray = @[UIColorHex(0x6A70FD),
    UIColorHex(0xFEAE05),
    UIColorHex(0xFF6188),
    UIColorHex(0x51D9E0),
    
    UIColorHex(0xFEAE05),
    UIColorHex(0xFF6188),
    UIColorHex(0xFEAE05),
    UIColorHex(0x6A70FD),
    
    UIColorHex(0x51D9E0),
    UIColorHex(0xFF6188),
    UIColorHex(0xFEAE05),
    UIColorHex(0x6A70FD),
    
    UIColorHex(0xFF6188),
    UIColorHex(0xFEAE05)
    ];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = kDefaultGaryViewColor;
#ifdef __IPHONE_11_0

    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
#endif
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    self.scrollView = tableView;
    
    [self requestData];
}

- (void)requestData {
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiCommondisease withParameter:params withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
    
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            
            
            for (NSDictionary *dicInfo in response[@"data"][@"commonDiseaseList"]) {
                
                GHSecondDepartModel *model = [[GHSecondDepartModel alloc] initWithDictionary:dicInfo error:nil];
                
                if (model == nil) {
                    continue;
                }
                
//                if ([dicInfo[@"diseaseId"] longValue]) {
//                    model.modelid = dicInfo[@"diseaseId"];
//                }
//
                [self.sicknessArray addObject:model];
                
            }
            
           
            
            [self.scrollView reloadData];
            
            if (self.sicknessArray.count == 0) {
                [self loadingEmptyView];
            }else{
                [self hideEmptyView];
            }
            
        }
        
    }];
    
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.sicknessArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 52;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHGoodDoctorDepartmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHGoodDoctorSicknessTableViewCell"];
           
   if (!cell) {
       cell = [[GHGoodDoctorDepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHGoodDoctorSicknessTableViewCell"];
   }
   
   cell.numberLabel.hidden = false;
   cell.iconImageView.hidden = true;
   
   cell.numberLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
   
   if (indexPath.row >= 99) {
       cell.numberLabel.font = H12;
   } else {
       cell.numberLabel.font = H16;
   }
   
   GHSecondDepartModel *model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];
   
   cell.titleLabel.text = ISNIL(model.commonName);
   
   cell.numberLabel.backgroundColor = [self.sicknessColorArray objectOrNilAtIndex:indexPath.row % self.sicknessColorArray.count];
   
   return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [MobClick event:@"Search_Doctor_Disease"];
            
    
    GHSecondDepartModel *model = [self.sicknessArray objectOrNilAtIndex:indexPath.row];
    GHSicknessDoctorListViewController *vc = [[GHSicknessDoctorListViewController alloc] init];
    vc.sicknessName = ISNIL(model.diseaseName);
    vc.sicknessTitleName = ISNIL(model.commonName);
    vc.wordsType = @"1";
    [self.navigationController pushViewController:vc animated:true];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //            return;
        //        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"searchDoctorleaveTop" object:nil];//到顶通知父视图改变状态
    }
//    self.scrollView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
