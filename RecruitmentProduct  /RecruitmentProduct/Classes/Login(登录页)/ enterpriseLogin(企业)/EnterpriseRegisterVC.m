//
//  EnterpriseRegisterVC.m
//  RecruitmentProduct
//
//  Created by zy on 16/4/15.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "EnterpriseRegisterVC.h"
#import "UIView+ZYFrame.h"
#import "RegisterViewController.h"
#import "NextStepViewController.h"
#import "NSString+Mobile.h"
#import "RegistrationInformation.h"

@interface EnterpriseRegisterVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *enterpriseInvitationCode;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseName;
@property (weak, nonatomic) IBOutlet UITextField *enterprisePhone;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseMail;
@property (weak, nonatomic) IBOutlet UITextField *enterprisePassword;
@property (weak, nonatomic) IBOutlet UITextField *enterpriseConfirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@end

@implementation EnterpriseRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self clickTableViewHideKyeboard];
    [self setUpAddSubviews];
}

//下一步
- (IBAction)enterpriseNextStepClick:(id)sender {
    
    if ([_enterpriseName.text isEqualToString:@""]){
        
        [self setAlertView:@"用户名不能为空"];
    }else if ([_enterprisePhone.text isEqualToString:@""]) {
        
        [self setAlertView:@"手机号不能为空"];
    }else if([_enterpriseMail.text isEqualToString:@""]){
        
        [self setAlertView:@"邮箱不能为空"];
    }else if ([_enterprisePassword.text isEqualToString:@""]){
        
        [self setAlertView:@"密码不能为空"];
    }else if ([_enterpriseConfirmPassword.text isEqualToString:@""]){
        
        [self setAlertView:@"请填写确认密码"];
    }else{
        if ([NSString valiMobile:_enterprisePhone.text]) {
            [self setAlertView:[NSString valiMobile:_enterprisePhone.text]];
        }else{
            if ([NSString isValidateEmail:_enterpriseMail.text]) {
                if ([_enterprisePassword.text isEqualToString:_enterpriseConfirmPassword.text]) {
                    
                    RegistrationInformation *model = [[RegistrationInformation alloc] init];
                    model.enterpriseInvitationCode = _enterpriseInvitationCode.text;
                    model.enterpriseName = self.enterpriseName.text;
                    model.enterprisePhone = self.enterprisePhone.text;
                    model.enterpriseMail = self.enterpriseMail.text;
                    model.enterprisePassword = self.enterprisePassword.text;
                    NextStepViewController *nextVC = [[NextStepViewController alloc] init];
                    nextVC.model = model;
                    [self.navigationController pushViewController:nextVC animated:YES];
                    
                    
                }else{
                    [self setAlertView:@"密码不一致"];
                }
                
            }else{
                [self setAlertView:@"邮箱格式不正确"];
            }
        }
    }
}

//返回
- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

//个人注册
- (void)showSchoolList{
    
    RegisterViewController *VC = [[RegisterViewController alloc] init];
    VC.isEnterpriseRegister = YES;
    
    [self.navigationController pushViewController:VC animated:YES];
}
//添加提示框
- (void)setAlertView:(NSString *)str{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}

//添加视图
- (void)setUpAddSubviews{
    UILabel *navLabel = [[UILabel alloc] init];
    navLabel.frame = CGRectMake(0, 0, 100, 30);
    [navLabel setTextColor:[UIColor whiteColor]];
    navLabel.text = @"指缘企业注册";
    navLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = navLabel;
    
    
    _nextStepBtn.layer.cornerRadius = 10.0;
    
    [self clickTableViewHideKyeboard];
    UIButton *leftBtn = [self setUpBtnTitle:@""];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];

    leftBtn.width = 40;
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIButton *rightBtn = [self setUpBtnTitle:@"个人注册"];
    
    [rightBtn setImage:[UIImage imageNamed:@"nav_go"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, 0)];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    rightBtn.width = 110;
    [rightBtn addTarget:self action:@selector(showSchoolList) forControlEvents:UIControlEventTouchUpInside];
    if (!_isIndividualRegister) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    }
}

-(UIButton *)setUpBtnTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}

//取消键盘
-(void)clickTableViewHideKyeboard{
    
    UITapGestureRecognizer *gestureR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeboard)];
    
    [self.view addGestureRecognizer:gestureR];
    
    gestureR.cancelsTouchesInView = NO;
}

-(void)hideKeboard{
    [_enterpriseInvitationCode resignFirstResponder];
    [_enterprisePassword resignFirstResponder];
    [_enterpriseName resignFirstResponder];
    [_enterprisePhone resignFirstResponder];
    [_enterpriseMail resignFirstResponder];
    [_enterpriseConfirmPassword resignFirstResponder];
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
