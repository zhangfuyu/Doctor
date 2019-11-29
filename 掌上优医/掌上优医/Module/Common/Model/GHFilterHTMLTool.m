//
//  GHFilterHTMLTool.m
//  掌上优医
//
//  Created by GH on 2018/11/24.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHFilterHTMLTool.h"

@implementation GHFilterHTMLTool

/**
 * 过滤标签
 */
+ (NSString *)filterHTML:(NSString *)str
{
    NSScanner * scanner = [NSScanner scannerWithString:str];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        // 替换字符
        
        if (!([[NSString stringWithFormat:@"%@>",text] isEqualToString:@"<em>"] || [[NSString stringWithFormat:@"%@>",text] isEqualToString:@"</em>"])) {
            str  =  [str  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        }
        
        // 替换空格转义符
        str  =  [str  stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    }
    return str;
}

+ (NSString *)filterHTMLPTag:(NSString *)str {
    
    NSScanner * scanner = [NSScanner scannerWithString:str];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        // 替换字符
        
        if (( [[NSString stringWithFormat:@"%@>",text] isEqualToString:@"<br/>"]  || [[NSString stringWithFormat:@"%@>",text] isEqualToString:@"<br />"])) {
            str  =  [str  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        }
        
        // 替换空格转义符
        str  =  [str  stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    }
    
//    if ([str hasSuffix:@"</p>"]) {
//        return [str substringToIndex:str.length - 4];
//    }
    
    return str;
    
}

+ (NSString *)filterHTMLEMTag:(NSString *)str {
    
    NSScanner * scanner = [NSScanner scannerWithString:str];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        // 替换字符
        str  =  [str  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        // 替换空格转义符
        str  =  [str  stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    }
    return str;
    
}

+ (NSString *)filterHTMLImage:(NSString *)str{
    NSScanner * scanner = [NSScanner scannerWithString:str];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<img" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        str  =  [str  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@"【图片】"];
    }
    return str;
}

+ (NSString *)filterHTMLTag:(NSString *)str {
    //替换字符
    str  =  [str  stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"-"];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"\""];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"\""];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"’"];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&lsquo;" withString:@"‘"];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&middot;" withString:@"·"];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    str  =  [str  stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
    str  =  [str  stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
    str  =  [str  stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    return str;
    
}

@end
