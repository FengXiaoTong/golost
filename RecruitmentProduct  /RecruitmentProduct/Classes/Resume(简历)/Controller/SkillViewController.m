//
//  SkillViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/7.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//   专业技能界面

#import "SkillViewController.h"
#import "Common.h"

@interface SkillViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSArray * datas;

@end

@implementation SkillViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self  addSTableView];
}


#pragma mark -- 添加专业技能tableView页面
-(void)addSTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}


#pragma mark -- 懒加载数据
-(NSArray *)datas
{
    if (_datas == nil) {
        _datas = @[@"技能名称",@"使用时间",@"掌握程度"];
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
        }
    }
}


#pragma mark -- cell高度设置
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
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
