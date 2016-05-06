//
//  WorkExperienceViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/5.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  工作经验界面

#import "WorkExperienceViewController.h"
#import "Common.h"
#import "Account.h"
#import "UIView+ZYFrame.h"
#import "ProjectViewController.h"


@interface WorkExperienceViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSArray * datas;

@end

@implementation WorkExperienceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRightItem];
    [self  addWTableView];
}

#pragma mark -- 添加工作经历tableView页面
-(void)addWTableView
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
    self.navigationItem.title = @"工作经历";
    UIBarButtonItem * next = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickNext)];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName]= [UIColor whiteColor];
    [next setTitleTextAttributes:att forState:UIControlStateNormal];
    //注册
    if ([Account currentAccount].isComplete) {
        UIBarButtonItem * nilBtn = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.leftBarButtonItem = nilBtn;
        UIBarButtonItem * skip = [[UIBarButtonItem alloc]initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(skipClick)];
        NSMutableDictionary *att = [NSMutableDictionary dictionary];
        att[NSForegroundColorAttributeName]= [UIColor whiteColor];
        [skip setTitleTextAttributes:att forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = skip;
        
        
    }else{
        self.navigationItem.rightBarButtonItem = next;
    }
}

-(void)clickNext
{
    [self.navigationController popViewControllerAnimated:YES];
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
    [self.navigationController pushViewController:[ProjectViewController new] animated:YES];
}
//注册尾的高
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
//注册跳过
- (void)skipClick{
    [self.navigationController pushViewController:[ProjectViewController new] animated:YES];
}

#pragma mark -- 懒加载数据
-(NSArray *)datas
{
    if (_datas == nil) {
        _datas = @[@"工作经历",@"公司名称",@"行业类别",@"职位类别",@"职位名称",@"时间段",@"职位月薪",@"工作描述",@"企业性质",@"企业规模"];
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
        }case 6:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        }case 7:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        }case 8:{
            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
            
            break;
        }case 9:{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
