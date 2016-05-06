//
//  publishViewController.m
//  RecruitmentProduct
//
//  Created by andorid on 16/3/31.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  找人才--发布兼职

#import "publishViewController.h"
#import "Common.h"
#import "QYpublishTableViewCell.h"
#import "UIView+ZYFrame.h"

@interface publishViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) UIView *bwView;

@end

@implementation publishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 4.15 新增 title
    self.title = @"发布兼职";

    [self addBwView];
    [self addSubView];
}

// 新增
- (void)addBwView
{
    // 4.15 改动frame
    self.bwView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 150)];
    UIButton *button = [UIButton buttonWithType:0];
//    button.frame = CGRectMake(20, 80, screenW - 40, 50);
    button.x = 23;
    button.y = 30;
    button.width = (screenW - 23 - 23 - 15) / 2;
    button.height = 44;
    
    [button.layer setCornerRadius:5.0];
    [button setTitle:@"发布兼职" forState:(UIControlStateNormal)];
    button.backgroundColor = zyMainColor;
    [button addTarget:self action:@selector(actionButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *button1 = [UIButton buttonWithType:0];
//    button1.frame = CGRectMake(20, 150, screenW - 40, 50);
    button1.x = CGRectGetMaxX(button.frame) + 15;
    button1.y = 30;
    button1.width = button.width;
    button1.height = button.height;
    
    [button1.layer setCornerRadius:5.0];
    [button1 setTitle:@"保存为未发布" forState:(UIControlStateNormal)];
    button1.backgroundColor = zyMainColor;

    [button1 addTarget:self action:@selector(actionButtonone:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    [self.bwView addSubview:button];
    [self.bwView addSubview:button1];
}

- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.array = @[@"职位名称", @"职位类别", @"招聘人数", @"兼职时间", @"薪资水平", @"薪资结算", @"兼职有效期", @"职位描述", @"职位发布地点", @"工作地址", @"联系人", @"联系电话", @"简历接收邮箱"];
    self.tableView.tableFooterView = self.bwView;
    [self.view addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 43;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"publishVC";
    QYpublishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QYpublishTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    
    cell.jtimage.image = [UIImage imageNamed:@"find_go"];
    cell.nameLabel.textColor = Color(138, 138, 138);
    cell.nameLabel.text = [self.array objectAtIndex:indexPath.row];

    
    return cell;
}

- (void)actionButton:(UIButton *)button
{
    button.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

- (void)actionButtonone:(UIButton *)btn
{
    btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

// cell的点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 13) {
        NSLog(@"13");
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
