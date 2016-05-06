//
//  focusViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/6.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "focusViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "ZPFfocusModel.h"
#import "focusTableViewCell.h"
#import "Account.h"
#import "zyzpHttpTool.h"
#import "Common.h"
#import "ZPFcompanyDetailsController.h"



#import "QuestionViewController.h"


#define URLSTRING @"selectPhoneAllStoreCompanys.htm"
#define DEKETE_FOCUS @"deletePhoneStoreCompany.htm"

#define URLSTRING_11 @"http://192.168.100.11/zyzpPhone/"


@interface focusViewController() {

    NSMutableArray *_dataArray;

}

@end

@implementation focusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = [self setUpButton];
    
    
    if (!_dataArray) {
        _dataArray= [NSMutableArray array];
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
    
    
    NSString *URLString = [URLSTRING_11 stringByAppendingString:URLSTRING];
    
    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
    

    
    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        
        if (!isMore) {
            [_dataArray removeAllObjects];
        }
        NSArray *array = [NSArray arrayWithArray:responseObject];
        for (NSDictionary *dic in array) {
            ZPFfocusModel *model = [[ZPFfocusModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
            MYLog(@"%@",_dataArray);
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
    [titleBtn setTitle:@"关注公司" forState:UIControlStateNormal];
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
    
    focusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[focusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.model = _dataArray[indexPath.row];
    
    
    return cell;
}


- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        //删除数据源数据
        [_dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
        
        //删除服务器数据
        NSString *URLString = [baseUrl stringByAppendingString:DEKETE_FOCUS];
        NSMutableDictionary *requestParams = [NSMutableDictionary dictionary];
        
        ZPFfocusModel *model = _dataArray[indexPath.row];
        [requestParams setValue:model.storeCompanyId forKey:@"storeCompanyIds"];
        

        [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
            
        } success:^(id responseObject) {
            MYLog(@"删  %@",responseObject);
        } failure:^(NSError *error) {
            MYLog(@"没删----%@",[error description]);
        }];
        
    }];
    deleteRowAction.backgroundColor = [UIColor blueColor];
    return @[deleteRowAction];
}

//创建下级界面

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZPFfocusModel *model = _dataArray[indexPath.row];
    ZPFcompanyDetailsController *detailController = [[ZPFcompanyDetailsController alloc] init];
    detailController.companyId = model.companyId;
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
