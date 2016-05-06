//
//  PersinalViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/8.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//   个人信息页面


#import "PersonalViewController.h"
#import "Common.h"
#import "NewTableViewCell.h"
#import "MHDatePicker.h"
#import "MHActionSheet.h"
#import "STPickerArea.h"
#import "STPickerHomeArea.h"
#import "Account.h"
#import "UIView+ZYFrame.h"
#import "IntentionViewController.h"
#import "zyzpHttpTool.h"
#import "NameViewController.h"


@interface PersonalViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,STPickerAreaDelegate,STPickerHomeAreaDelegate>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)UIView * headView;
@property(nonatomic, strong)MHDatePicker * selectDatePicker;    //出生日期选择器
@property (strong, nonatomic) NSMutableArray * dataSource;
@property (strong, nonatomic) NSMutableArray * selectSource;
@property(nonatomic,strong)UITextField * nameTextField;    //姓名
@property(nonatomic, strong)UITextField * addressTextField;    //户口所在地
@property(nonatomic, strong)UITextField * homeTextField;    //居住地
@property(nonatomic, strong)UITextField * contentField;  // 内容textfield
@property(nonatomic, strong)UILabel *conLabel; //内容label


@end

@implementation PersonalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self registerForKeyboardNotifications];

    [self addRightItem];
    [self addPTableView];
    [self loadDataSource];
    self.navigationController.navigationBar.translucent = NO;
}



//注册键盘通知事件
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}


//键盘即将出现时的响应方法
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 200, 0.0);
   self.tableView.contentInset = contentInsets;
   self.tableView.scrollIndicatorInsets = contentInsets;

    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, _nameTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, 64.0);
        [self.tableView setContentOffset:scrollPoint animated:YES];
    }
}


//键盘即将隐藏时的响应方法
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
   self.tableView.contentInset = contentInsets;
   self.tableView.scrollIndicatorInsets = contentInsets;
    [self.tableView reloadData];
}


-(void)addRightItem
{
    self.navigationItem.title = @"个人信息";

    UIBarButtonItem * next = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickNext)];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName]= [UIColor whiteColor];
    [next setTitleTextAttributes:att forState:UIControlStateNormal];
    //注册
    if ([Account currentAccount].isComplete) {
        UIBarButtonItem * nexthjkl = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = nexthjkl;
        
    }else{
        self.navigationItem.rightBarButtonItem = next;
    }
}


#pragma mark -- 添加section头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    //创建一个headView
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 213)];//导航栏高度44. 状态栏高度20
    _headView.backgroundColor = [UIColor whiteColor] ;
    [tableView addSubview: _headView];

    
    //  2.添加icon（头像）到 topView里
    UIImageView * icon = [[UIImageView alloc]initWithFrame:CGRectMake((screenW-121) / 2, 13,121, 121)];
    icon.image = [UIImage imageNamed:@"details_mr"];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 60;//把图片裁剪成圆形

    [_headView addSubview:icon];

    icon.userInteractionEnabled = YES; // 允许用户交互
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alterHeadPortrait:)];
    [icon  addGestureRecognizer:singleTap];//创建并添加手势：单击
      return _headView;
}

//注册用到的
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([Account currentAccount].isComplete) {
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 50)];
        UIButton *setUPbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [setUPbutton setTitle:@"下一步" forState:UIControlStateNormal ];
        [setUPbutton.layer setCornerRadius:10];
        setUPbutton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        setUPbutton.tintColor = [UIColor whiteColor];
        setUPbutton.backgroundColor = zyMainColor;
        setUPbutton.height = 45;
        setUPbutton.width = screenW - 23 - 23;
        setUPbutton.x = 23;
        setUPbutton.y = (50 - 45) / 2;
        
        [setUPbutton addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:setUPbutton];
        return footerView;
    }
    return nil;
}
//注册下一步
- (void)clickEdit{
    
    //还要做 网络请求呢
    [self.navigationController pushViewController:[IntentionViewController new] animated:YES];
}
//注册尾的高
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

//设置组头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 147;
}

- (void)clickNext{
    
}

#pragma mark -- 添加个人信息tableView
-(void)addPTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,screenW , screenH) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}


