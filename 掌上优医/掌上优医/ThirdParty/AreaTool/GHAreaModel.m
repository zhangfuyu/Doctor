//
//  GHAreaModel.m
//  掌上优医
//
//  Created by GH on 2018/10/26.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHAreaModel.h"

static NSString *kAreaModel_ModelId = @"kAreaModel_ModelId";
static NSString *kAreaModel_AreaCode = @"kAreaModel_AreaCode";
static NSString *kAreaModel_ParentCode = @"kAreaModel_ParentCode";
static NSString *kAreaModel_AreaName = @"kAreaModel_AreaName";
static NSString *kAreaModel_AreaLevel = @"kAreaModel_AreaLevel";
static NSString *kAreaModel_PinYin = @"kAreaModel_PinYin";
static NSString *kAreaModel_FistPinYin = @"kAreaModel_FistPinYin";
static NSString *kAreaModel_Fist = @"kAreaModel_Fist";
static NSString *kAreaModel_Children = @"kAreaModel_Children";

@implementation GHAreaModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id"}];
}

- (NSMutableArray<Optional> *)children {
    
    if (!_children) {
        _children = [[NSMutableArray alloc] init];
    }
    return _children;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:ISNIL(self.modelId) forKey:kAreaModel_ModelId];
    [aCoder encodeObject:ISNIL(self.areaCode) forKey:kAreaModel_AreaCode];
    [aCoder encodeObject:ISNIL(self.parentCode) forKey:kAreaModel_ParentCode];
    [aCoder encodeObject:ISNIL(self.areaName) forKey:kAreaModel_AreaName];
    [aCoder encodeObject:ISNIL(self.areaLevel) forKey:kAreaModel_AreaLevel];
    [aCoder encodeObject:ISNIL(self.pinYin) forKey:kAreaModel_PinYin];
    [aCoder encodeObject:ISNIL(self.fistPinYin) forKey:kAreaModel_FistPinYin];
    [aCoder encodeObject:ISNIL(self.fist) forKey:kAreaModel_Fist];
    [aCoder encodeObject:[self.children copy] forKey:kAreaModel_Children];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.modelId = [aDecoder decodeObjectForKey:kAreaModel_ModelId];
        self.areaCode = [aDecoder decodeObjectForKey:kAreaModel_AreaCode];
        self.parentCode = [aDecoder decodeObjectForKey:kAreaModel_ParentCode];
        self.areaName = [aDecoder decodeObjectForKey:kAreaModel_AreaName];
        self.areaLevel = [aDecoder decodeObjectForKey:kAreaModel_AreaLevel];
        self.pinYin = [aDecoder decodeObjectForKey:kAreaModel_PinYin];
        self.fistPinYin = [aDecoder decodeObjectForKey:kAreaModel_FistPinYin];
        self.fist = [aDecoder decodeObjectForKey:kAreaModel_Fist];
        NSArray *array = [aDecoder decodeObjectForKey:kAreaModel_Children];
        self.children = [array mutableCopy];
        
    }
    return self;
    
}

@end
