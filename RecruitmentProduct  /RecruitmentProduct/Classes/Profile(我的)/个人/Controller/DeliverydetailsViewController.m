//
//  DeliverydetailsViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/6.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//


#import "DeliverydetailsViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "ModelTableViewCell.h"
#import "ZPFrecordModel.h"
#import "DTKDropdownMenuView.h"
#import "Account.h"
#import "Common.h"
#import "zyzpHttpTool.h"

#import "postDetailController.h"



//#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]


#define URLSTRING @"selectPersonalSends.htm"

@interface DeliverydetailsViewController () {

    NSMutableArray *_dataArray;
    NSString *_viewState;
}

@end

@implementation DeliverydetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleMenu];
    self.navigationController.navigationBar.translucent = NO;
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    if (!_viewState) {
        _viewState = @"";
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
    
    if (_viewState.length) {
        [requestParams setValue:_viewState forKey:@"viewState"];
    }
   
    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        
        if (!isMore) {
            [_dataArray removeAllObjects];
        }
        
        NSArray *array = [NSArray arrayWithArray:responseObject];
        for (NSDictionary *dic in array) {
            ZPFrecordModel *model = [[ZPFrecordModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
    
        [self.tableView reloadData];
        
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    }];

    
}



-(void)addTitleMenu{

    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"全部" callBack:^(NSUInteger index, id info) {
        _viewState = @"";
        [self.tableView.mj_header beginRefreshing];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"投递成功" callBack:^(NSUInteger index, id info) {
        _viewState = @"00";
        [self.tableView.mj_header beginRefreshing];

    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"已被查看" callBack:^(NSUInteger index, id info) {
        _viewState = @"01";
        [self.tableView.mj_header beginRefreshing];
    }];
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"对我有意" callBack:^(NSUInteger index, id info) {
        _viewState = @"04";
        [self.tableView.mj_header beginRefreshing];
    }];
    DTKDropdownItem *item4 = [DTKDropdownItem itemWithTitle:@"面试邀请" callBack:^(NSUInteger index, id info) {
        _viewState = @"02";
        [self.tableView.mj_header beginRefreshing];
    }];
    DTKDropdownItem *item5 = [DTKDropdownItem itemWithTitle:@"暂不合适" callBack:^(NSUInteger index, id info) {
        _viewState = @"03";
        [self.tableView.mj_header beginRefreshing];
    }];

    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewForNavbarTitleViewWithFrame:CGRectMake(0, 0, 200.f, 44.f) dropdownItems:@[item0,item1,item2,item3,item4,item5]];
    menuView.currentNav = self.navigationController;
    menuView.dropWidth = 414.f;
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = ColorWithRGB(102.f, 102.f, 102.f);

    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = [UIColor grayColor];
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    
    menuView.animationDuration = 0.3f;
    menuView.selectedIndex = 0;
    self.navigationItem.titleView = menuView;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifier";
    ModelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ModelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = _dataArray[indexPath.row];
    
    return cell;
}

//创建下级界面

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    postDetailController *detailController = [[postDetailController alloc] init];
    
    [self.navigationController pushViewController:detailController animated:YES];
    
    
    
    


    }

@end
