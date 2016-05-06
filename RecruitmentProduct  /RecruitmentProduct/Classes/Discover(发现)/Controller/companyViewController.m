//
//  companyViewController.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/12.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "companyViewController.h"
#import "Common.h"
#import "companyTableViewCell.h"

@interface companyViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation companyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 4.15 新增 title
    self.title = @"行业名企";
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationController.navigationBar.translucent = NO;
    [self addImageView];
    [self addSubView];
}

- (void)addImageView
{
    UIImageView *Iview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, 200)];
    Iview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:Iview];
}

- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, screenW, screenH - 200) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor redColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"companyVC";
    companyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[companyTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor yellowColor];
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
