//
//  LCMbaseViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/2.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMbaseViewController.h"
#import "LCMhomePageViewController.h"
#import "LCMnearViewController.h"
#import "LCMfoundViewController.h"
#import "LCMinformatioViewController.h"
#import "LCMmyViewController.h"

@interface LCMbaseViewController ()


@end

@implementation LCMbaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



-(void)setUpChildeViewControllerToTabBar{
    LCMhomePageViewController *homeVC = [[LCMhomePageViewController alloc] init];
    [self addPropertyToChildVC:homeVC image:[UIImage imageNamed:@"home_tab_home"] selectedImage:[UIImage imageNamed:@"home_tab_home_on"] title:@"首页"];
    
    LCMnearViewController *nearVC = [[LCMnearViewController alloc] init];
    [self addPropertyToChildVC:nearVC image:[UIImage imageNamed:@"home_tab_jianli"] selectedImage:[UIImage imageNamed:@"home_tab_jianli_on"] title:@"简历"];
    
    LCMfoundViewController *foundVC = [[LCMfoundViewController alloc] init];
    [self addPropertyToChildVC:foundVC image:[UIImage imageNamed:@"drafts_hui"] selectedImage:[UIImage imageNamed:@"drafts"] title:@"职位"];
    
    LCMinformatioViewController *informationVC = [[LCMinformatioViewController alloc] init];
    [self addPropertyToChildVC:informationVC image:[UIImage imageNamed:@"home_tab_me"] selectedImage:[UIImage imageNamed:@"home_tab_me_on"] title:@"我的"];
    
    LCMmyViewController *MyVC = [[LCMmyViewController alloc] init];
    [self addPropertyToChildVC:MyVC image:[UIImage imageNamed:@"home_tab_me"] selectedImage:[UIImage imageNamed:@"home_tab_me_on"] title:@"我的"];
    
}

-(void)addPropertyToChildVC:(UIViewController *)VC image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = image;
    VC.tabBarItem.selectedImage = selectedImage;
    zyzpNavigationController *NAV = [[zyzpNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:NAV];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
