//
//  GHSearchDoctorModel.m
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHSearchDoctorModel.h"

@implementation GHSearchDoctorModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id"}];
}

- (void)setDoctorInfo:(NSString<Optional> *)doctorInfo {
    
    _doctorInfo = [GHFilterHTMLTool filterHTML:ISNIL(doctorInfo)];
    
}

- (void)setSpecialize:(NSString<Optional> *)specialize {
    
    _specialize = [GHFilterHTMLTool filterHTML:ISNIL(specialize)];
    
}

- (NSString<Optional> *)commentScore {
    
    return [NSString stringWithFormat:@"%.1f", [_commentScore integerValue] / 10.f];
    
}

- (NSString<Optional> *)score {
    
    return [NSString stringWithFormat:@"%.1f", [_score integerValue] / 10.f];
    
}

@end
