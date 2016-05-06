//
//  LCMoperationViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/27.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMoperationViewController.h"
#import "LCMoperationTableViewCell.h"
#import "LCMoperationModel.h"
#import <MJRefresh/MJRefresh.h>
#import "zyzpHttpTool.h"
#import "Common.h"
#import "Account.h"

//#define IP @"http://192.168.100.67/zyzpPhone/"
#define OPERATIONURL @"toPhoneCompanyOperationList.htm"

@interface LCMoperationViewController ()<UITableViewDelegate,UITableViewDataSource> {

    NSMutableArray *_dataArray;
    UITableView *_operationView;
}

@end

@implementation LCMoperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromNet:YES];
    self.title = @"操作日志";
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    [self createTableView];
    

    

}
- (void)createTableView {
    
    _operationView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH - 64)];
    _operationView.delegate = self;
    _operationView.dataSource = self;
    [self.view addSubview:_operationView];
    
        [self refreshData];
}


- (void)refreshData {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    _operationView.mj_header = header;
    /*
     MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
     [self loadDataFromNet:YES];
     }];
     self.tableView.mj_footer = footer;
     */
    [_operationView.mj_header beginRefreshing];
    
}



- (void)loadDataFromNet:(BOOL)isMore {
    
    
    NSString *URLString = [baseUrl stringByAppendingString:OPERATIONURL];
    
    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
    [requestParams setValue:@"535662D0416911E5A076F8F061532E9D" forKey:@"companyId"];
    
    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        if (!isMore) {
            [_dataArray removeAllObjects];
        }
        NSArray *array = [NSArray arrayWithArray:responseObject];
        for (NSDictionary *dic in array) {
            LCMoperationModel *model = [[LCMoperationModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        
        NSLog(@"%@",_dataArray);

        [_operationView reloadData];
        
        isMore?[_operationView.mj_footer endRefreshing]:[_operationView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        //MYLog(@"%@",[error description]);
        isMore?[_operationView.mj_footer endRefreshing]:[_operationView.mj_header endRefreshing];
    }];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    static NSString *identifier = @"identifier";
    LCMoperationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[LCMoperationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.model = _dataArray[indexPath.row];
    
    
    return cell;
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
