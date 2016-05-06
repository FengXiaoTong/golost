//
//  NSString+FilePath.h

//
//  Created by qingyun on /12/24.
//  Copyright ©All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FilePath)

/**
 *  根据文件名，返回文件在Documents下的路径
 *
 *  @param filename 文件名字
 *
 *  @return 文件路径
 */
+(NSString *)filePathInDocumentsWithFileName:(NSString *)filename;

@end
