//
//  CompanyNameViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/19.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//   添加屏蔽公司名字

#import "CompanyNameViewController.h"
#import "Common.h"
#import "ReSetTableViewController.h"

@interface CompanyNameViewController ()<UITextFieldDelegate,PassingValueDelegate>

@property(nonatomic, strong)UITextField *nameText;

@end

@implementation CompanyNameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self addNameTextField];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self addRightButton];
}


#pragma mark -- 添加保存按钮
-(void)addRightButton
{
    self.navigationItem.title = @"添加屏蔽";
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:19],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIBarButtonItem * keep = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickKeep:)];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName]= [UIColor whiteColor];
    [keep setTitleTextAttributes:att forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = keep;
}


#pragma mark --点击保存
-(void)clickKeep:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewController:didPassingValueWithInfo:)]) {
        [self.delegate viewController:self didPassingValueWithInfo:_nameText.text];
    }
}


#pragma  mark -- 添加TextField
-(void)addNameTextField
{
    _nameText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0,screenW, 50)];
    [_nameText setBorderStyle:UITextBorderStyleRoundedRect];
    _nameText.placeholder = @"请输入公司名称";
    _nameText.returnKeyType = UIReturnKeyDone;
    _nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameText.delegate = self;
    _nameText.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_nameText];
}


#pragma mark -- 点击键盘完成，键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark -- 点击空白处键盘消失
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.nameText resignFirstResponder];
}

#pragma mark -- view将要消失的时候
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(viewController:didPassingValueWithInfo:)]) {
//        [self.delegate viewController:self didPassingValueWithInfo:_nameText.text];
//    }
//}

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
