//
//  Account.m
//  RecruitmentProduct
//
//  Created by zy on 16/4/18.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//
#import "Account.h"
#import "Common.h"
#import "NSString+FilePath.h"

@interface Account ()<NSCoding>

@property (nonatomic, strong)NSString *uid;//用户id
@property (nonatomic, strong) NSString *householdMark;//用户标示

@end

@implementation Account

+(instancetype)currentAccount{
    static Account *account;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *filePath = [NSString filePathInDocumentsWithFileName:kAccountFileName];
        account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if (!account) {
            account = [[Account alloc] init];
        }
    });
    return account;
}


-(void)saveLogin:(NSDictionary *)info{
    
    
    self.householdMark = info[KHouseholdMark];
    if ([self.householdMark isEqualToString:kEnterprise]) {
        self.uid = info[kCompanyId];
    }else{
        self.uid = info[kPersonId];
    }
    //通过归档方式保存登录model
    [NSKeyedArchiver archiveRootObject:self toFile:[NSString filePathInDocumentsWithFileName:kAccountFileName]];
}

-(BOOL)isLogin{
    //有用户ID
    if (self.uid) {
        return YES;
    }
    
    return NO;
    
}

-(BOOL)isCompany{
    if ([self.householdMark isEqualToString:kEnterprise]) {
        return YES;
    }
    return NO;
}

#pragma mark - coding

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.householdMark forKey:KHouseholdMark];
    
    if ([self.householdMark isEqualToString:kEnterprise]) {
        [aCoder encodeObject:self.uid forKey:kCompanyId];
    }else{
        [aCoder encodeObject:self.uid forKey:kPersonId];
    }
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.householdMark = [aDecoder decodeObjectForKey:KHouseholdMark];
        if ([self.householdMark isEqualToString:kEnterprise]) {
            self.uid = [aDecoder decodeObjectForKey:kCompanyId];
        }else{
            self.uid = [aDecoder decodeObjectForKey:kPersonId];
        }
    }
    return self;
}

-(void)logout{
    
    self.uid = nil;
    self.householdMark = nil;
    NSString *filePath = [NSString filePathInDocumentsWithFileName:kAccountFileName];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

-(NSMutableDictionary *)requestParams{
    if (self.isLogin) {
        if ([self.householdMark isEqualToString:kEnterprise]) {
            return [NSMutableDictionary dictionaryWithObject:self.uid forKey:kCompanyId];
        }else{
           return [NSMutableDictionary dictionaryWithObject:self.uid forKey:kPersonId];
        }
    }
    return nil;
}

@end

