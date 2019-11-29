//
//  GHAboutMeViewController.m
//  掌上优医
//
//  Created by GH on 2018/11/2.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHAboutMeViewController.h"
#import "GHAboutMeTableViewCell.h"

@interface GHAboutMeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GHAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"关于我们";
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    
    self.view.backgroundColor = kDefaultGaryViewColor;
    
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    
    tableView.backgroundColor = kDefaultGaryViewColor;
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    self.tableView = tableView;
    
    [self setupTableHeaderView];
    
}

- (void)setupTableHeaderView {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 300);
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.backgroundColor = [UIColor clearColor];
    iconImageView.image = [UIImage imageNamed:@"img_entry page_logo"];
    
    [headerView addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(68);
        make.top.mas_equalTo(25);
        make.centerX.mas_equalTo(headerView);
    }];
    
    UIImageView *iconTitleImageView = [[UIImageView alloc] init];
    iconTitleImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconTitleImageView.backgroundColor = [UIColor clearColor];
    iconTitleImageView.image = [UIImage imageNamed:@"wenzi_entrypage_shangshangyouyi"];
    
    [headerView addSubview:iconTitleImageView];
    
    [iconTitleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(138);
        make.height.mas_equalTo(28);
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(16);
        make.centerX.mas_equalTo(headerView);
    }];
    
    UILabel *versionLabel = [[UILabel alloc] init];
    versionLabel.font = H13;
    versionLabel.textColor = kDefaultGrayTextColor;
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:versionLabel];
    
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(iconTitleImageView.mas_bottom);
        make.height.mas_equalTo(36);
    }];
    
    versionLabel.text = [NSString stringWithFormat:@"版本V.%@", ISNIL([JFTools shortVersion])];
    
    
    NSString *text = @"大众星医,是为用户提供精准医疗健康资源AI自动匹配的信息服务平台.\n大众星医,以\"让就医不再难\"为初心，致力于打造领先的未来医疗健康AI精准匹配信息平台,打破资源信息与患者间的信息不匹配,通过信息大数据分析让每一种疾病都精准匹配优质的医院、医生、药品、商品、资讯等，患者看病后给予评论，让医疗整个服务环节在患者面前透明化，成为医疗界的大众点评。\n大众星医，运用AI与云端数据处理技术，为医患提供高效的智能化移动信息和个性化千人千面的精准资讯，实现数据价值最大化，赋能中国健康及医疗服务信息产业，力争成为国内健康大数据和精准医疗信息服务平台领导者。";
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = H14;
//    contentLabel.font = HScaleFont(14);
    contentLabel.textColor = kDefaultBlackTextColor;
    [headerView addSubview:contentLabel];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo([text getShouldHeightWithContent:text withFont:H14 withWidth:SCREENWIDTH - 32 withLineHeight:21]);
//        if (IS_IPHONE4_SERIES || kiPhone5) {
//            make.width.mas_equalTo(260);
//        } else {
//            make.width.mas_equalTo(307);
//        }
//
//        make.centerX.mas_equalTo(headerView);
        make.top.mas_equalTo(versionLabel.mas_bottom).offset(12);
    }];
    

    
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = 21;
    paragraphStyle.minimumLineHeight = 21;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;

    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", text]];
    
    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlackTextColor} range:NSMakeRange(0, text.length)];
    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, text.length)];
    
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@", text1, text2, text3, text4]];
    
//    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlueColor} range:NSMakeRange(0, text1.length)];
//    [attr addAttributes:@{NSForegroundColorAttributeName: kDefaultBlueColor} range:NSMakeRange(text1.length + text2.length, text3.length)];
//
//    [attr addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(0, text1.length + text2.length + text3.length + text4.length)];
    
    contentLabel.attributedText = attr;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = kDefaultGaryViewColor;
    [headerView addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 25+68 +16 + 28 +36 +10 +[text getShouldHeightWithContent:text withFont:H14 withWidth:SCREENWIDTH - 32 withLineHeight:21] + 12);
    self.tableView.tableHeaderView = headerView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHAboutMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHAboutMeTableViewCell"];
    
    if (!cell) {
        cell = [[GHAboutMeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GHAboutMeTableViewCell"];
    }
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"联系我们";
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"用户协议";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"隐私政策";
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self clickJoinUsAction];
    } else if (indexPath.row == 1) {
        [self clickUserProtocolAction];
    } else if (indexPath.row == 2) {
        [self clickPrivacyPolicyAction];
    }
    
}

- (void)clickJoinUsAction {

    [JFTools callPhone:@"0571-88779865"];
    
}

- (void)clickUserProtocolAction {
    
    NSLog(@"用户协议");
    GHCommonWebViewController *vc = [[GHCommonWebViewController alloc] init];
    vc.navTitle = @"大众星医用户协议";
    vc.urlStr = [[GHNetworkTool shareInstance] getUserProtocolURL];
//    vc.urlStr = @"http://share.zsu1.com/protocolInfo.html";
    
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)clickPrivacyPolicyAction {
    
    GHCommonWebViewController *vc = [[GHCommonWebViewController alloc] init];
    vc.navTitle = @"隐私政策";
    vc.urlStr = [[GHNetworkTool shareInstance] getPrivacyPolicyURL];
//    vc.urlStr = @"http://share.zsu1.com/privacyInfo.html";
    
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self setupNavigationStyle:GHNavigationBarStyleWhite];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self setupNavigationStyle:GHNavigationBarStyleBlue];
    
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
