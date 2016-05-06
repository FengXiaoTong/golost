//
//  ZPFfillInformationController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/28.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ZPFfillInformationController.h"
#import "Common.h"


@interface ZPFfillInformationController () {

    UITextField *_tf;
    
}

@end

@implementation ZPFfillInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(220, 220, 220);
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    [rightItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self createTextFiled];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)rightItemAction:(UIBarButtonItem *)item {

    if (![_tf.text isEqualToString:@""]) {
        MYLog(@"保存了----%@",_tf.text);

    }

}



- (void)createTextFiled {

    
    _tf = [[UITextField alloc] init];
    _tf.backgroundColor = [UIColor whiteColor];
    _tf.borderStyle = UITextBorderStyleNone;
//    if ([_text isEqualToString:@""]) {
//        MYLog(@"%@---",_text);
        _tf.placeholder = _placeholder;

//    }else {
//        MYLog(@"%@---",_text);
//
        _tf.text = _text;

//    }
    _tf.font = [UIFont systemFontOfSize:20];
    _tf.adjustsFontSizeToFitWidth = YES;
    _tf.minimumFontSize = 13;
    _tf.textAlignment = NSTextAlignmentCenter;
    if ([_text isEqualToString:@""]) {
        _tf.clearsOnBeginEditing = YES;
    }
    _tf.clearButtonMode = UITextFieldViewModeAlways;

    _tf.frame = CGRectMake(0, 10, screenW, 40);
    [self.view addSubview:_tf];

    
    
}




- (void)baseAttributes
{
 
    
  
    
    //设置占位信息(多用于提示)，默认文本设置后无效
    
    //设置默认文本
    //    tf.text = @"小明";
    
    //设置字体
    //自动适应字体
    //设置最小字体
    //字体颜色
//    tf.textColor = [UIColor blueColor];
    
    //水平对齐方式
    //垂直对齐方式
//    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    //开始编辑时清除原有内容
    /*清除按钮显示模式
     UITextFieldViewModeNever           从来不显示
     UITextFieldViewModeWhileEditing    编辑时显示
     UITextFieldViewModeUnlessEditing   非编辑显示
     UITextFieldViewModeAlways          一直都显示
     */
    /*键盘显示背景
     UIKeyboardAppearanceDark   深灰
     UIKeyboardAppearanceLight  浅灰
     */
//    tf.keyboardAppearance = UIKeyboardAppearanceLight;
//    //键盘风格
//    tf.keyboardType = UIKeyboardTypeASCIICapable;
//    //键盘return键的风格
//    //tf.returnKeyType = UIReturnKeySearch;
//    //自动校正(提示/联想)
//    tf.autocorrectionType = UITextAutocorrectionTypeYes;
    
    //设置代理
    
//    [self.view addSubview:tf];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    //放弃第一响应者的身份
    [_tf resignFirstResponder];

}


@end
