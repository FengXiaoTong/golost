//
//  interviewViewController.m
//  RecruitmentProduct
//
//  Created by andorid on 16/3/31.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  模拟面试


#import "interviewViewController.h"
#import "interviewTableViewCell.h"
#import "interviewVC.h"
#import "zyzpHttpTool.h"
#import "Common.h"
#import "Account.h"

@interface interviewViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger num;

@end

@implementation interviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 4.15 新增 title
    self.title = @"模拟面试";
    self.tableView.rowHeight = 86;
    [self getDataForUrl];
    [self addSubView];
}

- (void)getDataForUrl
{
    
    
}

- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
//    self.tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSArray *picArray = @[@"毕业生篇", @"市场", @"技术", @"文职"];
    interviewTableViewCell *cell = [interviewTableViewCell cellWithTableView:tableView];
    
    cell.titleimage.image = [UIImage imageNamed:picArray[indexPath.row]];
    

    return cell;
}

// cell的点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    interviewVC *interview = [[interviewVC alloc] init];
    interview.per = [@"0"stringByAppendingString:[NSString stringWithFormat:@"%d", indexPath.row + 1]];
    [self.navigationController pushViewController:interview animated:YES];
    
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
