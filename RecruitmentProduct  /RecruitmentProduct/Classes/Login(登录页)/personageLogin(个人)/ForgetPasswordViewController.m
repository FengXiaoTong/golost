//
//  ForgetPasswordViewController.m
//  RecruitmentProduct
//
//  Created by zy on 16/4/1.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "UIView+ZYFrame.h"
#import "Common.h"
#import "zyzpHttpTool.h"

@interface ForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userID;
@property (weak, nonatomic) IBOutlet UITextField *persenCode;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
@property (nonatomic, assign) int operation;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self clickTableViewHideKyeboard];
    [self setUpAddSubviews];
    self.operation = 0;
}
//获取验证码
- (IBAction)verificationCodeBtnClick:(id)sender {
    self.operation = _operation + 1;
    
    NSString *urlString = [baseUrl stringByAppendingString:@"/getCodeForChangePwd.htm"];
    NSString *operationString = [NSString stringWithFormat:@"%d",self.operation];
    NSDictionary *dict = @{@"userName":self.userID.text,@"operation":operationString};
    
    [zyzpHttpTool GET:urlString parameters:dict progress:^{
        
    } success:^(id responseObject) {
        NSLog(@"responseObject>>>>>>>>%@",responseObject);
        [self setAlertView:responseObject[@"message"]];
    } failure:^(NSError *error) {
        NSLog(@"error>>>>>>>>%@",error);
    }];
    
    
}
//完成
- (IBAction)completeClick:(id)sender {
    
    
    if ([_userID.text isEqualToString:@""]){
        
        [self setAlertView:@"用户名不能为空"];
    }else if ([_persenCode.text isEqualToString:@""]) {
        
        [self setAlertView:@"请填写验证码"];
    }else if([_password.text isEqualToString:@""] && (_password.text.length >= 6 || _password.text.length <= 18)){
        
        [self setAlertView:@"请输入6-18个字符"];
    }else{
        if ([_confirmPassword.text isEqualToString:_password.text]) {
            NSString *urlString = [baseUrl stringByAppendingString:@"/resetPassword.htm"];
            NSDictionary *dict = @{@"userName":self.userID.text,@"password":self.password.text,@"checkCode":self.persenCode.text};

            
            [zyzpHttpTool GET:urlString parameters:dict progress:^{
                
            } success:^(id responseObject) {
                NSLog(@"responseObject>>>>>>>>%@",responseObject);
                [self setAlertView:responseObject[@"message"]];
                if ([responseObject[@"status"] isEqualToString:@"01"]) {
                    [self leftBtnClick];
                }
                
            } failure:^(NSError *error) {
                NSLog(@"error>>>>>>>>%@",error);
            }];
        }else{
            [self setAlertView:@"密码不一致"];
        }
    }
}


//添加视图
- (void)setUpAddSubviews{
    UILabel *navLabel = [[UILabel alloc] init];
    navLabel.frame = CGRectMake(0, 0, 100, 30);
    [navLabel setTextColor:[UIColor whiteColor]];
    navLabel.text = @"指缘忘记密码";
    navLabel.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = navLabel;
    
    
    _completeBtn.layer.cornerRadius = 10.0;
    
    [self clickTableViewHideKyeboard];
    UIButton *leftBtn = [self setUpBtnTitle:@""];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];

    leftBtn.width = 40;
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];

}
- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
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


//添加提示框
- (void)setAlertView:(NSString *)str{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}

-(void)hideKeboard{
    [self.userID resignFirstResponder];
    [self.password resignFirstResponder];
    [self.confirmPassword resignFirstResponder];
    [self.persenCode resignFirstResponder];
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
