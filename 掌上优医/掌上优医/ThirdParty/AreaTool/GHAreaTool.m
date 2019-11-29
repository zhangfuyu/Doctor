//
//  GHAreaTool.m
//  掌上优医
//
//  Created by GH on 2018/10/26.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHAreaTool.h"
#import "GHAreaModel.h"
#import "PinYin4Objc.h"

@implementation GHAreaTool

+ (instancetype)shareInstance {
    
    static GHAreaTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[GHAreaTool alloc] init];
    });
    return _tool;
    
}

- (NSArray *)getAllProvinceArray {
    
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pca-code" ofType:@"json"]];
    
    if (jsonData == nil) {
        return nil;
    }
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    if (dataArray == nil) {
        return nil;
    }
    
    NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *provinceInfo in dataArray) {
        
        GHAreaModel *provinceModel = [[GHAreaModel alloc] init];
        provinceModel.areaName = provinceInfo[@"name"];
        provinceModel.areaCode = provinceInfo[@"code"];
        provinceModel.children = provinceInfo[@"children"];
        
        [provinceArray addObject:provinceModel];
        
    }
    
    return [provinceArray copy];
    
}

- (NSArray *)getAllCityArray {
    
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pca-code" ofType:@"json"]];
    
    if (jsonData == nil) {
        return nil;
    }
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    if (dataArray == nil) {
        return nil;
    }
    
    NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *provinceInfo in dataArray) {
        
        GHAreaModel *provinceModel = [[GHAreaModel alloc] init];
        provinceModel.areaName = provinceInfo[@"name"];
        provinceModel.areaCode = provinceInfo[@"code"];
        
        NSMutableArray *cityArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *cityInfo in provinceInfo[@"children"]) {
            
            GHAreaModel *cityModel = [[GHAreaModel alloc] init];
            cityModel.areaName = cityInfo[@"name"];
            cityModel.areaCode = cityInfo[@"code"];
            cityModel.children = cityInfo[@"children"];
            
            [cityArray addObject:cityModel];
            
        }
        
        provinceModel.children = [cityArray copy];
        
        [provinceArray addObject:provinceModel];
        
    }
    
    return [provinceArray copy];
    
}


- (NSArray *)getProvinceCityArray {
    return [self getAllCityArray];
}

- (NSArray *)getProvinceCityAreaArray {
    return [self getAllAreaArray];
}


- (NSArray *)getAllAreaArray {
    
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pca-code" ofType:@"json"]];
    
    if (jsonData == nil) {
        return nil;
    }
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    if (dataArray == nil) {
        return nil;
    }
    
    NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *provinceInfo in dataArray) {
        
        GHAreaModel *provinceModel = [[GHAreaModel alloc] init];
        provinceModel.areaName = provinceInfo[@"name"];
        provinceModel.areaCode = provinceInfo[@"code"];
        
        NSMutableArray *cityArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *cityInfo in provinceInfo[@"children"]) {
            
            GHAreaModel *cityModel = [[GHAreaModel alloc] init];
            cityModel.areaName = cityInfo[@"name"];
            cityModel.areaCode = cityInfo[@"code"];
            
            NSMutableArray *areaArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *areaInfo in cityInfo[@"children"]) {
                
                GHAreaModel *areaModel = [[GHAreaModel alloc] init];
                areaModel.areaName = areaInfo[@"name"];
                areaModel.areaCode = areaInfo[@"code"];
                
                [areaArray addObject:areaModel];
                
            }
            
            cityModel.children = [areaArray copy];
            
            [cityArray addObject:cityModel];
            
        }
        
        provinceModel.children = [cityArray copy];
        
        [provinceArray addObject:provinceModel];
        
    }
    
    return [provinceArray copy];
    
}


