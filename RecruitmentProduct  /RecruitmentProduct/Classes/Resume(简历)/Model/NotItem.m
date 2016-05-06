//
//  NotItem.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/6.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "NotItem.h"

@implementation NotItem


+ (instancetype)itemWithtitle:(NSString *)title{
    
    NotItem *item = [[NotItem alloc]init];
    
    item.title = title;
    
    return item;
}

@end
