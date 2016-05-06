//
//  adviceViewController.m
//  RecruitmentProduct
//
//  Created by andorid on 16/3/31.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  找工作--求职指导

#import "adviceViewController.h"
#import "Common.h"
#import "adviceTableViewCell.h"
#import "adviceVC.h"

@interface adviceViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation adviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 4.15 新增 title
    self.title = @"求职指导";
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.dataArray = @[@"最新文章"];
    [self addSegMentView];
    [self addSubView];
    self.tableView.rowHeight = 86;
    
}

// 添加segmengt
- (void)addSegMentView
{
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", nil];
    self.segment = [[UISegmentedControl alloc] initWithItems:array];
    [_segment addTarget:self action:@selector(action:) forControlEvents:(UIControlEventValueChanged)];
    _segment.selectedSegmentIndex = 0;
    
    [_segment setTitle:@"最新文章" forSegmentAtIndex:0];
    [_segment setTitle:@"热门推荐" forSegmentAtIndex:1];
    //    segment.backgroundColor = [UIColor blueColor];
    _segment.frame = CGRectMake(100, 100, 200, 40);
    [self.view addSubview:_segment];
    
}

- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, screenW, screenH- 150) style:0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.tableView];
    
}

- (void)action:(UISegmentedControl *)seg
{
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            self.dataArray = @[@"最新文章"];
            [self.tableView reloadData];
            break;
        case 1:
            self.dataArray = @[@"热门推荐"];
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 86;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    adviceTableViewCell *advicecell = [adviceTableViewCell cellWithTableView:tableView];
        
        // 后面有小箭头方法~~
    advicecell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return advicecell;
}

// cell的点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    adviceVC *advice = [[adviceVC alloc] init];
    [self.navigationController pushViewController:advice animated:YES];
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
