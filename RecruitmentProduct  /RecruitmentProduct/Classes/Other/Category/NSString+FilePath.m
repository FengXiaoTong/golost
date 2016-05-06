//
//  NSString+FilePath.m
//  WeiBo1508
//
//  Created by qingyun on 15/12/24.
//  Copyright © 2015年 hnqingyun. All rights reserved.
//

#import "NSString+FilePath.h"

@implementation NSString (FilePath)

+(NSString *)filePathInDocumentsWithFileName:(NSString *)filename{
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [documentsPath stringByAppendingPathComponent:filename];
    return filePath;
}

@end
