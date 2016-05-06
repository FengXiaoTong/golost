//
//  NextStepViewController.m
//  RecruitmentProduct
//
//  Created by zy on 16/4/16.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "NextStepViewController.h"

#import "Common.h"
#import "Account.h"
#import "zyzpHttpTool.h"
#import "UIView+ZYFrame.h"

@interface NextStepViewController ()
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *companyArea;
@property (weak, nonatomic) IBOutlet UITextField *linkman;
@property (weak, nonatomic) IBOutlet UIButton *man;
@property (weak, nonatomic) IBOutlet UIButton *wuman;
@property (weak, nonatomic) IBOutlet UIButton *RegisterBtn;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSDictionary *info;

@end

@implementation NextStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self clickTableViewHideKyeboard];
    [self setUpAddSubviews];
    
}

- (IBAction)sexClick:(UIButton *)sender {
    if (sender.tag == 1) {
        _man.alpha = 0.5;
        _wuman.alpha = 1;
        _sex = @"01";
    }else{
        _man.alpha = 1;
        _wuman.alpha = 0.5;
        _sex = @"02";
    }
}

- (IBAction)registerClick:(id)sender {
    if ([self.companyName.text isEqualToString:@""]) {
        [self setAlertView:@"公司名不能为空"];
    }else if ([self.companyArea.text isEqualToString:@""]){
        [self setAlertView:@"公司地址不能为空"];
    }else if ([self.linkman.text isEqualToString:@""]){
        [self setAlertView:@"联系人不能为空"];
    }else if (self.sex == nil){
        [self setAlertView:@"请选择性别"];
    }else{
        NSString *urlString = [baseUrl stringByAppendingString:@"/companyPhoneRegister.htm"];
        NSDictionary *dict = @{@"email":self.model.enterpriseMail,@"passWord":self.model.enterprisePassword,@"userName":self.model.enterpriseName,@"inviterId":self.model.enterpriseInvitationCode,@"phone":self.model.enterprisePhone,@"companyName":self.companyName.text,@"companyArea":self.companyArea.text,@"linkman":self.linkman.text,@"manOrWoman":self.sex};
        [zyzpHttpTool GET:urlString parameters:dict progress:^{
            
        } success:^(id responseObject) {
            NSString *statusInt = responseObject[@"status"];
            int status = statusInt.intValue;
            
            NSLog(@"%d",status);
            if (status == 0) {
                self.info = [NSMutableDictionary dictionaryWithDictionary:@{KHouseholdMark:kEnterprise,kCompanyId:responseObject[kCompanyId]}];
                [[Account currentAccount] saveLogin:self.info];

                //跳转修改公司信息页面


//                [self.navigationController pushViewController:[PersonalViewController new] animated:YES];
            }
            [self setAlertView:responseObject[@"message"]];
        } failure:^(NSError *error) {
            
        }];
    }
}
//阅读条款
- (IBAction)readingClauseClick:(id)sender {
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
    
    
    self.RegisterBtn.layer.cornerRadius = 10.0;
    
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

//返回
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

-(void)hideKeboard{
    [self.companyArea resignFirstResponder];
    [self.companyName resignFirstResponder];
    [self.linkman resignFirstResponder];
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
