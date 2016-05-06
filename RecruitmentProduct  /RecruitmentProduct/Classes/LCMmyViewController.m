//
//  LCMmyViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/2.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMmyViewController.h"
#import "zyzpRootTool.h"


@interface LCMmyViewController ()

@end

@implementation LCMmyViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title = @"我";
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 0, 100, 100);
//    button.backgroundColor = [UIColor redColor];
//    [button setTitle:@"切换至招聘" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
}

-(void)buttonAction {

    [zyzpRootTool chooseWindowRootViewController:self.view.window];


}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