#pragma mark -- 懒加载数据
- (void)loadDataSource
{
    _dataSource = [NSMutableArray new];
    [_dataSource addObject:@"姓名"];
    [_dataSource addObject:@"出生日期"];
    [_dataSource addObject:@"性别"];
    [_dataSource addObject:@"婚姻状况"];
    [_dataSource addObject:@"手机号码"];
    [_dataSource addObject:@"电子邮箱"];
    [_dataSource addObject:@"户口所在地"];
    [_dataSource addObject:@"目前所在地"];
    
    _selectSource = [NSMutableArray new];
    [_selectSource addObject:@"请输入姓名"];
    [_selectSource addObject:@"请输入出生日期"];
    [_selectSource addObject:@"请选择性别"];
    [_selectSource addObject:@"请选择婚姻状况"];
    [_selectSource addObject:@"请输入手机号码"];
    [_selectSource addObject:@"请输入电子邮箱"];
    [_selectSource addObject:@"请选择户口所在地"];
    [_selectSource addObject:@"请选择目前所在地"];
}

#pragma mark -- tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

////////////////////
#pragma mark -- tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (indexPath.row == 0 || indexPath.row== 4 || indexPath.row== 5)
    {
        if (cell == nil)
        {
            cell =  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(210, 6, 130, 30)];
            _nameTextField.textColor = [UIColor lightGrayColor];
            _nameTextField.placeholder = _selectSource[indexPath.row];

            _nameTextField.keyboardType = UIKeyboardTypeDefault;
            _nameTextField.returnKeyType = UIReturnKeyDone;
            _nameTextField.delegate = self;
            
            [cell.contentView addSubview:_nameTextField];
            cell.textLabel.text = _dataSource[indexPath.row];
            
            UIView *temView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenW, screenH-320)];
            _nameTextField.inputAccessoryView = temView;
            UITapGestureRecognizer *clickTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(KeyboardMiss)];
            clickTap.cancelsTouchesInView = NO;
            [temView addGestureRecognizer:clickTap];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }if (indexPath.row == 6 )
    {
        if (cell == nil)
        {
            cell =  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            _addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(210, 6, 140, 30)];
            _addressTextField.textColor = [UIColor lightGrayColor];
            _addressTextField.placeholder = _selectSource[indexPath.row];
            //                   _addressTextField.textAlignment = UITextAlignmentCenter;
            _addressTextField.userInteractionEnabled = NO;

            _addressTextField.delegate = self;
            [cell.contentView addSubview:_addressTextField];
            cell.textLabel.text = _dataSource[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    if ( indexPath.row== 7)
    {
        if (cell == nil)
        {
            cell =  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            _homeTextField= [[UITextField alloc]initWithFrame:CGRectMake(210, 6, 140, 30)];
            _homeTextField.textColor = [UIColor lightGrayColor];
            _homeTextField.placeholder = _selectSource[indexPath.row];
            _homeTextField.userInteractionEnabled = NO;

            _homeTextField.delegate = self;
            [cell.contentView addSubview:_homeTextField];
            cell.textLabel.text = _dataSource[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }else{
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        cell.textLabel.text = _dataSource[indexPath.row];
        cell.detailTextLabel.text = _selectSource[indexPath.row];
//        _contentField = [[UITextField alloc]initWithFrame:CGRectMake(210, 6, 140, 30)];
//        _contentField.textColor = [UIColor blackColor];
//        _contentField.placeholder = _selectSource[indexPath.row];
//        _contentField.keyboardType = UIKeyboardTypeDefault;
//        _contentField.returnKeyType = UIReturnKeyDone;
//        _contentField.userInteractionEnabled = NO;
//        _contentField.delegate = self;
//        [cell.contentView addSubview:_contentField];
//        _conLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 6, 140, 30)];
//        _conLabel.textColor = [UIColor lightGrayColor];
//        _conLabel.text = _selectSource[indexPath.row];
//        [cell.contentView addSubview:_conLabel];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}


#pragma mark -- TextFieldDelegate

//1.点击键盘按钮时收起键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//2.键盘消失 （取消第一响应）这个方法没走
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    [self.view resignFirstResponder];
    [_nameTextField resignFirstResponder];
}


//3.结束编辑时，应该收回
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //    [[[UIApplication sharedApplication]keyWindow] endEditing:YES];
    return YES;
}

-(void)KeyboardMiss
{
    [self.view endEditing:YES];
}

#pragma mark -- 点击cell事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//选中后立即取消选中状态
    switch (indexPath.row) {
        case 0:{
            //0.姓名
             [self.nameTextField becomeFirstResponder];
            
            break;
        } case 1:{
            //出生日期
            _selectDatePicker = [[MHDatePicker alloc]init];
            _selectDatePicker.isBeforeTime = YES;
            _selectDatePicker.datePickerMode = UIDatePickerModeDate;
            
            __weak typeof(self) weakSelf = self;
            [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
                
                NSString *birthday = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy年M月dd日"];
                [weakSelf.selectSource replaceObjectAtIndex:indexPath.row withObject:birthday];
                [weakSelf.tableView reloadData];
            }];
            break;
        } case 2:{
            //2.性别
            MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleDefault itemTitles:@[@"男",@"女"]];
            __weak typeof(self) weakSelf = self;
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
                NSString *text = [NSString stringWithFormat:@"%@", title];
                [weakSelf.selectSource replaceObjectAtIndex:indexPath.row withObject:text];
                [weakSelf.tableView reloadData];
            }];
            
            break;
        } case 3:{
            //3.婚姻状况
            MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:nil style:MHSheetStyleDefault itemTitles:@[@"已婚",@"未婚"]];
            __weak typeof(self) weakSelf = self;
            [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
                NSString *text = [NSString stringWithFormat:@"%@", title];
                [weakSelf.selectSource replaceObjectAtIndex:indexPath.row withObject:text];
                [weakSelf.tableView reloadData];
            }];
            
            break;
        }case 4:{
            //4.手机号码
            [self.nameTextField becomeFirstResponder];
            
            break;
        }case 5:{
            //5.电子邮箱
              [self.nameTextField becomeFirstResponder];
            
            break;
        }case 6:{
            //6.户口所在地

             [[[STPickerArea alloc]initWithDelegate:self]show];


            break;
        }case 7:{
            //7.目前所在地
            [[[STPickerHomeArea alloc]initWithDelegate:self]show];


            break;
        }
            
    }
    
}

