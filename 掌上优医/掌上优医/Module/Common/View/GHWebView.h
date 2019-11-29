//
//  GHWebView.h
//  掌上优医
//
//  Created by GH on 2018/11/12.
//  Copyright © 2018 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHWebView : UIView

- (void)setUI:(NSString *)url;

- (void)setDocUrl:(NSString *)url;

- (void)setUIWithHtmlText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
