//
//  GHTimeDealTool.m
//  掌上优医
//
//  Created by GH on 2018/11/12.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHTimeDealTool.h"
//#import "GHTopicModel.h"

@implementation GHTimeDealTool

//将本地日期字符串转为UTC日期字符串
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
+ (NSString *)getUTCFormateLocalDate:(NSString *)str {
    
    if (str.length == 0) {
        return @"";
    }
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval timeInterval = fabs([[NSDate date] timeIntervalSinceDate:timeDate]);
    
    if (timeInterval == 0) {
        timeInterval = 1;
    }
    
    long temp = 0;
    NSString *result = @"";
    
    return [timeDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
    
    if (timeInterval/60 < 1)
    {
        result = @"刚刚";
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    } else {
        
        result = [timeDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
    }
    
    return  result;

    
}

+ (NSString *)getShowTimeWithTimeStr:(NSString *)str {
    
    if (str.length == 0) {
        return @"";
    }
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval timeInterval = fabs([[NSDate date] timeIntervalSinceDate:timeDate]);
    
    if (timeInterval == 0) {
        timeInterval = 1;
    }
    
    long temp = 0;
    NSString *result = @"";
    
    result = [timeDate stringWithFormat:@"yyyy.MM.dd"];
    
    return result;
    
    if (timeInterval/60 < 1)
    {
        result = @"刚刚";
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    } else {
        result = [timeDate stringWithFormat:@"yyyy.MM.dd"];
    }

    return  result;

    
}

+ (NSString *)getShowQuestionTimeWithTimeStr:(NSString *)str {
    
    if (str.length == 0) {
        return @"";
    }
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval timeInterval = fabs([[NSDate date] timeIntervalSinceDate:timeDate]);
    
    if (timeInterval == 0) {
        timeInterval = 1;
    }
    
    long temp = 0;
    NSString *result = @"";
    
    if (timeInterval/60 < 1)
    {
        result = @"刚刚";
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    } else {
        result = [timeDate stringWithFormat:@"yyyy.MM.dd"];
    }
    
    return  result;
    
    
}


+ (id)getCircleNameWithId:(NSString *)modelId {
    
    return nil;
    
}

@end
