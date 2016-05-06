//
//  SetViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/5.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  简历设置界面

#import "SetViewController.h"
#import "Common.h"
#import "DataItem.h"
#import "NotItem.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray * datas;//设置项的数据
@property(nonatomic, strong)UITableView * newtableView;//往tableView上添加的tableView
@property(nonatomic, strong)UISwitch * tdefault;

@end

@implementation SetViewController

//或者这样直接初始化tableView的分组样式为组，不过得使用alloc init......
//重写init方法
//- (instancetype)init
//{
//    
//    return [self initWithStyle:UITableViewStyleGrouped];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSetTableView];
    [self setData1];
    [self setData2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)setData1
{
    DataItem *data = [[DataItem alloc]init];
    NotItem *item = [NotItem itemWithtitle:@"公开设置"];
    NotItem *item1 = [NotItem itemWithtitle:@"默认简历"];
    NotItem *item2 = [NotItem itemWithtitle:@"删除简历"];
    data.items = @[item,item1,item2];
    [self.datas addObject:data];
}

-(void)setData2
{
    DataItem *data = [[DataItem alloc]init];
    NotItem *item = [NotItem itemWithtitle:@"不希望以下公司搜到我"];
    NotItem *item1 = [NotItem itemWithtitle:@"河南XXXXXX公司"];
    data.items = @[item,item1];
    [self.datas addObject:data];
}


#pragma mark -- 添加设置TableView
-(void)addSetTableView
{
    _newtableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _newtableView.delegate = self;
    _newtableView.dataSource = self;
    _newtableView.bounces = NO;
    _newtableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview: _newtableView];
}


#pragma mark -- 懒加载数据
-(NSMutableArray *)datas
{
    if (!_datas) {
//        _datas = @[@"公开设置",@"默认简历",@"删除简历",@"不希望以下公司搜到我"];
        _datas = [NSMutableArray array];
    }
    return _datas;
}

#pragma mark -- tableView delegate
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DataItem *data = self.datas[section];
    return data.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier  = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            switch ([indexPath indexAtPosition:0]) {
                case 0:
                    switch ([indexPath indexAtPosition:1]) {
                        case 0:
                            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                            break;
                            case 1:
                            _tdefault = [[UISwitch alloc]initWithFrame:CGRectMake(280, 10, 0, 0)];
                            _tdefault.on = YES;
                            [cell addSubview:_tdefault];
                            
                            break;
                    }
                    break;

            }
            
        }
//           cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //不能统一设置带箭头
    DataItem * data = self.datas[indexPath.section];
    NotItem * item = data.items[indexPath.row];
    cell.textLabel.text = item.title;
          return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}


#pragma mark -- 点击cell
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath: indexPath animated:YES];   //点击效果动画消失
//    switch (indexPath.row) {
//        case 0:{
//            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
//            
//            break;
////        } //case 1:{
////            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
////            
////            break;
//        } case 2:{
//            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
//            
//            break;
//        }//case 3:{
////            [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
////            
////            break;
////        }
//            
//    }
//}

//分section配置不同的点击cell响应事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath indexAtPosition:0]) {
        case 0:
            switch ([indexPath indexAtPosition:1]) {
                case 0:
                           [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
                    break;
                case 2:
                           [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
                    break;
            }
            break;
        case 1:
            switch ([indexPath indexAtPosition:1])
        {
                case 0:
                    
                    break;
                    
                case 1:
             
                    break;
            
        }
            break;
            
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
