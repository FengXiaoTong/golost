//
//  interviewVC.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/7.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  模拟面试详情页面

#import "interviewVC.h"
#import "Common.h"
#import "UIView+ZYFrame.h"
#import "zyzpHttpTool.h"
#import "Account.h"

@interface interviewVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

// 外围array
@property (nonatomic, strong) NSMutableArray *bigArray;

// 内部array
@property (nonatomic, strong) NSMutableArray *smArray;


@property (nonatomic, assign) NSInteger number;

@property (nonatomic, strong) NSMutableArray *nameArray;

@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 *  4.21晚 新增namelabel
 */
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) NSMutableArray *numArray;

@end

@implementation interviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.number = 0;
    [self getDataForUrl];
    self.title = @"毕业生篇";
    [self addSubView];
    [self addButton];
    [self addSubViews];
    //    [self actionButton:nil];
}

- (void)getDataForUrl
{
    if ([[Account currentAccount] isLogin]) {
        
        NSString *str = [baseUrl stringByAppendingString:@"toSystemInterviewByType.htm"];
        NSMutableDictionary *parameters = [[Account currentAccount] requestParams];
        parameters[@"paperType"] = self.per;
        MYLog(@"%@", parameters[@"paperType"]);
        [zyzpHttpTool GET:str parameters:parameters progress:^{
            
        } success:^(id responseObject) {
            MYLog(@"%@", responseObject);
            
            self.nameArray = [NSMutableArray array];
            self.bigArray = responseObject;
            for (NSDictionary *dic in self.bigArray) {
                NSString *str = dic[@"questionName"];
                id numw = dic[@"questionOrders"];
                [self.nameArray addObject:str];
                [self.numArray addObject:numw];
            }
            self.nameLabel.text = self.nameArray[0];
            self.smArray = self.bigArray[self.number][@"solutionList"];
            MYLog(@"%ld", (unsigned long)self.smArray.count);
            self.dataArray = [NSMutableArray array];
            for (NSDictionary *dic1 in self.smArray) {
                
                NSString *str = dic1[@"solutionName"];
                [self.dataArray addObject:str];
            }
            
            [self.tableView reloadData];
            MYLog(@"%ld", (unsigned long)self.bigArray.count);
            
            
            
        } failure:^(NSError *error) {
            
        }];
        
    }
}
- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"interVC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}




- (void)addButton
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 50)];
    self.tableView.tableFooterView = view;
    
    UIButton *button = [UIButton buttonWithType:0];
    button.x = 23;
    button.y = 6;
    button.width = screenW - 46;
    button.height = 44;
    [button.layer setCornerRadius:5.0];
    [button setTitle:@"下一题" forState:(UIControlStateNormal)];
    button.backgroundColor = zyMainColor;
    [button addTarget:self action:@selector(actionButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:button];
}

- (void)addSubViews
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 58)];
    self.tableView.tableHeaderView = view;
    
    self.nameLabel = [[UILabel alloc] init];
    
    _nameLabel.x = 25;
    _nameLabel.y = 32;
    _nameLabel.text = self.dataArray[0];
    _nameLabel.width = 229;
    _nameLabel.height = 15;
    _nameLabel.backgroundColor = [UIColor yellowColor];
    [view addSubview:_nameLabel];
}

- (void)actionButton:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"完成"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (_number < self.bigArray.count) {
        _number++;
        self.nameLabel.text = self.nameArray[self.number];
        self.smArray = self.bigArray[self.number][@"solutionList"];
        MYLog(@"%ld", (unsigned long)self.smArray.count);
        self.dataArray = [NSMutableArray array];
        for (NSDictionary *dic1 in self.smArray) {
            
            NSString *str = dic1[@"solutionName"];
            [self.dataArray addObject:str];
        }
        
        [self.tableView reloadData];
        MYLog(@"1");
        MYLog(@"%ld", (long)self.number);
        if (_number == self.bigArray.count - 1) {
            [button setTitle:@"完成" forState:(UIControlStateNormal)];
        }
        
    }
    
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
