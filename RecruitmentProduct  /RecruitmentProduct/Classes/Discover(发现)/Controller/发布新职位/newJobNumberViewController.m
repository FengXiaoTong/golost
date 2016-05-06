//
//  newJobNumberViewController.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/18.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

/**
 *  4.18新增 招聘人数
 */

#import "newJobNumberViewController.h"
#import "Common.h"

@interface newJobNumberViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *arr;

@end

@implementation newJobNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"招聘人数";
    self.arr = @[@"1-3 人", @"3-5 人", @"5-10 人", @"10-50 人", @"50-100 人"];
    [self addSubView];
}

- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"newJobNumberVC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    cell.textLabel.textColor = Color(138, 138, 138);
    cell.textLabel.text = self.arr[indexPath.row];
    return cell;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
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
