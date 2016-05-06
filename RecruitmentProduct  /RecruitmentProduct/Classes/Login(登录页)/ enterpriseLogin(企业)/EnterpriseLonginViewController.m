//
//  EnterpriseLonginViewController.m
//  RecruitmentProduct
//
//  Created by zy on 16/4/14.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "EnterpriseLonginViewController.h"
#import "EnterpriseRegisterVC.h"
#import "UIView+ZYFrame.h"
#import "LoginViewController.h"
#import "zyzpHttpTool.h"
#import "Common.h"
#import "Account.h"
#import "EnterprseForgetPasswordVC.h"
#import "zyzpTabBarController.h"



@interface EnterpriseLonginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *enterpriseUserId;
@property (weak, nonatomic) IBOutlet UITextField *enterprisePassword;
@property (weak, nonatomic) IBOutlet UIButton *enterpriseLoginBtn;

@property (nonatomic, strong) NSDictionary *info;

@end

@implementation EnterpriseLonginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self clickTableViewHideKyeboard];
    [self setUpAddSubviews];
}

//登录
- (IBAction)enterpriseLoginClick:(id)sender {
    
    NSString *url = [baseUrl stringByAppendingPathComponent:@"companyLogin.htm"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"userName":_enterpriseUserId.text,@"passWord":_enterprisePassword.text}];
    [zyzpHttpTool POST:url parameters:dict progress:^{
        
    } success:^(id responseObject) {
       
        if ([responseObject[@"status"] isEqualToString:@"01"]) {
            self.info = [NSMutableDictionary dictionaryWithDictionary:@{KHouseholdMark:kEnterprise,kCompanyId:responseObject[kCompanyId]}];
            [[Account currentAccount] saveLogin:self.info];
            
            [self dismissViewControllerAnimated:YES completion:nil];

        }else{
            [self setAlertView:responseObject[@"message"]];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@">>>>>>>>>%@",error);
    }];
}

//忘记密码
- (IBAction)enterpriseForgetPasswordClick:(id)sender {

    [self.navigationController pushViewController:[EnterprseForgetPasswordVC new] animated:YES];
}

//注册
- (IBAction)enterpriseRegisterClick:(id)sender {
    [self.navigationController pushViewController:[EnterpriseRegisterVC new] animated:YES];
}

//取消模态
-(void)leftBtnClick{
    if (_isIndividual) {
        [self.navigationController popViewControllerAnimated:YES];
        //出栈到指定控制器
//                [self.navigationController popToViewController:[] animated:YES];

        _isIndividual = NO;
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


//添加提示框
- (void)setAlertView:(NSString *)str{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}


//切换个人登录
-(void)showSchoolList{
    
    LoginViewController *login = [[LoginViewController alloc] init];
    login.isEnterprise = YES;
    
    [self.navigationController pushViewController:login animated:YES];
}

//添加视图
- (void)setUpAddSubviews{
    UILabel *navLabel = [[UILabel alloc] init];
    navLabel.frame = CGRectMake(0, 0, 100, 30);
    [navLabel setTextColor:[UIColor whiteColor]];
    navLabel.text = @"指缘企业登录";
    navLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = navLabel;
    
    _enterpriseLoginBtn.layer.cornerRadius = 10.0;
    
    [self clickTableViewHideKyeboard];
    UIButton *leftBtn = [self setUpBtnTitle:@""];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];

    leftBtn.width = 40;
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIButton *rightBtn = [self setUpBtnTitle:@"个人登录"];
    
    [rightBtn setImage:[UIImage imageNamed:@"nav_go"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 95, 0, 0)];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    rightBtn.width = 110;
    [rightBtn addTarget:self action:@selector(showSchoolList) forControlEvents:UIControlEventTouchUpInside];
    if (!_isIndividual) {
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
    [_enterpriseUserId resignFirstResponder];
    [_enterprisePassword resignFirstResponder];
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
