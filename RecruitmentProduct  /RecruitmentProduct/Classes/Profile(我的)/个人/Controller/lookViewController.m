//
//  lookViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/11.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "lookViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "ZPFlookModel.h"
#import "lookTableViewCell.h"
#import "Account.h"
#import "zyzpHttpTool.h"
#import "ZPFcompanyDetailsController.h"
#import "Common.h"


#define SEGMENT_HEIGHT 43
#define TITLEVIEW_SIZE self.navigationItem.titleView.frame.size

#define PERSONVIEWED @"selectPersonViewed.htm"
#define WHOBUYME @"selectwhobuyme.htm"

#define URLSTRING @"http://192.168.100.16/zyzpPhone/"


@interface lookViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *requestParams;

@end

@implementation lookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = [self addSegMentView];
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    _string = PERSONVIEWED;

    [self createTableView];
}





//标签页名称
//- (UIButton *)setUpButton {
//    
//    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [titleBtn setTitle:@"谁看了我" forState:UIControlStateNormal];
//    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, -15);
//    titleBtn.frame = CGRectMake(0, 0, 80, 40);
//    return titleBtn;
//}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
    
    
//    NSString *URLString = [baseUrl stringByAppendingString:_string];
    NSString *URLString = [URLSTRING stringByAppendingString:_string];
    _requestParams = [[Account currentAccount] requestParams];
    
    [zyzpHttpTool GET:URLString parameters:_requestParams progress:^{
        
    } success:^(id responseObject) {
        
        if (!isMore) {
            [_dataArray removeAllObjects];
        }
        NSArray *array = [NSArray arrayWithArray:responseObject];
        for (NSDictionary *dic in array) {
            ZPFlookModel *model = [[ZPFlookModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [self.tableView reloadData];
        
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    }];
}




- (UISegmentedControl *)addSegMentView {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", nil];
    self.segment = [[UISegmentedControl alloc] initWithItems:array];
    [_segment addTarget:self action:@selector(action:) forControlEvents:(UIControlEventValueChanged)];
    _segment.selectedSegmentIndex = 0;
    
    [_segment setTitle:@"谁看了我" forSegmentAtIndex:0];
    [_segment setTitle:@"谁购买了我" forSegmentAtIndex:1];
    _segment.tintColor= [UIColor whiteColor];
    _segment.frame = CGRectMake(TITLEVIEW_SIZE.width - 60/2, 8, 60, 30);
    return _segment;
}


- (void)action:(UISegmentedControl *)seg
{
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            _string = PERSONVIEWED;
            [self.tableView.mj_header beginRefreshing];
            break;
        case 1:
            _string = WHOBUYME;
            [self.tableView.mj_header beginRefreshing];
            break;
        default:
            break;
    }
}

#pragma make - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    lookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[lookTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }

    cell.model = _dataArray[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ZPFlookModel *model = _dataArray[indexPath.row];
    ZPFcompanyDetailsController *detailController = [[ZPFcompanyDetailsController alloc] init];
    detailController.companyId = model.companyId;
    [self.navigationController pushViewController:detailController animated:YES];

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
