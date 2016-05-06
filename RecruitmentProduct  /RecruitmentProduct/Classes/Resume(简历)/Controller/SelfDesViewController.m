//
//  SelfDesViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/5.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  自我描述界面

#import "SelfDesViewController.h"
#import "Common.h"

@interface SelfDesViewController ()<UITextViewDelegate,UIAlertViewDelegate>

@property(nonatomic, strong)UITextView * textView;//文本
@property(nonatomic, strong)UILabel *placeHolder;//提示信息
@property(nonatomic, strong)UIButton *sendButton;//保存

@end

@implementation SelfDesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"自我描述";
//    [self addRightItem];
    self.automaticallyAdjustsScrollViewInsets = NO;//取消导航栏和状态栏的边缘延伸效果，等价于
//    self.modalPresentationCapturesStatusBarAppearance = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
    
    [self addTextView];
    _placeHolder = [[UILabel alloc]initWithFrame:CGRectMake(4, 6, screenW, 20)];
    _placeHolder.enabled = NO;
    _placeHolder.text = @"请输入自我描述";
    _placeHolder.font = [UIFont systemFontOfSize:15];
    _placeHolder.textColor = [UIColor lightGrayColor];
    [_textView addSubview:_placeHolder];
    [self addSendButton];
}


//-(void)addRightItem
//{
//    self.navigationItem.title = @"自我描述";
//    UIBarButtonItem * next = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(clickNext)];
//    NSMutableDictionary *att = [NSMutableDictionary dictionary];
//    att[NSForegroundColorAttributeName]= [UIColor blackColor];
//    [next setTitleTextAttributes:att forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = next;
//}


//-(void)clickNext
//{
//    UIViewController *xia = [[UIViewController alloc]init];
//    [self.navigationController pushViewController:xia animated:YES];
//}

//添加自我描述文本框
//-(void)addSTextField
//{
//    UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH/2)];
//    text.borderStyle = UITextBorderStyleLine;
//    text.backgroundColor = [UIColor whiteColor];
//    text.textColor = [UIColor blackColor];
//    text.keyboardType = UIKeyboardTypeDefault;
//    text.text = @"请输入自己的亮点，可增加面试几率";
//    text.placeholder  =@"请输入自己的亮点，可增加面试几率";
//
//    text.clearsOnBeginEditing = YES;
//    text.returnKeyType = UIReturnKeyDone;
//    [self.view addSubview:text];
//}



//添加自我描述文本框
-(void)addTextView
{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, screenW, screenH/3)];
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor whiteColor];
//    _textView.text =@"ancdefghijklmnopqrstuvwxyz";
    _textView.textColor = [UIColor blackColor];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.keyboardType = UIKeyboardTypeDefault;
    _textView.returnKeyType = UIReturnKeyDefault;
    _textView.scrollEnabled = NO;
//    _textView.layer.masksToBounds = YES;
    _textView.layer.borderColor = UIColor.blackColor.CGColor;
    _textView.layer.borderWidth = 1.0f;
//    _textView.layer.cornerRadius = 5.0f;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_textView becomeFirstResponder];
    
//    NSString *desc = @"Description it is  a test font, and don't become angry for which i use to do here.Now here is a very nice party from american or not!";
//    CGSize size = [desc  sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(screenW, screenH/2) lineBreakMode:UILineBreakModeWordWrap];

    [self.view addSubview:_textView];
}


#pragma mark -- 点击UITextView 输入文字，光标都从最初点开始
-(void)textViewDidChangeSelection:(UITextView *)textView
{
    NSRange range;
    range.location = 0;
    range.length = 0;
    textView.selectedRange = range;
}

#pragma mark -- 弹出键盘消失
//键盘消失 （取消第一响应）
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
}


#pragma mark -- 代理方法
//这两个代理方法会使placeholder 删除不干净
//-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    if (textView.tag == 0) {
//        textView.text = @"";
//        textView.textColor = [UIColor blackColor];
//        textView.tag = 1;
//    }
//    return YES;
//}
//
//-(void)textViewDidChange:(UITextView *)textView
//{
//    if ([textView.text length] == 0 && textView.tag == 1) {
//        textView.text = @"请输入自我介绍";
//        textView.textColor = [UIColor lightGrayColor];
//        textView.tag = 0;
//    }
//}

-(void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length]== 0) {
        [_placeHolder setHidden:NO];
    }else {
        [_placeHolder setHidden: YES];
    }
}

//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doit)];
//    self.navigationItem.rightBarButtonItem = done;
//}
//
//-(void)textViewDidEndEditing:(UITextView *)textView
//{
//    self.navigationItem.rightBarButtonItem =nil;
//}
//
//
//-(void)doit
//{
//    [_textView resignFirstResponder];
//}

//添加一个灰色且不可编辑的TextView，像蒙板一样盖住， 实现placeholder的效果
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    UITextView * placeholder = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH/2)];
//    [placeholder setEditable:NO];
//    placeholder.textColor = [UIColor grayColor];
//    placeholder.text =@"请输入自己的亮点，可增加面试几率哦";
//    if (![text isEqualToString:@""]) {
//        placeholder.hidden = YES;
//    }
//    if ([text isEqualToString:@""]&&range.location == 0 && range.length ==1) {
//        placeholder.hidden = NO;
//    }
//    return YES;
//}


- (void)addSendButton{

        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.layer.cornerRadius = 2.0f;
        _sendButton.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame)+60, screenW, 60);
        _sendButton.backgroundColor = [self colorWithRGBHex:0x60cdf8];
        [_sendButton setTitle:@"保存" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendFeedBack) forControlEvents:UIControlEventTouchUpInside];
        [self.view  addSubview:_sendButton];
}
- (void)sendFeedBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

//颜色设置
- (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
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
