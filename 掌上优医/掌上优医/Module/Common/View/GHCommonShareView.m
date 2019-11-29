//
//  GHCommonShareView.m
//  掌上优医
//
//  Created by GH on 2018/11/9.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHCommonShareView.h"
#import "GHShareButtonView.h"

#import "WXApi.h"
#import "WeiboSDK.h"

@implementation GHCommonShareView


- (instancetype)init {
    
    if (self = [super init]) {
        
        [self setupUI];
        
    }
    return self;
    
}

//- (void)setUrlString:(NSString *)urlString {
//    
//    if ([urlString containsString:@"?"]) {
//        _urlString = [NSString stringWithFormat:@"%@&notApp=1", ISNIL(urlString)];
//    } else {
//        _urlString = urlString;
//    }
//    
//    
//    
//}

- (void)setupUI {
    
    self.backgroundColor = RGBACOLOR(51, 51, 51, 0.1);
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo((160 - kBottomSafeSpace));
    }];
    

    
    UIButton *contentView = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addTarget:self action:@selector(clickOtherAction) forControlEvents:UIControlEventTouchUpInside];
    contentView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomSafeSpace);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = H18;
    titleLabel.textColor = kDefaultBlackTextColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"分享至";
    [contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(47);
    }];
    
    
    GHShareButtonView *pengyouquanView = [[GHShareButtonView alloc] initWithIconName:@"share_wechat_zone" withTitle:@"微信朋友圈"];
    pengyouquanView.actionButton.tag = 2;
    [pengyouquanView.actionButton addTarget:self action:@selector(clickShareAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:pengyouquanView];
    
    [pengyouquanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(74);
        make.width.mas_equalTo(HScaleHeight(100));
    }];
    
    pengyouquanView.hidden = ![WXApi isWXAppInstalled];
    
    
    GHShareButtonView *sessionView = [[GHShareButtonView alloc] initWithIconName:@"share_wechat_friend" withTitle:@"微信好友"];
    sessionView.actionButton.tag = 1;
    [sessionView.actionButton addTarget:self action:@selector(clickShareAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:sessionView];
    
    [sessionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
        make.right.mas_equalTo(pengyouquanView.mas_left);
        make.height.mas_equalTo(74);
        make.width.mas_equalTo(HScaleHeight(100));
    }];
    
    sessionView.hidden = ![WXApi isWXAppInstalled];
    
    

    
    
    GHShareButtonView *weiboView = [[GHShareButtonView alloc] initWithIconName:@"share_sina" withTitle:@"新浪微博"];
    weiboView.actionButton.tag = 3;
    [weiboView.actionButton addTarget:self action:@selector(clickShareAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:weiboView];
    
    [weiboView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(pengyouquanView.mas_right);
        make.height.mas_equalTo(74);
        make.width.mas_equalTo(HScaleHeight(100));
    }];
    
    if (pengyouquanView.hidden) {
        [weiboView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((SCREENWIDTH / 2.f) - 50);
        }];
    }
    
//    weiboView.hidden = ![WeiboSDK isWeiboAppInstalled];
    
    
    UIButton *tapView = [UIButton buttonWithType:UIButtonTypeCustom];
    tapView.backgroundColor = [UIColor clearColor];
    [tapView addTarget:self action:@selector(clickCancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tapView];
    
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomView.mas_top);
    }];
    
}

- (void)clickShareAction:(UIButton *)sender {
    
    self.hidden = true;
    
    if (sender.tag == 3) {
        // 微博
        
        WBMessageObject *message = [WBMessageObject message];
   
        message.text = [NSString stringWithFormat:@"%@ %@", ISNIL(self.title).length ? self.title : @"大众星医", ISNIL(self.urlString).length ? self.urlString : @"http://www.zsu1.com/"];

        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = @"https://api.weibo.com/oauth2/default.html";
        authRequest.scope = @"all";
        
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
        request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        
        [WeiboSDK sendRequest:request];
        
    } else {
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = ISNIL(self.title).length ? self.title : @"大众星医";
        message.description = ISNIL(self.desc).length ? self.desc : @"快来看看吧~";
        [message setThumbImage:[UIImage imageNamed:@"img_entry page_logo"]];
        
        WXWebpageObject *webpageObject = [WXWebpageObject object];
        webpageObject.webpageUrl = ISNIL(self.urlString).length ? self.urlString: @"http://www.zsu1.com/";
        message.mediaObject = webpageObject;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        
        if (sender.tag == 1) {
            req.scene = WXSceneSession;
        } else if (sender.tag == 2) {
            req.scene = WXSceneTimeline;
        }
        
        [WXApi sendReq:req];
        
    }

}

/**
 只是为了不做任何响应
 */
- (void)clickOtherAction {
    
}

- (void)clickCancelAction {
    
    self.hidden = true;
    
}


@end
