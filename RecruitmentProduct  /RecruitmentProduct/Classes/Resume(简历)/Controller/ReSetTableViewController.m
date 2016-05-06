//
//  ReSetTableViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/18.
//  Copyright © 2016年 RunShengInformation. All rights reserved.

//  简历设置界面

//



#import "ReSetTableViewController.h"
#import "Common.h"
#import "CompanyNameViewController.h"
#import "MHActionSheet.h"

@interface ReSetTableViewController ()<UITableViewDelegate, UITableViewDataSource,PassingValueDelegate>

@property(nonatomic, strong)NSMutableArray *datas;  //数据组
@property(nonatomic, strong)NSMutableArray *data1;  //第一组的数据
@property(nonatomic, strong)NSMutableArray *data2;    //第二组的数据
@property(nonatomic, strong)UISwitch * sdefault;    //默认简历开关
@property(nonatomic, copy) NSString * NameString; //添加屏蔽公司名字
@property(nonatomic, strong)NSMutableArray *selectSource;

@end

@implementation ReSetTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
//    self.tableView.allowsSelection = YES;
//    self.tableView.scrollEnabled = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
     self.data1 = [[NSMutableArray alloc] initWithObjects:@"公开设置",@"默认简历",@"删除简历",nil];
    self.data2 = [[NSMutableArray alloc] initWithObjects:@"不希望以下公司搜到我",nil];
    self.datas = [[NSMutableArray alloc]initWithObjects:_data1,_data2, nil];
    CGRect tframe = CGRectMake(0, 0, 0, CGFLOAT_MIN);
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:tframe];
    self.navigationItem.title = @"简历设置";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    _selectSource = [NSMutableArray new];
    [_selectSource addObject:@""];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
          return [[_datas objectAtIndex:section] count];
    }
    return [[_datas objectAtIndex:section] count];
}


#pragma mark -- tableView 数据代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        switch (indexPath.section) {
            case 0:
                if (indexPath.row == 0) {
                    cell.textLabel.text = [[_datas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    cell.detailTextLabel.text = _selectSource[indexPath.row];
                    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(screenW-30, 14, 9, 15)];
                    icon.image =  [UIImage imageNamed:@"login_to"];
                    [cell.contentView addSubview:icon];
                }else if (indexPath.row == 1){
                    cell.textLabel.text = [[_datas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    _sdefault = [[UISwitch alloc]initWithFrame:CGRectMake(screenW - 60, 10, 0, 0)];
                    _sdefault.on = NO;
                    [cell.contentView addSubview:_sdefault];
                }else if (indexPath.row == 2){
                     cell.textLabel.text = [[_datas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                }
                break;
                case 1:
                if (indexPath.row == 0) {
                     cell.textLabel.text = [[_datas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                }else {
                    UIButton *deleButton = [[UIButton alloc]initWithFrame:CGRectMake(screenW-45, 14, 15, 16)];
                    [deleButton setImage: [UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
                    [deleButton addTarget:self action:@selector(clickDele:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:deleButton];
             }
                
        }

  }
                 cell.textLabel.text = [[_datas objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                 cell.tag = [indexPath row];
                 NSArray *subviews = [cell.contentView subviews];
                 for(id view in subviews){
                  if([view isKindOfClass:[UIButton class]]){
                  [view setTag:[indexPath row]];
                  [cell.contentView bringSubviewToFront:view];
        }
    }
    return cell;
}


#pragma mark -- 点击删除
-(void)clickDele:(UIButton *)button
{
    NSArray *visiblecells = [self.tableView visibleCells];
    for(UITableViewCell *cell in visiblecells)
    {
        if(cell.tag == button.tag)
        {
            [_data2 removeObjectAtIndex:[cell tag]];
            [self.tableView reloadData];
            break;
        }
    }
}
    

#pragma mark -- 点击添加
-(void)clickAdd
{
    CompanyNameViewController * ComVC = [[CompanyNameViewController alloc]init];
    ComVC.delegate = self;
    [self.navigationController pushViewController:ComVC animated:YES];
}


#pragma mark -- 代理传值方法
-(void)viewController:(CompanyNameViewController *)viewController didPassingValueWithInfo:(id)info
{
    self.NameString = info;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.NameString) {
         [_data2 addObject:[NSString stringWithFormat:@"%@",self.NameString]];
         [self.tableView reloadData];
    }
    return;
}



#pragma mark -- 点击保存
-(void)clickKeep
{
    [self.navigationController popViewControllerAnimated:YES];
}

//第一个组头距离导航栏的高度
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.1;
//}

#pragma mark -- 把加号和保存放在组尾上
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == 1) {
        //尾视图中有加号和保存两个按钮
        UIView *addKeep = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 150)];
        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, screenW, 45)];
        [addButton addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
        [addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [addButton setTitle:@"  添加更多公司" forState:UIControlStateNormal];

        [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addKeep addSubview:addButton];
        
        //保存按钮
        UIButton *keepButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 100, screenW-60, 30)];
        [keepButton setTitle:@"保存" forState:UIControlStateNormal ];
        [keepButton.layer setCornerRadius:10];
        keepButton.tintColor = [UIColor whiteColor];
        keepButton.backgroundColor = [UIColor blueColor];
        [keepButton addTarget:self action:@selector(clickKeep) forControlEvents:UIControlEventTouchUpInside];
        [addKeep addSubview:keepButton];
        return addKeep;
    }
        return nil;
}


#pragma mark -- 组尾高度设置
//设置组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 150;
    }
        return 0;
}

#pragma mark -- cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ( indexPath.section == 1 ) {
        return;
    }
         else if ( indexPath.section == 0 ) {
             switch ( indexPath.row ) {
                 case 0:{
                MHActionSheet *actionSheet = [[MHActionSheet alloc]initSheetWithTitle:nil style:MHSheetStyleDefault itemTitles:@[@"对企业公开",@"全部公开",@"保密"]];
                __weak typeof(self) weakSelf = self;
                [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
                    NSString *text = [NSString stringWithFormat:@"%@", title];
                    [weakSelf.selectSource replaceObjectAtIndex:indexPath.row withObject:text];
                    [weakSelf.tableView reloadData];
                }];
            }
                break;
                 case 2:{
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确认删除当前简历" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:@"确认",nil];
                     [alert show];
                     
                 }
                     break;
             }
        }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