- (NSArray *)getSortCityArray {
    
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pca-code" ofType:@"json"]];
    
    if (jsonData == nil) {
        return nil;
    }
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    if (dataArray == nil) {
        return nil;
    }
    
    NSMutableArray *cityArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeUppercase];
    
    for (NSDictionary *provinceInfo in dataArray) {
        
        for (NSDictionary *cityInfo in provinceInfo[@"children"]) {
            
            GHAreaModel *cityModel = [[GHAreaModel alloc] init];
            cityModel.areaName = cityInfo[@"name"];
            cityModel.areaCode = cityInfo[@"code"];
            
            
            
            if ([cityModel.areaName isEqualToString:@"县"]) {
                continue;
            }
            
            if (cityModel.areaName.length) {
                
                if ([cityModel.areaName isEqualToString:@"市辖区"]) {
                    cityModel.areaName = provinceInfo[@"name"];
                }
                
                if ([cityModel.areaName isEqualToString:@"自治区直辖县级行政区划"] || [cityModel.areaName isEqualToString:@"省直辖县级行政区划"]) {
                    
                    for (NSDictionary *areaInfo in cityInfo[@"children"]) {
                        
                        GHAreaModel *cityModel = [[GHAreaModel alloc] init];
                        cityModel.areaName = areaInfo[@"name"];
                        cityModel.areaCode = areaInfo[@"code"];
                        
//                        if ([cityModel.areaName hasSuffix:@"市"]) {
//                            cityModel.areaName = [cityModel.areaName substringToIndex:cityModel.areaName.length - 1];
//                        }
                        
                        NSString *pinYin = [PinyinHelper toHanyuPinyinStringWithNSString:cityModel.areaName withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];
                        
                        if (pinYin.length > 0) {
                            
                            cityModel.fist = [pinYin substringToIndex:1];
                            
                            NSArray *pinyinArray = [pinYin componentsSeparatedByString:@" "];
                            
                            for (NSString *str in pinyinArray) {
                                
                                cityModel.pinYin = [NSString stringWithFormat:@"%@%@",ISNIL(cityModel.pinYin), ISNIL(str)];
                                
                                if (str.length) {
                                    cityModel.fistPinYin = [NSString stringWithFormat:@"%@%@",ISNIL(cityModel.fistPinYin), [str substringToIndex:1]];
                                }
                                
                            }
                            
                            if ([dic.allKeys containsObject:cityModel.fist]) {
                                
                                NSMutableArray *array = dic[cityModel.fist];
                                [array addObject:cityModel];
                                
                            } else {
                                
                                NSMutableArray *array = [[NSMutableArray alloc] init];
                                [array addObject:cityModel];
                                
                                dic[cityModel.fist] = array;
                                
                            }
                            
                        }
                        
                    }
                    
                    continue;
                    
                }
                
//                if ([cityModel.areaName hasSuffix:@"市"]) {
//                    cityModel.areaName = [cityModel.areaName substringToIndex:cityModel.areaName.length - 1];
//                }
                
                NSString *pinYin = [PinyinHelper toHanyuPinyinStringWithNSString:cityModel.areaName withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];
                
                if (pinYin.length > 0) {
                    
                    cityModel.fist = [pinYin substringToIndex:1];
                    
                    NSArray *pinyinArray = [pinYin componentsSeparatedByString:@" "];
                    
                    for (NSString *str in pinyinArray) {
                        
                        cityModel.pinYin = [NSString stringWithFormat:@"%@%@",ISNIL(cityModel.pinYin), ISNIL(str)];
                        
                        if (str.length) {
                            cityModel.fistPinYin = [NSString stringWithFormat:@"%@%@",ISNIL(cityModel.fistPinYin), [str substringToIndex:1]];
                        }
                        
                    }
                    
                    if ([dic.allKeys containsObject:cityModel.fist]) {
                        
                        NSMutableArray *array = dic[cityModel.fist];
                        [array addObject:cityModel];
                        
                    } else {
                        
                        NSMutableArray *array = [[NSMutableArray alloc] init];
                        [array addObject:cityModel];
                        
                        dic[cityModel.fist] = array;
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    NSArray *arr = [dic allKeys];
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    
    for (NSString *key in arr) {
        
        NSArray *valueArr = dic[key];
        valueArr = [valueArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            NSComparisonResult result = [ISNIL(((GHAreaModel *)obj1).pinYin) compare:ISNIL(((GHAreaModel *)obj2).pinYin)];
            return result==NSOrderedDescending;
        }];
        
        NSDictionary *d = @{@"key":key,@"value":valueArr};
        [cityArray addObject:d];
        
    }
    
    
    
    return [cityArray copy];
    
}

@end
