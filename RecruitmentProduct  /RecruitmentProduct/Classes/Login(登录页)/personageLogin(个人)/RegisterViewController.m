//
//  RegisterViewController.m
//  RecruitmentProduct
//
//  Created by zy on 16/4/1.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "RegisterViewController.h"
#import "Common.h"
#import "UIView+ZYFrame.h"
#import "EnterpriseRegisterVC.h"
#import "NSString+Mobile.h"
#import "zyzpHttpTool.h"
#import "Account.h"

#import "PersonalViewController.h"


@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userID;
@property (weak, nonatomic) IBOutlet UITextField *enterPassword;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *verificationCode;
@property (weak, nonatomic) IBOutlet UITextField *invitationCode;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (nonatomic) int operation;
@property (nonatomic, strong) NSDictionary *info;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAddSubviews];
    self.operation = 0;

//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    
}
/*
-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo//计算键盘的高度
{
    CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    return keyboardEndingFrame.size.height;
}
-(void)keyboardWillAppear:(NSNotification *)notification
{
    CGRect currentFrame = self.view.frame;
    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    currentFrame.origin.y = currentFrame.origin.y - change ;
    self.view.frame = currentFrame;
}

-(void)keyboardWillDisappear:(NSNotification *)notification
{
    CGRect currentFrame = self.view.frame;
    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    currentFrame.origin.y = currentFrame.origin.y + change ;
    self.view.frame = currentFrame;
}
*/

//注册
- (IBAction)registerClick:(id)sender {
    if ([_userID.text isEqualToString:@""]){
        
        [self setAlertView:@"用户名不能为空"];
    }else if ([_verificationCode.text isEqualToString:@""]) {
        
        [self setAlertView:@"请填写验证码"];
    }else if([_enterPassword.text isEqualToString:@""] && (_enterPassword.text.length >= 6 || _enterPassword.text.length <= 18)){
        
        [self setAlertView:@"请输入6-18个字符"];
    }else if ([_confirmPassword.text isEqualToString:@""]){
        
        [self setAlertView:@"请填写确认密码"];
    }else {
        
        if ([NSString valiMobile:_userID.text] && ![NSString isValidateEmail:_userID.text]) {
            [self setAlertView:@"请填写正确的手机号或邮箱"];
        }else{
            if ([_confirmPassword.text isEqualToString:_enterPassword.text]) {
                //做注册的网络请求
                NSString *urlString = [baseUrl stringByAppendingString:@"/registerPhoneUser.htm"];
                NSDictionary *dict = @{@"userName":self.userID.text,@"verifyCode":self.verificationCode.text,@"inviteId":self.invitationCode.text,@"passWord":self.enterPassword.text};

                [zyzpHttpTool GET:urlString parameters:dict progress:^{
                    
                } success:^(id responseObject) {
                    NSString *statusInt = responseObject[@"status"];
                    int status = statusInt.intValue;
                    
                    NSLog(@"%d",status);
                    if (status == 1) {
                        self.info = [NSMutableDictionary dictionaryWithDictionary:@{KHouseholdMark:kPerson,kPersonId:responseObject[kPersonId]}];
                        [[Account currentAccount] saveLogin:self.info];
                        [Account currentAccount].isComplete = YES;



                        [self.navigationController pushViewController:[PersonalViewController new] animated:YES];
                    }
                        [self setAlertView:responseObject[@"message"]];
                } failure:^(NSError *error) {
                    
                }];
                
            }else{
                [self setAlertView:@"密码不一致"];
            }
        }
    }
}
//获取验证码
- (IBAction)verificationClick:(id)sender {
    self.operation = _operation + 1;
    if ([NSString valiMobile:_userID.text] && ![NSString isValidateEmail:_userID.text]) {
        [self setAlertView:@"请填写正确的手机号或邮箱"];
    }else{
        //做注册的网络请求
        NSLog(@"获取验证码的网络请求");
        NSString *operationStr = [NSString stringWithFormat:@"%d",self.operation];
        
        NSString *urlString = [baseUrl stringByAppendingString:@"/getCodeForRegister.htm"];
        
        NSDictionary *dict = @{@"userName":self.userID.text,@"operation":operationStr};
        [zyzpHttpTool GET:urlString parameters:dict progress:^{
            
        } success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            [self setAlertView:responseObject[@"message"]];
        } failure:^(NSError *error) {
            
        }];
        
    }
}
//阅读条款
- (IBAction)readingClauseClick:(id)sender {
    
    
}
//返回登录
- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//企业注册
- (void)showSchoolList{
    
    EnterpriseRegisterVC *VC = [[EnterpriseRegisterVC alloc] init];
    VC.isIndividualRegister = YES;
    
    [self.navigationController pushViewController:VC animated:YES];
}
//添加提示框
- (void)setAlertView:(NSString *)str{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}


- (void)setUpAddSubviews{
    
    UILabel *navLabel = [[UILabel alloc] init];
    navLabel.frame = CGRectMake(0, 0, 100, 30);
    [navLabel setTextColor:[UIColor whiteColor]];
    navLabel.text = @"指缘个人注册";
    navLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = navLabel;
    
    
    _registerBtn.layer.cornerRadius = 10.0;
    
    [self clickTableViewHideKyeboard];
    UIButton *leftBtn = [self setUpBtnTitle:@""];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];

    leftBtn.width = 40;
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIButton *rightBtn = [self setUpBtnTitle:@"企业注册"];
    
    [rightBtn setImage:[UIImage imageNamed:@"nav_go"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, 0)];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    rightBtn.width = 110;
    [rightBtn addTarget:self action:@selector(showSchoolList) forControlEvents:UIControlEventTouchUpInside];
    if (!_isEnterpriseRegister) {
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
    [_userID resignFirstResponder];
    [_enterPassword resignFirstResponder];
    [_confirmPassword resignFirstResponder];
    [_verificationCode resignFirstResponder];
    [_invitationCode resignFirstResponder];
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
