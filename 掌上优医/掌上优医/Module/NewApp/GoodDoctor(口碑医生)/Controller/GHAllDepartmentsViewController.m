//
//  GHAllDepartmentsViewController.m
//  掌上优医
//
//  Created by apple on 2019/10/28.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHAllDepartmentsViewController.h"
#import "GHNewDepartMentModel.h"
#import "GHGoodDoctorDepartmentTableViewCell.h"
#import "GHDepartmentChildrenTableViewCell.h"
#import "GHDepartmentModel.h"
#import "GHSicknessDoctorListViewController.h"
@interface GHAllDepartmentsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong)NSMutableArray *departmentArray;

@end

@implementation GHAllDepartmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.departmentArray = [NSMutableArray arrayWithCapacity:0];
    
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
    
    [self getDataAction];
}
- (void)getDataAction {
    
    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_GET withUrl:kApiSystemparamDepartments withParameter:nil withLoadingType:GHLoadingType_ShowLoading withShouldHaveToken:YES withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nonnull msg, id  _Nonnull response) {
        
        if (isSuccess) {
            
            [SVProgressHUD dismiss];
            

            
            for (NSDictionary *info in response[@"data"][@"departmentList"]) {
                
                GHNewDepartMentModel *model = [[GHNewDepartMentModel alloc]initWithDictionary:(NSDictionary *)info[@"firstDepartment"] error:nil];
                
                NSArray *secondDepartmentList = info[@"secondDepartmentList"];
                
                for (NSInteger index = 0; index < secondDepartmentList.count; index ++) {
                    
                    NSDictionary *secondDic = [secondDepartmentList objectAtIndex:index];
                    
                    GHNewDepartMentModel *second = [[GHNewDepartMentModel alloc]initWithDictionary:secondDic error:nil];
                    [model.secondDepartmentList addObject:second];
                }
                
                [self.departmentArray addObject:model];
                
            }
            
            
          
            
            if (self.departmentArray.count == 0) {
                [self loadingEmptyView];
            }else{
                [self hideEmptyView];
            }
                

            
            [self.scrollView reloadData];
            
        }
        
    }];
    
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
        return self.departmentArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:section];
    return [model.isOpen integerValue] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if (indexPath.row == 0) {
       return 52;
   } else {
       GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
       return ceil(model.secondDepartmentList.count / 3.f) * 50 - 10 + 40;
  
   }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if (indexPath.row == 0) {
               
               GHGoodDoctorDepartmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHGoodDoctorDepartmentTableViewCell"];
               
               if (!cell) {
                   cell = [[GHGoodDoctorDepartmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHGoodDoctorDepartmentTableViewCell"];
               }
               
               cell.model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
               
               return cell;
               
           } else {
               
               GHDepartmentChildrenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHDepartmentChildrenTableViewCell"];
               
               if (!cell) {
                   cell = [[GHDepartmentChildrenTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHDepartmentChildrenTableViewCell"];
               }
               
               GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];
               
               cell.childrenArray = [model.secondDepartmentList copy];
               
               return cell;
               
           }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.row == 0) {

            for (NSInteger index = 0; index < self.departmentArray.count; index++) {

                GHDepartmentModel *model = [self.departmentArray objectOrNilAtIndex:index];

                if (index == indexPath.section) {
                    continue;
                }

                model.isOpen = @(false);

            }

            [self.scrollView reloadData];

            GHNewDepartMentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.section];

//                GHSicknessDoctorListViewController *vc = [[GHSicknessDoctorListViewController alloc] init];
//                vc.departmentName = ISNIL(model.departmentName);
//                vc.departmentModel = model;
//                [self.navigationController pushViewController:vc animated:true];
            if (model.secondDepartmentList > 0) {

                model.isOpen = [NSNumber numberWithBool:![model.isOpen boolValue]];


                [self.scrollView reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];

//                [self.departmentTableView scrollToRow:0 inSection:indexPath.section atScrollPosition:UITableViewScrollPositionTop animated:false];
                
                
            } else {

//                    GHDepartmentModel *model = [self.departmentArray objectOrNilAtIndex:indexPath.row];

                [MobClick event:@"Search_Doctor_Department"];

                GHSicknessDoctorListViewController *vc = [[GHSicknessDoctorListViewController alloc] init];
                vc.departmentName = ISNIL(model.departmentName);
                vc.departmentModel = model;
                [self.navigationController pushViewController:vc animated:true];


            }


        }
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
