//
//  zyzpTabBarController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/3/29.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "zyzpTabBarController.h"
#import "homeViewController.h"
#import "resumeViewController.h"
#import "discoverViewController.h"
#import "profileViewController.h"
#import "zyzpNavigationController.h"
#import "Account.h"

@interface zyzpTabBarController ()

@end

@implementation zyzpTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpChildeViewControllerToTabBar];
}

-(void)setUpChildeViewControllerToTabBar{
    
//    [self removeFromParentViewController];
    homeViewController *homeVC = [[homeViewController alloc] init];
    [self addPropertyToChildVC:homeVC image:[UIImage imageNamed:@"home_tab_home"] selectedImage:[UIImage imageNamed:@"home_tab_home_on"] title:@"首页"];
    
    resumeViewController *resumeVC = [[resumeViewController alloc] init];
    [self addPropertyToChildVC:resumeVC image:[UIImage imageNamed:@"home_tab_jianli"] selectedImage:[UIImage imageNamed:@"home_tab_jianli_on"] title:@"简历"];
    
        discoverViewController *discoverVC = [[discoverViewController alloc] init];
    if ([[Account currentAccount] isLogin]) {
        if ([[Account currentAccount] isCompany]) {
            [self addPropertyToChildVC:discoverVC image:[UIImage imageNamed:@"drafts_hui"] selectedImage:[UIImage imageNamed:@"drafts"] title:@"职位"];
        }else{
            [self addPropertyToChildVC:discoverVC image:[UIImage imageNamed:@"home_tab_discover"] selectedImage:[UIImage imageNamed:@"home_tab_discover_on"] title:@"发现"];
        }
    }else{
        [self addPropertyToChildVC:discoverVC image:[UIImage imageNamed:@"home_tab_discover"] selectedImage:[UIImage imageNamed:@"home_tab_discover_on"] title:@"发现"];
    }
    
    profileViewController *profileVC = [[profileViewController alloc] init];
    [self addPropertyToChildVC:profileVC image:[UIImage imageNamed:@"home_tab_me"] selectedImage:[UIImage imageNamed:@"home_tab_me_on"] title:@"我的"];
}

-(void)addPropertyToChildVC:(UIViewController *)VC image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = image;
    VC.tabBarItem.selectedImage = selectedImage;
    zyzpNavigationController *NAV = [[zyzpNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:NAV];
}

@end
