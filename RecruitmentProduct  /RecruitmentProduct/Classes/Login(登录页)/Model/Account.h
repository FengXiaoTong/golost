//
//  Account.h
//  RecruitmentProduct
//
//  Created by zy on 16/4/18.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic) BOOL isComplete;


//单例的类方法
+(instancetype)currentAccount;

//保存登录信息的方法
-(void)saveLogin:(NSDictionary *)info;

//返回登录状态
-(BOOL)isLogin;


//返回版本YES是企业、NO是个人
-(BOOL)isCompany;



//返回求情open API 所需要的参数
-(NSMutableDictionary *)requestParams;

//清除登录信息
-(void)logout;


@end
