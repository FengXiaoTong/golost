//
//  HrViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/6.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "HrViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "ZPFHrLetterModel.h"
#import "HrTableViewCell.h"
#import "Account.h"
#import "Common.h"
#import "zyzpHttpTool.h"




#import "QuestionViewController.h"



#define URLSTRING @"selectLetters.htm"
#define DELETE_LETTER @"deleteLetters.htm"

@interface HrViewController()/*<UITableViewDataSource, UITableViewDelegate>*/ {

    NSMutableArray *_dataArray;
    
    
}

////@property (nonatomic, strong) UITableView *tableView;
//
//@property (nonatomic, strong) NSMutableDictionary *requestParams;
//
//

@end

@implementation HrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.rowHeight = 100;
    self.navigationItem.titleView = [self setUpButton];
    
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    [self refreshData];
}


- (void)refreshData {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    self.tableView.mj_header = header;
    /*
        MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
            [self loadDataFromNet:YES];
        }];
        self.tableView.mj_footer = footer;
     */
    [self.tableView.mj_header beginRefreshing];
    
}



- (void)loadDataFromNet:(BOOL)isMore {
    
    
    NSString *URLString = [baseUrl stringByAppendingString:URLSTRING];
    
    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
   
    
    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        
        if (!isMore) {
            [_dataArray removeAllObjects];
        }
        NSArray *array = [NSArray arrayWithArray:responseObject];
        for (NSDictionary *dic in array) {
            ZPFHrLetterModel *model = [[ZPFHrLetterModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@",model);
            [_dataArray addObject:model];
        }
        
        MYLog(@"%@",_dataArray);
        
        
        [self.tableView reloadData];
        
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        MYLog(@"%@",[error description]);
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    }];
    
    
}





//标签页名称
- (UIButton *)setUpButton {
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"人事来信" forState:UIControlStateNormal];
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, -15);
    titleBtn.frame = CGRectMake(0, 0, 80, 40);
    return titleBtn;
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"identifier";
    
    HrTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HrTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.model = _dataArray[indexPath.row];
    
    return cell;
}





- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
       
        
        [_dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
        NSString *URLString = [baseUrl stringByAppendingString:DELETE_LETTER];
        
        NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
        ZPFHrLetterModel *model = _dataArray[indexPath.row];
        
        [requestParams setValue:model.lettersId forKey:@"lettersId"];
        
        [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
            
        } success:^(id responseObject) {
            
        
            MYLog(@"删  %@",responseObject);

            
        } failure:^(NSError *error) {
            MYLog(@"没删----%@",[error description]);
        }];
        
    }];
    
    
    ZPFHrLetterModel *model = _dataArray[indexPath.row];
    UITableViewRowAction *replyRowAction;
    
    if ([model.replyState isEqualToString:@"01"]) {
        replyRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"查看" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            
            MYLog(@"查看");
            
            
        }];
    } else if ([model.replyState isEqualToString:@"02"]){
        replyRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"回复" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            
            MYLog(@"回复");
            
        }];

    }
    

    deleteRowAction.backgroundColor = [UIColor blueColor];

    if (replyRowAction) {
        
        replyRowAction.backgroundColor = [UIColor cyanColor];
        return @[deleteRowAction,replyRowAction];
    
    }
    return @[deleteRowAction];
}



/*
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
    if ([tableView isEqual:tableView]) {
        result = UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
    }
    return result;
}


-(void)setEditing:(BOOL)editing animated:(BOOL)animated{//设置是否显示一个可编辑视图的视图控制器。
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];//切换接收者的进入和退出编辑模式。
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        if (indexPath.row<[self.arryOfRows count]) {
            [self.arryOfRows removeObjectAtIndex:indexPath.row];//移除数据源的数据
 
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
       // }
    }
}*/

//创建下级界面

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuestionViewController *ComVC = [[QuestionViewController alloc] init];
    
    
}

@end
