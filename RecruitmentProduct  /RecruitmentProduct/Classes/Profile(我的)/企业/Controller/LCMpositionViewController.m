//
//  LCMpositionViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/26.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMpositionViewController.h"
#import "LCMpositionTableViewCell.h"
#import "LCMpositionModel.h"
#import <MJRefresh/MJRefresh.h>
#import "zyzpHttpTool.h"
#import "Common.h"
#import "Account.h"

#define POSITIONURL @"toPhoneJobEffectCount.htm"
@interface LCMpositionViewController ()<UITableViewDelegate,UITableViewDataSource> {

    NSMutableArray *_dataArray;
    UITableView *_positionView;
}

@end

@implementation LCMpositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromNet:YES];
    self.title = @"职位发布统计";
    [self createTableView];
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    [self refreshData];
}
- (void)createTableView {
    
    _positionView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH - 20)];
    _positionView.delegate = self;
    _positionView.dataSource = self;
    [self.view addSubview:_positionView];
    
    
}
- (void)refreshData {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    _positionView.mj_header = header;
    /*
     MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
     [self loadDataFromNet:YES];
     }];
     self.tableView.mj_footer = footer;
     */
    [_positionView.mj_header beginRefreshing];
    
}



- (void)loadDataFromNet:(BOOL)isMore {
    
    
    NSString *URLString = [baseUrl stringByAppendingString:POSITIONURL];
    
    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
    [requestParams setValue:@"535662D0416911E5A076F8F061532E9D" forKey:@"companyId"];
    
    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        
        if (!isMore) {
            [_dataArray removeAllObjects];
        }
        NSArray *array = [NSArray arrayWithArray:responseObject];
        for (NSDictionary *dic in array) {
            LCMpositionModel *model = [[LCMpositionModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
            //MYLog(@"%@", model.publishAreaName);
        }
        
        //MYLog(@"%@",_dataArray);
        
        
        [_positionView reloadData];
        
        isMore?[_positionView.mj_footer endRefreshing]:[_positionView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        //MYLog(@"%@",[error description]);
        isMore?[_positionView.mj_footer endRefreshing]:[_positionView.mj_header endRefreshing];
    }];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    static NSString *identifier = @"identifier";
    LCMpositionTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[LCMpositionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.model = _dataArray[indexPath.row];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"职位详情");
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
