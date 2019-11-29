//
//  GHSearchSicknessModel.m
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHSearchSicknessModel.h"

@implementation GHSearchSicknessModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id"}];
}

- (void)setSymptom:(NSString<Optional> *)symptom {
    
    _symptom = [GHFilterHTMLTool filterHTML:ISNIL(symptom)];
    
}

- (void)setSummary:(NSString<Optional> *)summary {
    
    _summary = [GHFilterHTMLTool filterHTML:ISNIL(summary)];
    
}

- (void)setPrevent:(NSString<Optional> *)prevent {
    
    _prevent = [GHFilterHTMLTool filterHTML:ISNIL(prevent)];
    
}

- (void)setDiagnosis:(NSString<Optional> *)diagnosis {
    
    _diagnosis = [GHFilterHTMLTool filterHTML:ISNIL(diagnosis)];
    
}

- (void)setPathogeny:(NSString<Optional> *)pathogeny {
   
    _pathogeny = [GHFilterHTMLTool filterHTML:ISNIL(pathogeny)];

}

- (void)setTreatment:(NSString<Optional> *)treatment {
    
    _treatment = [GHFilterHTMLTool filterHTML:ISNIL(treatment)];
    
}

@end
