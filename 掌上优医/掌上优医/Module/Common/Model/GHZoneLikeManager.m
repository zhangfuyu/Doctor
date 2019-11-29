//
//  GHZoneLikeManager.m
//  掌上优医
//
//  Created by GH on 2018/12/7.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHZoneLikeManager.h"

@implementation GHZoneLikeManager

+ (instancetype)shareInstance {
    
    static GHZoneLikeManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[GHZoneLikeManager alloc] init];
    });
    return _manager;
    
}

- (NSMutableArray *)systemPostLikeIdArray {
    
    if (!_systemPostLikeIdArray) {
        _systemPostLikeIdArray = [[NSMutableArray alloc] init];
    }
    return _systemPostLikeIdArray;
    
}

- (NSMutableArray *)systemReplyLikeIdArray {
    
    if (!_systemReplyLikeIdArray) {
        _systemReplyLikeIdArray = [[NSMutableArray alloc] init];
    }
    return _systemReplyLikeIdArray;
    
}

- (NSMutableArray *)systemDiscussLikeIdArray {
    
    if (!_systemDiscussLikeIdArray) {
        _systemDiscussLikeIdArray = [[NSMutableArray alloc] init];
    }
    return _systemDiscussLikeIdArray;
    
}

- (NSMutableArray *)systemCommentLikeIdArray {
    
    if (!_systemCommentLikeIdArray) {
        _systemCommentLikeIdArray = [[NSMutableArray alloc] init];
    }
    return _systemCommentLikeIdArray;
    
}

- (NSMutableArray *)localPostLikeIdArray {
    
    if (!_localPostLikeIdArray) {
        _localPostLikeIdArray = [[NSMutableArray alloc] init];
    }
    return _localPostLikeIdArray;
    
}

- (NSMutableArray *)localReplyLikeIdArray {
    
    if (!_localReplyLikeIdArray) {
        _localReplyLikeIdArray = [[NSMutableArray alloc] init];
    }
    return _localReplyLikeIdArray;
    
}

- (NSMutableArray *)localDiscussLikeIdArray {
    
    if (!_localDiscussLikeIdArray) {
        _localDiscussLikeIdArray = [[NSMutableArray alloc] init];
    }
    return _localDiscussLikeIdArray;
    
}

- (void)synchronousPostLikeData {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableArray *likeArray = [[NSMutableArray alloc] init];
        NSMutableArray *unlikeArray = [[NSMutableArray alloc] init];
        
        for (NSString *likeContentId in [GHZoneLikeManager shareInstance].localPostLikeIdArray) {
            
            // 服务器不包含 该资源 id
            if (![[GHZoneLikeManager shareInstance].systemPostLikeIdArray containsObject:ISNIL(likeContentId)]) {
                [likeArray addObject:likeContentId];
            }
            
        }
        
        for (NSString *likeContentId in [GHZoneLikeManager shareInstance].systemPostLikeIdArray) {
            
            // 本地不包含 该资源 id
            if (![[GHZoneLikeManager shareInstance].localPostLikeIdArray containsObject:ISNIL(likeContentId)]) {
                [unlikeArray addObject:likeContentId];
            }
            
        }
        
        if (likeArray.count) {
            
            for (NSString *likeContentId in likeArray) {
                
                if (likeContentId.length) {
                    
                    [NSThread sleepForTimeInterval:0.2];
                    
                    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                    params[@"id"] = likeContentId;
                    
                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiCirclePostLike withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                        
                        if (isSuccess) {
                            [[GHZoneLikeManager shareInstance].systemPostLikeIdArray addObject:likeContentId];
                        }
                        
                    }];
                    
                    
                }
                
            }
            
        }
        
        if (unlikeArray.count) {
            
            for (NSString *likeContentId in unlikeArray) {
                
                if (likeContentId.length) {
                    
                    [NSThread sleepForTimeInterval:0.2];
                    
                    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                    params[@"id"] = likeContentId;
                    
                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_DELETE withUrl:kApiCirclePostLike withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                        
                        if (isSuccess) {
                            [[GHZoneLikeManager shareInstance].systemPostLikeIdArray removeObject:likeContentId];
                        }
                        
                    }];
                    
                    
                }
                
            }
            
        }
        
    });
    
}

/**
 异步
 // 防止同时发送太多请求导致服务器报错
 [NSThread sleepForTimeInterval:0.2];
 */
