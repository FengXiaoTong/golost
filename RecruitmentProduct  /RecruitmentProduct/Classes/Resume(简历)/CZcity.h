//
//  CZcity.h
//  省市

//
//  Copyright © 2016年 zph. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface CZcity : NSObject
@property (nonatomic,strong)NSArray *cities;
@property (nonatomic,copy)NSString *name;

//重写init方法
-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)citiesWithDic:(NSDictionary *)dic;
@end
