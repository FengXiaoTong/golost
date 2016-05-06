//
//  QYmanageViewController.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/14.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

/**
 *  找人才--职位管理界面
 */

#import "QYmanageViewController.h"
#import "publishViewController.h"
#import "QYJobViewController.h"
#import "QYmanageTableViewCell.h"
#import "Common.h"
#import "QYpositionManageViewController.h"

@interface QYmanageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation QYmanageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = @[@"发布新职位", @"发布兼职", @"管理职位列表", @"管理兼职列表"];
    [self addSubView];
}

- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    // 4.15新增 禁止滑动
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 4.15修改
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"QYmanageVC";
    QYmanageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QYmanageTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    // 后面有小箭头方法~~
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.nameLabel.textColor = Color(138, 138, 138);
    cell.nameLabel.text = self.dataArray[indexPath.row];
    cell.jtimage.image = [UIImage imageNamed:@"find_go"];
    
    return cell;
}


#pragma mark - cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 4.15日 新增if判断跳转
    if (indexPath.row == 0) {
        QYJobViewController *QYjob = [[QYJobViewController alloc] init];
        [self.navigationController pushViewController:QYjob animated:YES];
    } else if (indexPath.row == 1) {
        publishViewController *publish = [[publishViewController alloc] init];
        [self.navigationController pushViewController:publish animated:YES];
    } else if (indexPath.row == 2) {
        QYpositionManageViewController *position = [[QYpositionManageViewController alloc] init];
        [self.navigationController pushViewController:position animated:YES];
    }
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
