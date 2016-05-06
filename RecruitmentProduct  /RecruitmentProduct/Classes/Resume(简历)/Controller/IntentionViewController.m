//
//  IntentionViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/5.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  求职意向界面

#import "IntentionViewController.h"
#import "Common.h"
#import "UIView+ZYFrame.h"
#import "Account.h"
#import "EducationViewController.h"

@interface IntentionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSArray * datas;

@end

@implementation IntentionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRightItem];
    [self addCTableView];
}

#pragma mark -- 添加求职意向tableView页面
-(void)addCTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH) style:UITableViewStyleGrouped];//
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}





#pragma mark -- 添加导航栏rightItem
-(void)addRightItem
{
    self.navigationItem.title = @"求职意向";
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
    [self.navigationController pushViewController:[EducationViewController new] animated:YES];
}
//注册尾的高
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}


-(void)clickNext
{
    UIViewController *xia = [[UIViewController alloc]init];
    [self.navigationController pushViewController:xia animated:YES];
}

#pragma mark -- 懒加载数据
-(NSArray *)datas
{
    if (_datas == nil) {
        _datas = @[@"求职状态",@"工作性质",@"期望职位",@"期望行业",@"期望地点",@"期望月薪"];
    }
    return _datas;
}

#pragma mark -- tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.datas.count;
}

#pragma mark -- tableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        } case 1:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        } case 2:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        } case 3:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        }case 4:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        }case 5:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        }
            
    }
}


#pragma mark -- cell高度设置
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
