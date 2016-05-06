//
//  QYpositionManageViewController.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/19.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

/**
 *  4.19新增 管理职位列表
 */

#import "QYpositionManageViewController.h"
#import "QYpositionTableViewCell.h"
#import "Common.h"

@interface QYpositionManageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QYpositionManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"管理职位列表";
    self.tableView.rowHeight = 86;
    [self addSubView];
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

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYpositionTableViewCell *cell = [QYpositionTableViewCell cellWithTableView:tableView];
    
    return cell;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"刷新" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"刷新");
    }];
    
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"暂停" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"暂停");
        
    }];
    
    UITableViewRowAction *modelRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"模板" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"模板");
        
    }];
    
    UITableViewRowAction *beginRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"修改");
        
    }];
    deleteRowAction.backgroundColor = Color(255, 178, 0);
    editRowAction.backgroundColor = Color(94, 163, 118);
    modelRowAction.backgroundColor = Color(73, 177, 212);
    beginRowAction.backgroundColor = Color(144, 209, 167);
    //    editRowAction.backgroundColor = [UIColor colorWithRed:0 green:124/255.0 blue:223/255.0 alpha:1];
    return @[deleteRowAction, editRowAction, modelRowAction, beginRowAction];
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
