//
//  positionController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/8.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "positionController.h"
#import "positionSectionHeaderView.h"
#import "positionGroup.h"

@interface positionController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation positionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [UISearchBar new];
    [self didSetUpTableView];
}

- (void)didSetUpTableView{
    UITableView *tableView =[[UITableView alloc] initWithFrame:self.view.bounds style:0];
    tableView.delegate = self;
    tableView.dataSource =self;
    [self.view addSubview:tableView];
    
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idenifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:idenifier];
        
    }
    
    cell.textLabel.text = @"子行业";
    return cell;

    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    positionSectionHeaderView *sectionHeaderView = [positionSectionHeaderView headerViewWithTableView:tableView];
    
    sectionHeaderView.headerViewClick = ^(){
        [tableView reloadData];
    };
    return sectionHeaderView;
    
}

@end
