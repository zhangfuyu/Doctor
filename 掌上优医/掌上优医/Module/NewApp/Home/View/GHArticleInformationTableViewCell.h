//
//  GHArticleInformationTableViewCell.h
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHBaseTableViewCell.h"
#import "GHArticleInformationModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GHArticleInformationTableViewCellDelegate <NSObject>

@optional
- (void)clickInformationModelWithModel:(GHArticleInformationModel *)model;

@end

@interface GHArticleInformationTableViewCell : GHBaseTableViewCell

@property (nonatomic, weak) id<GHArticleInformationTableViewCellDelegate> delegate;

@property (nonatomic, strong) GHArticleInformationModel *model;

//@property (nonatomic, assign) BOOL isHomeShouldCheckIsVisit;

@end

NS_ASSUME_NONNULL_END
