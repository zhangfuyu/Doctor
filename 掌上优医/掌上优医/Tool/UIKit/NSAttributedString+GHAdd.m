//
//  NSAttributedString+GHAdd.m
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import "NSAttributedString+GHAdd.h"

@implementation NSAttributedString (GHAdd)

/**
 * 网络搜索关键字高亮
 * string:          内容
 * searchString:    搜索关键字
 */
+ (NSMutableAttributedString *)rangeSearchLight:(NSString *)string searchString:(NSString *)searchString
{
    NSString *strAfterDecodeByUTF8AndURI = [searchString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSRange range = [string rangeOfString:strAfterDecodeByUTF8AndURI];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:string];
    [attr setAttributes:@{NSForegroundColorAttributeName: kDefaultBlueColor}
                  range:range];
    return attr;
}

+ (NSMutableAttributedString *)getAttributedStringWithSearchString:(NSString *)searchString {
    
//    NSString *strAfterDecodeByUTF8AndURI = [searchString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSRange range = [string rangeOfString:strAfterDecodeByUTF8AndURI];
//    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:string];
//    [attr setAttributes:@{NSForegroundColorAttributeName: kDefaultBlueColor}
//                  range:range];
//    return attr;
    
    NSScanner * scanner = [NSScanner scannerWithString:searchString];
    NSString * text = nil;
    
    NSMutableArray *startIndexArray = [[NSMutableArray alloc] init];
    NSMutableArray *endIndexArray = [[NSMutableArray alloc] init];
    
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        // 替换字符
        
        NSString *matchText = [NSString stringWithFormat:@"%@>",text];
        
        if ([matchText isEqualToString:@"<em>"]) {

            NSRange range = [searchString rangeOfString:matchText];
            
            if (range.location == NSNotFound) {
                continue;
            }
            
            NSString *startIndex = [NSString stringWithFormat:@"%ld", range.location];
                                    
            [startIndexArray addObject:startIndex];
            
            if (range.location + range.length <= searchString.length) {
                searchString = [searchString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@"" options:NSCaseInsensitiveSearch range:range];
            }
            
            
            
//            searchString  =  [searchString  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
            
        } else if ([matchText isEqualToString:@"</em>"]) {
            
            NSRange range = [searchString rangeOfString:matchText];
            
            if (range.location == NSNotFound) {
                continue;
            }
            
            NSString *endIndex = [NSString stringWithFormat:@"%ld", range.location];
            
            [endIndexArray addObject:endIndex];
            
            if (range.location + range.length <= searchString.length) {
                searchString = [searchString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@"" options:NSCaseInsensitiveSearch range:range];
            }
            
//            searchString = [searchString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@"" options:NSCaseInsensitiveSearch range:range];
//            searchString  =  [searchString  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
            
        }
        
    }
    
//    NSString *strAfterDecodeByUTF8AndURI = [searchString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:searchString];
    
    for (NSInteger index = 0; index < startIndexArray.count; index++) {
        
        NSInteger startIndex = [[startIndexArray objectOrNilAtIndex:index] integerValue];
        NSInteger endIndex = [[endIndexArray objectOrNilAtIndex:index] integerValue];
        
        if (endIndex > startIndex && endIndex <= searchString.length) {
            [attr setAttributes:@{NSForegroundColorAttributeName: kDefaultBlueColor}
                          range:NSMakeRange(startIndex,endIndex - startIndex)];
        }
        
    }
    

    return attr;
    
}

@end
