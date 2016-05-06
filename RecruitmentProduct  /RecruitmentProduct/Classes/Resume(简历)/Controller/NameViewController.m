//
//  NameViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/12.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "NameViewController.h"
#import "Common.h"
#import "PersonalViewController.h"

@interface NameViewController ()<UITextFieldDelegate>



@end

@implementation NameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;
    [self addRightItem];
    [self addTextField];
    
}

#pragma  mark -- 添加文本框
-(void)addTextField
{
    _name = [[UITextField alloc]initWithFrame:CGRectMake(0, 64, screenW, 40)];
    _name.borderStyle = UITextBorderStyleRoundedRect;
    _name.layer.borderColor = UIColor.blackColor.CGColor;
    _name.layer.borderWidth = 1.0f;
    _name.backgroundColor = [UIColor whiteColor];
    _name.delegate = self;
    _name.placeholder = @"请输入姓名";
    _name.textColor = [UIColor blackColor];
    _name.clearButtonMode = UITextFieldViewModeAlways;
    _name.secureTextEntry = NO;
//    _name.textAlignment = UITextAlignmentLeft;
    _name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _name.keyboardType = UIKeyboardTypeDefault;
    _name.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_name];
}

#pragma mark -- 添加导航栏rightItem
-(void)addRightItem
{
    self.navigationItem.title = @"简历名称";
    UIBarButtonItem * next = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickDone)];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName]= [UIColor blackColor];
    [next setTitleTextAttributes:att forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = next;
}


#pragma mark -- 点击保存/完成
-(void)clickDone
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    
//    [_name resignFirstResponder];    //[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
//    
//    return YES;
//    
//}

#pragma mark -- 键盘消失，即失去第一响应
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_name resignFirstResponder];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
