//
//  schoolViewController.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/12.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  找工作--校园招聘

#import "schoolViewController.h"
#import "Common.h"
#import "schoolTableViewCell.h"
#import "zyzpHttpTool.h"
#import "schoolModel.h"

@interface schoolViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation schoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 4.15 新增 title
    self.title = @"校园招聘";
    
    [self getDataForUrl];
    [self addSubView];
    
                    
}

/**
<<<<<<< HEAD
 *  4.21新增 请求数据
 */
- (void)getDataForUrl
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"cityName"] = @"郑州";
    NSString *str = [baseUrl stringByAppendingString:@"selectPhoneTopJobByPractice.htm"];
    
    [zyzpHttpTool GET:str parameters:parameters progress:^{
        
    } success:^(id responseObject) {
       
        NSArray *arr = [NSArray arrayWithArray:responseObject];
         MYLog(@"%@", arr);
         MYLog(@"%@", arr.lastObject);
        self.dataArray = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            schoolModel *model = [[schoolModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

/**
=======
>>>>>>> origin/wangzhiqun
 *  4.19改动
 */


- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 122)];
    view.backgroundColor = zyMainColor;
    self.tableView.tableHeaderView = view;
    [self.view addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    schoolModel *model = self.dataArray[indexPath.row];
    schoolTableViewCell *cell = [schoolTableViewCell cellWithTableView:tableView];
    
    cell.zwnameLable.text = model.jobName;
    cell.qynameLable.text = model.companyName;
    cell.addressLabel.text = model.publishAreaName;
    cell.schoolLabel.text = model.education;
    cell.moneyLabel.text = [[NSString stringWithFormat:@"%ld", (long)model.salary] stringByAppendingString:@"k"];
    
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
