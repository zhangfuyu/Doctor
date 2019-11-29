//
//  GHHomeBannerModel.m
//  掌上优医
//
//  Created by GH on 2018/11/19.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHHomeBannerModel.h"

static NSString *kGHHomeBannerModel_ModelId = @"kGHHomeBannerModel_ModelId";
static NSString *kGHHomeBannerModel_Desc = @"kGHHomeBannerModel_Desc";
static NSString *kGHHomeBannerModel_GmtCreate = @"kGHHomeBannerModel_GmtCreate";
static NSString *kGHHomeBannerModel_ShowOrder = @"kGHHomeBannerModel_ShowOrder";
static NSString *kGHHomeBannerModel_Url = @"kGHHomeBannerModel_Url";

@implementation GHHomeBannerModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id", @"desc":@"describe",@"activityUrl":@"actionUrl"}];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:ISNIL(self.modelId) forKey:kGHHomeBannerModel_ModelId];
    [aCoder encodeObject:ISNIL(self.desc) forKey:kGHHomeBannerModel_Desc];
    [aCoder encodeObject:ISNIL(self.gmtCreate) forKey:kGHHomeBannerModel_GmtCreate];
    [aCoder encodeObject:ISNIL(self.showOrder) forKey:kGHHomeBannerModel_ShowOrder];
    [aCoder encodeObject:ISNIL(self.url) forKey:kGHHomeBannerModel_Url];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.modelId = [aDecoder decodeObjectForKey:kGHHomeBannerModel_ModelId];
        self.desc = [aDecoder decodeObjectForKey:kGHHomeBannerModel_Desc];
        self.gmtCreate = [aDecoder decodeObjectForKey:kGHHomeBannerModel_GmtCreate];
        self.showOrder = [aDecoder decodeObjectForKey:kGHHomeBannerModel_ShowOrder];
        self.url = [aDecoder decodeObjectForKey:kGHHomeBannerModel_Url];
        
    }
    return self;
    
}

@end
