//
//  GHNoticeSystemModel.m
//  掌上优医
//
//  Created by GH on 2018/11/13.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHNoticeSystemModel.h"

static NSString *kContentKey = @"kContentKey";
static NSString *kTimeKey = @"kTimeKey";
static NSString *kIdKey = @"kIdKey";
static NSString *kTitleKey = @"kTitleKey";

@implementation GHNoticeSystemModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:ISNIL(self.content) forKey:kContentKey];
    [aCoder encodeObject:ISNIL(self.createDate) forKey:kTimeKey];
    [aCoder encodeObject:ISNIL(self.modelId) forKey:kIdKey];
    [aCoder encodeObject:ISNIL(self.title) forKey:kTitleKey];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.content = [aDecoder decodeObjectForKey:kContentKey];
        self.createDate = [aDecoder decodeObjectForKey:kTimeKey];
        self.modelId = [aDecoder decodeObjectForKey:kIdKey];
        self.title = [aDecoder decodeObjectForKey:kTitleKey];
        
    }
    return self;
    
}

@end
