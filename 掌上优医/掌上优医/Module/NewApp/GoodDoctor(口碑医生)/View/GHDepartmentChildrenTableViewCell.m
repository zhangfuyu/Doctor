//
//  GHDepartmentChildrenTableViewCell.m
//  掌上优医
//
//  Created by GH on 2018/11/15.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHDepartmentChildrenTableViewCell.h"
#import "GHDepartmentChildrenCollectionViewCell.h"
#import "GHSicknessDoctorListViewController.h"


@interface GHDepartmentChildrenTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GHDepartmentChildrenTableViewCell

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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREENWIDTH - 47 - 20) / 3.f, 40);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(20, 23.5, 20, 23.5);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40) collectionViewLayout:layout];
    collectionView.backgroundColor = kDefaultGaryViewColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.contentView addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.collectionView = collectionView;
    
    [collectionView registerClass:[GHDepartmentChildrenCollectionViewCell class] forCellWithReuseIdentifier:@"GHDepartmentChildrenCollectionViewCell"];
    

}

#pragma mark - CollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childrenArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((SCREENWIDTH - 47 - 20) / 3.f, 40);
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GHDepartmentChildrenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHDepartmentChildrenCollectionViewCell" forIndexPath:indexPath];
    
    GHNewDepartMentModel *model = [self.childrenArray objectOrNilAtIndex:indexPath.row];
    
    cell.titleLabel.text = ISNIL(model.departmentName);
    
    return cell;
    
}

//点击item,cell上图片改变
-(void) collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    GHDepartmentChildrenCollectionViewCell *cell = (GHDepartmentChildrenCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.titleLabel.backgroundColor = kDefaultGaryViewColor;
    
}
//点击放开item,cell上图片复原
- (void)collectionView:(UICollectionView *)collectionView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    GHDepartmentChildrenCollectionViewCell *cell = (GHDepartmentChildrenCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.titleLabel.backgroundColor = [UIColor whiteColor];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GHNewDepartMentModel *model = [self.childrenArray objectOrNilAtIndex:indexPath.row];
    
    GHSicknessDoctorListViewController *vc = [[GHSicknessDoctorListViewController alloc] init];
    vc.departmentName = ISNIL(model.departmentName);
    vc.departmentModel = model;
    vc.wordsType = @"2";
    [self.viewController.navigationController pushViewController:vc animated:true];
    
    GHDepartmentChildrenCollectionViewCell *cell = (GHDepartmentChildrenCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.titleLabel.backgroundColor = kDefaultGaryViewColor;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cell.titleLabel.backgroundColor = [UIColor whiteColor];
    });
    
}


- (void)setChildrenArray:(NSArray *)childrenArray {
    
    _childrenArray = childrenArray;
    
    self.collectionView.height = ceil(childrenArray.count / 3.f) * 50 - 10 + 40;
    
    [self.collectionView reloadData];
    
}

@end


////
////  GHDepartmentChildrenTableViewCell.m
////  掌上优医
////
////  Created by GH on 2018/11/15.
////  Copyright © 2018 GH. All rights reserved.
////
//
//#import "GHDepartmentChildrenTableViewCell.h"
//#import "GHDepartmentChildrenCollectionViewCell.h"
//#import "GHSicknessDoctorListViewController.h"
//
//
//@interface GHDepartmentChildrenTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//
//@property (nonatomic, strong) UICollectionView *collectionView;
//
//@end
//
//@implementation GHDepartmentChildrenTableViewCell
//
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self setupUI];
//    }
//    return self;
//
//}
//
//- (void)setupUI {
//
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize = CGSizeMake(SCREENWIDTH / 3.f, 46);
//    layout.minimumLineSpacing = 0;
//    layout.minimumInteritemSpacing = 0;
//    layout.sectionInset = UIEdgeInsetsZero;
//
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40) collectionViewLayout:layout];
//    collectionView.backgroundColor = [UIColor whiteColor];
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
//    [self.contentView addSubview:collectionView];
//
//    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.mas_equalTo(0);
//    }];
//    self.collectionView = collectionView;
//
//    [collectionView registerClass:[GHDepartmentChildrenCollectionViewCell class] forCellWithReuseIdentifier:@"GHDepartmentChildrenCollectionViewCell"];
//
//    UILabel *lineLabel = [[UILabel alloc] init];
//    lineLabel.backgroundColor = kDefaultLineViewColor;
//    [self addSubview:lineLabel];
//
//    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(0);
//        make.height.mas_equalTo(1);
//    }];
//
//    UILabel *lineLabel1 = [[UILabel alloc] init];
//    lineLabel1.backgroundColor = kDefaultLineViewColor;
//    [self addSubview:lineLabel1];
//
//    [lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_equalTo(0);
//        make.left.mas_equalTo(SCREENWIDTH / 3.f);
//        make.width.mas_equalTo(1);
//    }];
//
//    UILabel *lineLabel2 = [[UILabel alloc] init];
//    lineLabel2.backgroundColor = kDefaultLineViewColor;
//    [self addSubview:lineLabel2];
//
//    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_equalTo(0);
//        make.left.mas_equalTo(SCREENWIDTH / 3.f * 2);
//        make.width.mas_equalTo(1);
//    }];
//
////    UILabel *lineLabel3 = [[UILabel alloc] init];
////    lineLabel3.backgroundColor = kDefaultLineViewColor;
////    [self addSubview:lineLabel3];
////
////    [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.bottom.mas_equalTo(0);
////        make.left.mas_equalTo(SCREENWIDTH / 4.f * 3);
////        make.width.mas_equalTo(1);
////    }];
//
//}
//
//#pragma mark - CollectionViewDataSource
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.childrenArray.count;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    return CGSizeMake(SCREENWIDTH / 3.f, 46);
//
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    GHDepartmentChildrenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHDepartmentChildrenCollectionViewCell" forIndexPath:indexPath];
//
//    GHDepartmentModel *model = [self.childrenArray objectOrNilAtIndex:indexPath.row];
//
//    cell.titleLabel.text = ISNIL(model.departmentName);
//
//    return cell;
//
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    GHDepartmentModel *model = [self.childrenArray objectOrNilAtIndex:indexPath.row];
//
//    GHSicknessDoctorListViewController *vc = [[GHSicknessDoctorListViewController alloc] init];
//    vc.departmentName = ISNIL(model.departmentName);
//    vc.departmentModel = model;
//    [self.viewController.navigationController pushViewController:vc animated:true];
//
//}
//
//- (void)setChildrenArray:(NSArray *)childrenArray {
//
//    _childrenArray = childrenArray;
//
//    self.collectionView.height = ceil(self.childrenArray.count / 3.f) * 46;
//
//    [self.collectionView reloadData];
//
//}
//
//@end
