//
//  newJobNameViewController.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/18.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

/**
 *  4.18 新增 发布职位--职位名称
 */

#import "newJobNameViewController.h"
#import "Common.h"

@interface newJobNameViewController ()


@end

@implementation newJobNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"职位名称";
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.textF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, screenW, 43)];
    _textF.font = [UIFont systemFontOfSize:15.0];
    _textF.placeholder = @"请输入职位名称";
    _textF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textF.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_textF];
    
    [self addRightButton];
    
}

- (void)addRightButton
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"完成" style:(UIBarButtonItemStylePlain) target:self action:@selector(actionButton:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)actionButton:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
