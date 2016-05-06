//
//  SwitchViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/13.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "SwitchViewController.h"
#import "PushDating.h"


@interface SwitchViewController ()

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.hidden = NO;

    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 30, 200, 50);
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"切换至交友" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}


//压入交友界面
-(void)buttonAction {
    [PushDating pushDating:self.view.window];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
