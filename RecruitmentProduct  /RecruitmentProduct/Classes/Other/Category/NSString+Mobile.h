//
//  NSString+Mobile.h
//  RecruitmentProduct
//
//  Created by zy on 16/4/16.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Mobile)
//手机号是否正确
+ (NSString *)valiMobile:(NSString *)mobile;
//邮箱是否正确
+ (BOOL)isValidateEmail:(NSString *)Email;

@end
