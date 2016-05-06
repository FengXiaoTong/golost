//
//  zyzpHttpTool.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/3/31.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zyzpHttpTool : NSObject
/**
 *  GET 请求
 *
 *  @param URLString        URL
 *  @param parameters       请求参数
 *  @param downloadProgress 下载进程
 *  @param success          成功时回调
 *  @param failure          失败时回调
 */
+(void)GET:(NSString *)URLString parameters:(id)parameters
                                   progress:(void (^)())downloadProgress
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSError *error))failure;


/**
 *  POST 请求
 *
 *  @param URLString        URL
 *  @param parameters       请求参数
 *  @param downloadProgress 下载进程
 *  @param success          成功时回调
 *  @param failure          失败时回调
 */
+(void)POST:(NSString *)URLString parameters:(id)parameters
                                    progress:(void (^)())downloadProgress
                                     success:(void (^)(id responseObject))success
                                     failure:(void (^)(NSError *error))failure;
@end
