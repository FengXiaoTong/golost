//
//  ComputingTime.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/3.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ComputingTime.h"

@implementation ComputingTime


+ (NSString *)timeDifference:(NSString *)dateString {
    
    NSMutableString *timeString = [NSMutableString string];
    
    //获取当前时间
    NSDate *nowDate = [NSDate date];
    //获取model里的时间，转化为NSDate格式
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:dateString];
    
    //计算时间差
    long timeDifference = [nowDate timeIntervalSince1970] - [inputDate timeIntervalSince1970];
    
    if (timeDifference/3600 < 1)
    {
        timeString=[NSMutableString stringWithFormat:@"%ld分钟前", timeDifference/60];
    }
    if (timeDifference/3600 >= 1&&timeDifference/86400 < 1)
    {
        timeString=[NSMutableString stringWithFormat:@"%ld小时前", timeDifference/3600];
    }
    if (timeDifference/86400>1)
    {
        timeString=[NSMutableString stringWithFormat:@"%@小时前", timeString];
        ;
        if (timeDifference/86400 == 1) {
            timeString = [NSMutableString stringWithString:@"昨天"];
        }else if (timeDifference/86400 == 2){
            timeString = [NSMutableString stringWithString:@"前天"];
        }else {
            timeString = [NSMutableString stringWithString:[dateString substringToIndex:10]];
        }
    }
    return timeString;
}





@end
