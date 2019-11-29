//
//  GHArticleInformationModel.m
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHArticleInformationModel.h"

@implementation GHArticleInformationModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id"}];
}

- (void)setGmtCreate:(NSString<Optional> *)gmtCreate {
    
    _gmtCreate = gmtCreate;
    
    _shouldShowTime = [GHTimeDealTool getShowTimeWithTimeStr:ISNIL(gmtCreate)];
    
}

@end
