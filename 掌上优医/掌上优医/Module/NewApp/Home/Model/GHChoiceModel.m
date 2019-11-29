//
//  GHChoiceModel.m
//  掌上优医
//
//  Created by GH on 2019/2/25.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHChoiceModel.h"

@implementation GHChoiceModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"modelId":@"id",
                                                                  @"comment":@"commentContent",
                                                                  @"pictures":@"commentImg"
                                                                  }];
}

-(NSString<Optional> *)cureMethod
{
    NSString *text = [NSString stringWithFormat:@"%@",_cureMethod];
    text = [text stringByReplacingOccurrencesOfString:@"1" withString:@"手术"];
    text = [text stringByReplacingOccurrencesOfString:@"2" withString:@"静养"];
    text = [text stringByReplacingOccurrencesOfString:@"3" withString:@"药物"];
    text = [text stringByReplacingOccurrencesOfString:@"4" withString:@"其他"];
    return text;
}
-(NSString<Optional> *)cureState
{
    NSString *text = [NSString stringWithFormat:@"%@",_cureState];
    text = [text stringByReplacingOccurrencesOfString:@"1" withString:@"已痊愈"];
    text = [text stringByReplacingOccurrencesOfString:@"2" withString:@"有好转"];
    text = [text stringByReplacingOccurrencesOfString:@"3" withString:@"观察中"];
    text = [text stringByReplacingOccurrencesOfString:@"4" withString:@"无效果"];
    return text;
}



@end
