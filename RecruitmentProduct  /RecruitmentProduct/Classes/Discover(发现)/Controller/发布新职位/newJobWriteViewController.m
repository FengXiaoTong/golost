//
//  newJobWriteViewController.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/18.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

/**
 *  4.18新增 职位描述
 */

#import "newJobWriteViewController.h"

@interface newJobWriteViewController ()

@end

@implementation newJobWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职位描述";
    [self addSub];
}

- (void)addSub
{
    UITextView *textV = [[UITextView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:textV];
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
