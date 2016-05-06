//
//  PushDating.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/3.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "PushDating.h"
#import "LCMhomePageViewController.h"
#import "LCMnearViewController.h"
#import "LCMfoundViewController.h"
#import "LCMinformatioViewController.h"
#import "LCMmyViewController.h"


@implementation PushDating


+(void)pushDating:(UIWindow *)window {

    UITabBarController *tbc = [[UITabBarController alloc] init];
    [self setUpChildeViewControllerToTabBar:tbc];
    
    window.rootViewController = tbc;
    
}

+(void)setUpChildeViewControllerToTabBar:(UITabBarController *)tbc{
    
    NSMutableArray *controllers = [NSMutableArray array];
    
    LCMhomePageViewController *homeVC = [[LCMhomePageViewController alloc] init];
    [self addPropertyToChildVC:homeVC image:[UIImage imageNamed:@"icon_nome_normal"] selectedImage:[UIImage imageNamed:@"icon_home_click"] title:@"首页"];
    UINavigationController *homeNVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [controllers addObject:homeNVC];
    
    
    LCMnearViewController *nearVC = [[LCMnearViewController alloc] init];
    [self addPropertyToChildVC:nearVC image:[UIImage imageNamed:@"icon_nearby_normal"] selectedImage:[UIImage imageNamed:@"icon_nearby_click"] title:@"附近"];
    UINavigationController *nearNVC = [[UINavigationController alloc] initWithRootViewController:nearVC];
    [controllers addObject:nearNVC];
    
    
    
    LCMfoundViewController *foundVC = [[LCMfoundViewController alloc] init];
    [self addPropertyToChildVC:foundVC image:[UIImage imageNamed:@"icon_find_normal"] selectedImage:[UIImage imageNamed:@"icon_find_click"] title:@"发现"];
    UINavigationController *foundNVC = [[UINavigationController alloc] initWithRootViewController:foundVC];
    [controllers addObject:foundNVC];
    
    
    
    LCMinformatioViewController *informationVC = [[LCMinformatioViewController alloc] init];
    [self addPropertyToChildVC:informationVC image:[UIImage imageNamed:@"icon_info_mormal"] selectedImage:[UIImage imageNamed:@"icon_info_click"] title:@"信息"];
    UINavigationController *informationNVC = [[UINavigationController alloc] initWithRootViewController:informationVC];
    [controllers addObject:informationNVC];
    
    
    
    LCMmyViewController *MyVC = [[LCMmyViewController alloc] init];
    [self addPropertyToChildVC:MyVC image:[UIImage imageNamed:@"icon_me_normal"] selectedImage:[UIImage imageNamed:@"icon_me_click"] title:@"我"];
    UINavigationController *MyNVC = [[UINavigationController alloc] initWithRootViewController:MyVC];

    [controllers addObject:MyNVC];
    
    
    tbc.viewControllers = controllers;
}

+(void)addPropertyToChildVC:(UIViewController *)VC image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = image;
    VC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}


@end
