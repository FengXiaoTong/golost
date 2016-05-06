//
//  LCMpurchaseRecordsViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/26.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMpurchaseRecordsViewController.h"
#import "LCMpurchaseRecordsTableViewCell.h"
#import "LCMpurchaseRecordsModel.h"
#import <MJRefresh/MJRefresh.h>
#import "zyzpHttpTool.h"
#import "Common.h"
#import "Account.h"

#define IP @"http://192.168.100.20:8080/zyzpPhone/"
#define PURCHASEURL @"selectResumePurchaseByCompanyId.htm"

@interface LCMpurchaseRecordsViewController ()<UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray *_dataArray;
    UITableView *_purchaseRexcods;
}


@end

@implementation LCMpurchaseRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromNet:YES];
    self.title = @"我的购买记录";
    [self createTableView];
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    [self refreshData];
    
}
- (void)createTableView {

    _purchaseRexcods = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH - 20)];
    _purchaseRexcods.delegate = self;
    _purchaseRexcods.dataSource = self;
    [self.view addSubview:_purchaseRexcods];
    

}

- (void)refreshData {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    _purchaseRexcods.mj_header = header;
    /*
     MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
     [self loadDataFromNet:YES];
     }];
     self.tableView.mj_footer = footer;
     */
    [_purchaseRexcods.mj_header beginRefreshing];
    
}



- (void)loadDataFromNet:(BOOL)isMore {
    
    
    NSString *URLString = [baseUrl stringByAppendingString:PURCHASEURL];
    
    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
    [requestParams setValue:@"535662D0416911E5A076F8F061532E9D" forKey:@"companyId"];
    
    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        NSLog(@"%@",_dataArray);
        if (!isMore) {
            [_dataArray removeAllObjects];
        }
        NSArray *array = [NSArray arrayWithArray:responseObject];
        for (NSDictionary *dic in array) {
            LCMpurchaseRecordsModel *model = [[LCMpurchaseRecordsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        
        MYLog(@"%@",_dataArray);
        
        
        [_purchaseRexcods reloadData];
        
        isMore?[_purchaseRexcods.mj_footer endRefreshing]:[_purchaseRexcods.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        MYLog(@"%@",[error description]);
        isMore?[_purchaseRexcods.mj_footer endRefreshing]:[_purchaseRexcods.mj_header endRefreshing];
    }];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {

    static NSString *identifier = @"identifier";
    LCMpurchaseRecordsTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[LCMpurchaseRecordsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.model = _dataArray[indexPath.row];
   
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"简历详情");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
