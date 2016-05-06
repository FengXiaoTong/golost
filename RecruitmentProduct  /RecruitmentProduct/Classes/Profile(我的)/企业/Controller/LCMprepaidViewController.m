//
//  LCMprepaidViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/30.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMprepaidViewController.h"
#import <UIImageView+WebCache.h>
#import "AlipaySDK/AlipaySDK.h"
#import "Order.h"
#import "DataSigner.h"
#import "LCMpayViewHeader.h"
#import "Common.h"
@interface LCMprepaidViewController () {

    UITextField *_textField;
}

@end

@implementation LCMprepaidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"指慧豆充值";
    self.view.backgroundColor = [UIColor whiteColor];
    [self interfaceLayout];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

-(void)viewTapped:(UITapGestureRecognizer*)tap
{
    
    [self.view endEditing:YES];
    
}

- (void)interfaceLayout {

    /**
     *  企业logo
     */
    CGFloat iconView_top = 25;
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(screenW/3, iconView_top, screenW/3, screenW/3)];
    iconView.layer.cornerRadius = screenW/6;
    iconView.clipsToBounds = YES;
    [iconView sd_setImageWithURL:[NSURL URLWithString:_iconImageURL] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    [self.view addSubview:iconView];
    
    /**
         企业名称
     */
    UILabel *companyName = [[UILabel alloc] init];
    companyName.frame = CGRectMake(0, CGRectGetMaxY(iconView.frame) + 10, screenW, 30);
    companyName.textAlignment = NSTextAlignmentCenter;
    companyName.text = _companyName;
    [self.view addSubview:companyName];
    
    /**
     *  金额文本输入框
     */
    CGFloat textField_left = 23.0;
    CGFloat name_text_gap = 15.0;
    CGFloat textField_width = 300.0;
    CGFloat textField_height = 40.0;
    _textField = [[UITextField alloc] init];
    _textField.frame = CGRectMake(textField_left, CGRectGetMaxY(companyName.frame) + name_text_gap, textField_width, textField_height);
    _textField.placeholder = @" 请输入金额";
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview: _textField];
    
    
    /**
     *  提示文字
     */
    CGFloat prompt_left = 35.0;
    CGFloat text_gap = 10.0;
    CGFloat prompt_height = 15;
    UILabel *promptText = [[UILabel alloc] init];
    promptText.frame = CGRectMake(prompt_left, CGRectGetMaxY(_textField.frame) + text_gap, screenW - prompt_left, prompt_height);
    promptText.text = @"提示:1指慧豆=1元人民币";
    promptText.textColor = Color(100, 100, 100);
    promptText.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:promptText];
    
    
    /**
     *  充值按钮
     */
    CGFloat button_left = 22.0;
    CGFloat button_right = 22.0;
    CGFloat button_gap = 18.0;
    CGFloat button_height = 40;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(button_left, CGRectGetMaxY(promptText.frame) + button_gap, screenW - button_left - button_right, button_height);
    button.layer.cornerRadius = 10.0;
    [button setTitle:@"充值" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    
    
    /**
     *  提示文字
     */
    CGFloat sweet_gap = 18.0;
    CGFloat sweet_height = 15.0;
    UILabel *sweetText = [[UILabel alloc] init];
    sweetText.frame = CGRectMake(0, CGRectGetMaxY(button.frame) + sweet_gap, screenW, sweet_height);
    sweetText.font = [UIFont systemFontOfSize:13];
    sweetText.textAlignment = NSTextAlignmentCenter;
    sweetText.text = @"充值10个指慧豆，节省审核时间";
    sweetText.textColor = Color(100, 100, 100);

    [self.view addSubview:sweetText];
    

}

- (NSString *)generateTradeNO {
    
    NSString *soureString = @"0123456789ABCDEFGHIGKLMNOPQRSTUVWXYZ";
    NSMutableString *result = [[NSMutableString alloc]init];
    for (NSInteger i = 0; i < 15; i++) {
        NSInteger index = arc4random()%(soureString.length);
        NSString *charactor = [soureString substringWithRange:NSMakeRange(index, 1)];
        [result appendString:charactor];
    }
    return result;
}

- (void)buttonAction {
    
    if ([_textField.text intValue] < 2) {
       
        [self promptBox];
        return;
    }else {
        Order *order = [[Order alloc] init];
        order.partner = PartnerID;
        order.seller = SellerID;
        order.tradeNO = [self generateTradeNO];
        order.productName = @"11612";
        order.productDescription = @"33366333";
        order.amount = _textField.text;
        order.notifyURL = @"wan090630@126.com";
        order.service = @"mobile.securitypay.pay";
        order.paymentType = @"1";
        order.inputCharset = @"utf-8";
        order.itBPay = @"30m";
        order.showUrl = @"m.alipay.com";
        
        NSString *schme = @"wan090630@126.com";
        NSString *orderSpec = [order description];
        //NSLog(@"fuck");
        
        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
        id <DataSigner> singer = CreateRSADataSigner(PartnerPrivKay);
        NSString *singerString = [singer signString:orderSpec];
        
        NSString *orderString = nil;
        if (singerString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, singerString, @"RSA"];
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:schme callback:^(NSDictionary *resultDic) {
                NSLog(@"支付结果 %@",resultDic);
            }];
            
        }
    
    }
    
}

- (void)promptBox{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲爱的用户，您好！" message:@"充值金额不得低于2元！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
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
