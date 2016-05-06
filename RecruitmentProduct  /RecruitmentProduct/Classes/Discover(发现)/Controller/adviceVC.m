//
//  adviceVC.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/5.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  求职指导详情页面

#import "adviceVC.h"

@interface adviceVC ()

@end

@implementation adviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self addbarButton];
}

// 右边分享按钮
- (void)addbarButton
{
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAction) target:self action:@selector(rightButton:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)rightButton:(UIButton *)button
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此处是分享" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
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
