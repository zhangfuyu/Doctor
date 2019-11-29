//
//  GHZuJiInformationModel.m
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHZuJiInformationModel.h"

static NSString *kGHZuJiInformationModelModelId = @"kGHZuJiInformationModelModelId";
static NSString *kGHZuJiInformationModelTitle = @"kGHZuJiInformationModelTitle";
static NSString *kGHZuJiInformationModelGmtCreate = @"kGHZuJiInformationModelGmtCreate";

@implementation GHZuJiInformationModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:ISNIL(self.modelId) forKey:kGHZuJiInformationModelModelId];
    [aCoder encodeObject:ISNIL(self.title) forKey:kGHZuJiInformationModelTitle];
    [aCoder encodeObject:ISNIL(self.gmtCreate) forKey:kGHZuJiInformationModelGmtCreate];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.modelId = [aDecoder decodeObjectForKey:kGHZuJiInformationModelModelId];
        self.title = [aDecoder decodeObjectForKey:kGHZuJiInformationModelTitle];
        self.gmtCreate = [aDecoder decodeObjectForKey:kGHZuJiInformationModelGmtCreate];
        
    }
    return self;
    
}

@end
