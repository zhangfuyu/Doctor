//
//  GHHospitalDepartmentChildrenTableViewCell.m
//  掌上优医
//
//  Created by GH on 2019/5/27.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHHospitalDepartmentChildrenTableViewCell.h"
#import "GHDepartmentChildrenCollectionViewCell.h"
#import "GHHospitalDepartmentDoctorListViewController.h"
#import "GHNewDepartMentModel.h"

@interface GHHospitalDepartmentChildrenTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end


@implementation GHHospitalDepartmentChildrenTableViewCell

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
    layout.itemSize = CGSizeMake((SCREENWIDTH - 47 - 10) / 2.f, 40);
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
    
    return CGSizeMake((SCREENWIDTH - 47 - 10) / 2.f, 40);
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GHDepartmentChildrenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHDepartmentChildrenCollectionViewCell" forIndexPath:indexPath];
    
    GHDepartmentModel *model = [self.childrenArray objectOrNilAtIndex:indexPath.row];
    
//    NSString *str = [NSString stringWithFormat:@"%@(%ld位)", ISNIL(model.departmentName), [model.doctorCount integerValue]];
    
    NSString *str = [NSString stringWithFormat:@"%@", ISNIL(model.departmentName)];

    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attr addAttributes:@{NSFontAttributeName: H14} range:NSMakeRange(0, attr.string.length)];
    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, ISNIL(model.departmentName).length)];
    
//    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultGrayTextColor} range:NSMakeRange(ISNIL(model.departmentName).length, str.length - ISNIL(model.departmentName).length)];
    
    cell.titleLabel.attributedText = attr;
    
//    cell.titleLabel.text = ISNIL(model.departmentName);
    
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
    
    GHHospitalDepartmentDoctorListViewController *vc = [[GHHospitalDepartmentDoctorListViewController alloc] init];
    
    vc.hospitalId = self.hospitalID;
    
//    vc.departmentLevel = @"2";
    
    vc.departmentId = model.departmentId;
    
    vc.hospitalId = self.hospitalID;
    
    vc.navigationItem.title = ISNIL(model.departmentName);
    
    [self.viewController.navigationController pushViewController:vc animated:true];
    
//    GHSicknessDoctorListViewController *vc = [[GHSicknessDoctorListViewController alloc] init];
//    vc.departmentName = ISNIL(model.departmentName);
//    vc.departmentModel = model;
//    [self.viewController.navigationController pushViewController:vc animated:true];
//
//    GHDepartmentChildrenCollectionViewCell *cell = (GHDepartmentChildrenCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.titleLabel.backgroundColor = kDefaultGaryViewColor;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        cell.titleLabel.backgroundColor = [UIColor whiteColor];
//    });
    
}


- (void)setChildrenArray:(NSArray *)childrenArray {
    
    _childrenArray = childrenArray;
    
    self.collectionView.height = ceil(childrenArray.count / 3.f) * 50 - 10 + 40;
    
    [self.collectionView reloadData];
    
}

@end
