//
//  LCMbaseViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/2.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMbaseViewController.h"

@interface LCMbaseViewController ()


@end

@implementation LCMbaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_image"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.hidden = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