- (void)synchronousDiscussLikeData {
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableArray *likeArray = [[NSMutableArray alloc] init];
        NSMutableArray *unlikeArray = [[NSMutableArray alloc] init];
        
        for (NSString *likeContentId in [GHZoneLikeManager shareInstance].localDiscussLikeIdArray) {
            
            // 服务器不包含 该资源 id
            if (![[GHZoneLikeManager shareInstance].systemDiscussLikeIdArray containsObject:ISNIL(likeContentId)]) {
                [likeArray addObject:likeContentId];
            }
            
        }
        
        for (NSString *likeContentId in [GHZoneLikeManager shareInstance].systemDiscussLikeIdArray) {
            
            // 本地不包含 该资源 id
            if (![[GHZoneLikeManager shareInstance].localDiscussLikeIdArray containsObject:ISNIL(likeContentId)]) {
                [unlikeArray addObject:likeContentId];
            }
            
        }
        
        if (likeArray.count) {
            
            for (NSString *likeContentId in likeArray) {
                
                if (likeContentId.length) {
                    
                    // 防止同时发送太多请求导致服务器报错
                    [NSThread sleepForTimeInterval:0.2];
                    
                    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                    params[@"id"] = likeContentId;
                    
                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiCircleDiscussLike withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                        
                        if (isSuccess) {
                            [[GHZoneLikeManager shareInstance].systemDiscussLikeIdArray addObject:likeContentId];
                        }
                        
                    }];
                    
                    
                }
                
            }
            
        }
        
        if (unlikeArray.count) {
            
            for (NSString *likeContentId in unlikeArray) {
                
                if (likeContentId.length) {
                    
                    [NSThread sleepForTimeInterval:0.2];
                    
                    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                    params[@"id"] = likeContentId;
                    
                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_DELETE withUrl:kApiCircleDiscussLike withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                        
                        if (isSuccess) {
                            [[GHZoneLikeManager shareInstance].systemDiscussLikeIdArray removeObject:likeContentId];
                        }
                        
                    }];
                    
                    
                }
                
            }
            
        }
        
    });
    
}

- (void)synchronousReplyLikeData {
 
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSMutableArray *likeArray = [[NSMutableArray alloc] init];
        NSMutableArray *unlikeArray = [[NSMutableArray alloc] init];
        
        for (NSString *likeContentId in [GHZoneLikeManager shareInstance].localReplyLikeIdArray) {
            
            // 服务器不包含 该资源 id
            if (![[GHZoneLikeManager shareInstance].systemReplyLikeIdArray containsObject:ISNIL(likeContentId)]) {
                [likeArray addObject:likeContentId];
            }
            
        }
        
        for (NSString *likeContentId in [GHZoneLikeManager shareInstance].systemReplyLikeIdArray) {
            
            // 本地不包含 该资源 id
            if (![[GHZoneLikeManager shareInstance].localReplyLikeIdArray containsObject:ISNIL(likeContentId)]) {
                [unlikeArray addObject:likeContentId];
            }
            
        }
        
        if (likeArray.count) {
            
            for (NSString *likeContentId in likeArray) {
                
                if (likeContentId.length) {
                    
                    [NSThread sleepForTimeInterval:0.2];
                    
                    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                    params[@"id"] = likeContentId;
                    
                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_POST withUrl:kApiCircleReplyLike withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                        
                        if (isSuccess) {
                            [[GHZoneLikeManager shareInstance].systemReplyLikeIdArray addObject:likeContentId];
                        }
                        
                    }];
                    
                    
                }
                
            }
            
        }
        
        if (unlikeArray.count) {
            
            for (NSString *likeContentId in unlikeArray) {
                
                if (likeContentId.length) {
                    
                    [NSThread sleepForTimeInterval:0.2];
                    
                    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                    params[@"id"] = likeContentId;
                    
                    [[GHNetworkTool shareInstance] requestWithMethod:GHRequestMethod_DELETE withUrl:kApiCircleReplyLike withParameter:params withLoadingType:GHLoadingType_HideLoading withShouldHaveToken:true withContentType:GHContentType_Formdata completionBlock:^(BOOL isSuccess, NSString * _Nullable msg, id  _Nullable response) {
                        
                        if (isSuccess) {
                            [[GHZoneLikeManager shareInstance].systemReplyLikeIdArray removeObject:likeContentId];
                        }
                        
                    }];
                    
                    
                }
                
            }
            
        }
        
    });
    
}

@end
