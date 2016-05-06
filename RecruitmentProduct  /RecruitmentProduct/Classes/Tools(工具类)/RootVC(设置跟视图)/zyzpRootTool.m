//
//  zyzpRootTool.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/3/29.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "zyzpRootTool.h"
#import "zyzpTabBarController.h"
#import "guideController.h"

@implementation zyzpRootTool

+(void)chooseWindowRootViewController:(UIWindow *)window{
    
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"appVersionKey"];
    // 当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = infoDic[@"CFBundleVersion"];
    
    if ([currentVersion isEqualToString:saveVersion]) {
        window.rootViewController = [[zyzpTabBarController alloc] init];
    }else{
        window.rootViewController = [[guideController alloc] init];
        // 保存与上一次不一样的版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"appVersionKey"];
        // 保存在本地
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

@end
