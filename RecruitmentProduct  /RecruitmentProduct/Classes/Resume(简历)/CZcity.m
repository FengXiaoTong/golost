//
//  CZcity.m
//  省市
//

//  Copyright © 2016年 zph. All rights reserved.
//


#import "CZcity.h"

@implementation CZcity

/**
 *  重写init方法
 */
-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)citiesWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
