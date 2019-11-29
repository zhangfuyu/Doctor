//
//  GHZuJiSicknessModel.m
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHZuJiSicknessModel.h"

static NSString *kGHZuJiSicknessModelSymptom = @"kGHZuJiSicknessModelSymptom";
static NSString *kGHZuJiSicknessModelDiseaseName = @"kGHZuJiSicknessModelDiseaseName";
static NSString *kGHZuJiSicknessModelModelId = @"kGHZuJiSicknessModelModelId";
static NSString *kGHZuJiSicknessModelFirstDepartmentName = @"kGHZuJiSicknessModelFirstDepartmentName";

@implementation GHZuJiSicknessModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:ISNIL(self.symptom) forKey:kGHZuJiSicknessModelSymptom];
    [aCoder encodeObject:ISNIL(self.diseaseName) forKey:kGHZuJiSicknessModelDiseaseName];
    [aCoder encodeObject:ISNIL(self.modelId) forKey:kGHZuJiSicknessModelModelId];
    [aCoder encodeObject:ISNIL(self.firstDepartmentName) forKey:kGHZuJiSicknessModelFirstDepartmentName];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.symptom = [aDecoder decodeObjectForKey:kGHZuJiSicknessModelSymptom];
        self.diseaseName = [aDecoder decodeObjectForKey:kGHZuJiSicknessModelDiseaseName];
        self.modelId = [aDecoder decodeObjectForKey:kGHZuJiSicknessModelModelId];
        self.firstDepartmentName = [aDecoder decodeObjectForKey:kGHZuJiSicknessModelFirstDepartmentName];
        
    }
    return self;
    
}

@end
