//
//  ZPFsingleChatViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/3.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ZPFsingleChatViewController.h"
#import <Masonry.h>
#import "Common.h"


#define URL @"http://192.168.100.20:8081/zyjyPhone/"

#define PRIVATE_MESSAGE @"selectPhonePrivateletterdailogueByDialogueId.htm"

#define TOOLBAR_HEIGHT 49

@interface ZPFsingleChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {

    UITableView *_tableView;
    UITextField *_tf;
    UIToolbar *_toolBar;
}



@end

@implementation ZPFsingleChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"私信";
    
    
    
    [self setNavigationItem];
    //创建toolBar
    [self createToolBar];
    //注册通知监听键盘
    [self registration];
    
    
    
    
}

//对导航条和tabbar对布局影响进行处理
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_image"] forBarMetrics:UIBarMetricsDefault];
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.translucent = YES;
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.translucent = NO;
}
//创建tableview
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH - TOOLBAR_HEIGHT - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

//创建toolBar
- (void)createToolBar {
    WS(weakSelf);
    
    
    _toolBar = [[UIToolbar alloc] init];
    [self.view addSubview:_toolBar];
    _toolBar.backgroundColor = UIColorFromRGB(0x999999, 0.65);
    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.right.mas_equalTo(weakSelf.view.mas_right);
        make.height.mas_equalTo(TOOLBAR_HEIGHT);
    }];
    
    
    _tf = [[UITextField alloc] init];
    _tf.backgroundColor = [UIColor whiteColor];
    _tf.delegate = self;
    _tf.layer.cornerRadius = 5;
    [_toolBar addSubview:_tf];
    
    
    [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_toolBar.mas_centerY);
        make.left.mas_equalTo(@10);
        make.right.mas_equalTo(weakSelf.view).with.offset(-54.5);
        make.height.mas_equalTo(@32.5);
    }];
    
}

//注册通知
- (void)registration {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

//添加返回按钮
- (void)setNavigationItem {

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonItemActin:)];
    self.navigationItem.leftBarButtonItem = leftItem;

}
-(void)leftButtonItemActin:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

//键盘显示时调用
- (void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
  
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    WS(weakSelf);
    [UIView animateWithDuration:0.6 animations:^{
        [_toolBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-height);
        }];
        [_toolBar.superview layoutIfNeeded];
    }];
}

//键盘退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
          WS(weakSelf);
    [UIView animateWithDuration:0.6 animations:^{
        [_toolBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
        }];
        [_toolBar.superview layoutIfNeeded];
    }];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [_tf resignFirstResponder];
}


#pragma make -- textFiled  代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    MYLog(@"发送--%@",_tf.text);

    return YES;
}



#pragma make -- tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}




- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    MYLog(@"内存警告%s",__func__);
}

@end
