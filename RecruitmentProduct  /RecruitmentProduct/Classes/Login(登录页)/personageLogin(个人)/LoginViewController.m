//
//  LoginViewController.m
//  RecruitmentProduct
//
//  Created by zy on 16/3/31.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "UIView+ZYFrame.h"
#import "EnterpriseLonginViewController.h"
#import "zyzpHttpTool.h"
#import "Common.h"
#import "Account.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usersId;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) NSMutableDictionary *info;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpAddSubviews];
    
}

//取消模态
-(void)leftBtnClick{
    if (_isEnterprise) {
        [self.navigationController popViewControllerAnimated:YES];
        //出栈到指定控制器
//        [self.navigationController popToViewController:[] animated:YES];
        _isEnterprise = NO;
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//切换企业登录
-(void)showSchoolList{
    
    EnterpriseLonginViewController *enterprise = [[EnterpriseLonginViewController alloc] init];
    enterprise.isIndividual = YES;
    [self.navigationController pushViewController:enterprise animated:YES];
}

//登录
- (IBAction)logInClick:(id)sender {
    
    NSString *url = [baseUrl stringByAppendingString:@"phonePersonLogin.htm"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"userName":_usersId.text,@"passWord":_password.text}];
    
        [zyzpHttpTool GET:url parameters:dict progress:^{
        
    } success:^(id responseObject) {
        NSLog(@"........%@",responseObject);
        NSString *statusInt = responseObject[@"status"];
        int status = statusInt.intValue;
        
        NSLog(@"%d",status);
        if (status == 0) {
            self.info = [NSMutableDictionary dictionaryWithDictionary:@{KHouseholdMark:kPerson,kPersonId:responseObject[kPersonId]}];
            [[Account currentAccount] saveLogin:self.info];
            [self leftBtnClick];
            
        }else{
            [self setAlertView:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        NSLog(@">>>>>>>>>%@",error);
    }];
}

//注册
- (IBAction)registerClick:(id)sender {
    [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
}
//忘记密码
- (IBAction)forgetPasswordClick:(id)sender {
    [self.navigationController pushViewController:[ForgetPasswordViewController new] animated:YES];
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
    navLabel.text = @"指缘个人登录";
    navLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = navLabel;
    
    
    _loginBtn.layer.cornerRadius = 10.0;
    
    [self clickTableViewHideKyeboard];
    UIButton *leftBtn = [self setUpBtnTitle:@""];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    leftBtn.width = 40;
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIButton *rightBtn = [self setUpBtnTitle:@"企业登录"];
    
    [rightBtn setImage:[UIImage imageNamed:@"nav_go"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, 0)];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    rightBtn.width = 110;
    [rightBtn addTarget:self action:@selector(showSchoolList) forControlEvents:UIControlEventTouchUpInside];
    if (!_isEnterprise) {
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
    [_usersId resignFirstResponder];
    [_password resignFirstResponder];
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