//时间选择器方法
- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}


#pragma mark -- 修改头像弹出提示框
-(void)alterHeadPortrait:(UITapGestureRecognizer *)gesture
{
    UIAlertController * alert = [ UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
        pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerVC.allowsEditing = YES;
        pickerVC.delegate = self;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
        pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerVC.allowsEditing = YES;
        pickerVC.delegate = self;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark --点击保存,上传数据
-(void)clickPersonalKeep
{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"personName"] = @"贾泽奇";
//    dict[@"birthday"] = @"1223-2e43";
//    NSString *str = [baseUrl stringByAppendingPathComponent:@"updatePhonePerson.htm"];
//    [zyzpHttpTool GET:str parameters:dict progress:^{
//        
//    } success:^(id responseObject) {
//        MYLog(@"%@",responseObject);
//    } failure:^(NSError *error) {
//        MYLog(@"%@",error);
//    }];
    [self.navigationController popViewControllerAnimated:YES];
}


//#pragma mark -- 选择出生日期
//-(void)dateChanged:(id)sender
//{
//    UIDatePicker *control = (UIDatePicker *)sender;
//    NSDate *date = control.date;
//    NSLog(@"%@",date);
//    
//}

#pragma mark ----户口以及住址代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _addressTextField )
    {
        [_addressTextField resignFirstResponder];
        [[[STPickerArea alloc]initWithDelegate:self]show];
    }   if (textField == _homeTextField){
            [_homeTextField resignFirstResponder];
            [[[STPickerHomeArea alloc]initWithDelegate:self]show];
    }

}


- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    _addressTextField.text = address;
}


- (void)pickerHomeArea:(STPickerHomeArea *)pickerHomeArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *string = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    _homeTextField.text = string;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end