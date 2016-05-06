//
//  collectionViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/6.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "collectionViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "collectionTableViewCell.h"
#import "ZPFcollectionModel.h"
#import "Account.h"
#import "zyzpHttpTool.h"
#import "Common.h"
#import "postDetailController.h"



#define URLSTRING @"selectPhoneAllStores.htm"
#define DELETE_POSITION @"deletePhoneStore.htm"

@interface collectionViewController(){

    NSMutableArray *_dataArray;
    
}

//@property (nonatomic, strong) UITableView *tableView;

@end

@implementation collectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
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
    
    //    MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
    //        [self loadDataFromNet:YES];
    //    }];
    //    self.tableView.mj_footer = footer;
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
            ZPFcollectionModel *model = [[ZPFcollectionModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            MYLog(@"%@",model.jobId);
            [_dataArray addObject:model];
        }
        [self.tableView reloadData];
        
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    }];
    
}





//标签页名称
- (UILabel *)setUpButton {
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"我的收藏" forState:UIControlStateNormal];
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, -15);
    titleBtn.frame = CGRectMake(0, 0, 80, 40);
    return titleBtn;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifier";
    collectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[collectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.model = _dataArray[indexPath.row];
    

    return cell;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"删除");
        
        
        [_dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
        NSString *URLString = [baseUrl stringByAppendingString:DELETE_POSITION];
        NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
        ZPFcollectionModel *model = _dataArray[indexPath.row];
        
        [requestParams setValue:model.jobId forKey:@"jobIds"];
        
        [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
            
        } success:^(id responseObject) {
            
            
//            MYLog(@"删  %@",responseObject);
            
            
        } failure:^(NSError *error) {
            MYLog(@"没删----%@",[error description]);
        }];

        
        
        
        
        
    }];
    
//    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"查看相似职位" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"查看相似职位");
//        
//    }];
    deleteRowAction.backgroundColor = [UIColor greenColor];
//    editRowAction.backgroundColor = [UIColor blueColor];
    return @[deleteRowAction/*, editRowAction*/];
}

//创建下级界面

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    postDetailController *detailController = [[postDetailController alloc] init];
    
    [self.navigationController pushViewController:detailController animated:YES];

    
}

@end
