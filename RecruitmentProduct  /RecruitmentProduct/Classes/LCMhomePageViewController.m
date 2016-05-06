//
//  LCMhomePageViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/2.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMhomePageViewController.h"

@interface LCMhomePageViewController ()

@end

@implementation LCMhomePageViewController






- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
