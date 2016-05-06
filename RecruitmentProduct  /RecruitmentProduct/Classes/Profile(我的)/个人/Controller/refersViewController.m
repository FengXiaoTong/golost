//
//  refersViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/6.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//
#import "refersViewController.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "ZPFLableOperation.h"
#import "ZPFrefersModel.h"
#import "refersTableViewCell.h"
#import "Common.h"
#import "Account.h"
#import "zyzpHttpTool.h"


#define HEADVIEW_HEIGHT 80
#define SEGMENT_HEIGHT 43

#define URLSTRING @"selectpersonpaystream.htm"

#define URLSTRING_11 @"http://192.168.100.11/zyzpPhone/selectpersonpaystream.htm"


@interface refersViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segment;
//指慧豆总数
@property (nonatomic, copy) NSString *totality;
//用户名
@property (nonatomic, copy) NSString *personName;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString *payType;

@property (nonatomic, strong) UILabel *beanCountLab;
@property (nonatomic, strong) UILabel *nameLab;
@end

@implementation refersViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = [self setUpButton];
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    _payType = @"01";

    [self createTableView];
    [self createHeadView];
    [self addSegMentView];
    
}

//标签页名称
- (UIButton *)setUpButton {
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"指慧豆" forState:UIControlStateNormal];
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, -15);
    titleBtn.frame = CGRectMake(0, 0, 80, 40);
    return titleBtn;
    
}


- (void)createHeadView {

    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, HEADVIEW_HEIGHT)];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    
    UIImageView *icon = [[UIImageView alloc] init];
    CGFloat icon_top = 8;
    CGFloat icon_left = 12;
    CGSize icon_size = CGSizeMake(61, 61);
    icon.frame = CGRectMake(icon_left, icon_top, icon_size.width, icon_size.height);
    [icon sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"details_mr"]];
    [_headView addSubview:icon];
    
    _nameLab = [[UILabel alloc] init];
    CGFloat name_top = 24;
    CGFloat name_left = 12;
    CGFloat name_height = 18;
    CGFloat name_width_max = screenW - CGRectGetMaxX(icon.frame) - name_left;
    _nameLab.frame = CGRectMake(CGRectGetMaxX(icon.frame) + name_left, name_top, name_width_max, name_height);
    _nameLab.font = [UIFont systemFontOfSize:18];
    [_headView addSubview:_nameLab];
    
    UIImageView *beanIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bean1"]];
    CGFloat beanIV_top = 7;
    CGFloat beanIV_X = CGRectGetMinX(_nameLab.frame);
    CGFloat beanIV_Y = CGRectGetMaxY(_nameLab.frame) + beanIV_top;
    CGSize beanIV_size = CGSizeMake(20, 23);
    beanIV.frame = CGRectMake(beanIV_X, beanIV_Y, beanIV_size.width, beanIV_size.height);
    [_headView addSubview:beanIV];
    
    UILabel *beanLab = [[UILabel alloc] init];
    beanLab.text = @"指慧豆：";
    CGFloat beanLab_left = 6;
    CGFloat beanLab_top = 13;
    CGFloat beanLab_height = 15;
    CGSize bean_size = [ZPFLableOperation sizeWithText:@"指慧豆：" maxSize:CGSizeMake(CGFLOAT_MAX, beanLab_height) font:[UIFont systemFontOfSize:beanLab_height]];
    
    beanLab.font = [UIFont systemFontOfSize:beanLab_height];
    beanLab.frame = CGRectMake(CGRectGetMaxX(beanIV.frame) + beanLab_left, CGRectGetMaxY(_nameLab.frame) + beanLab_top, bean_size.width, bean_size.height);
    [_headView addSubview:beanLab];
    
    _beanCountLab = [[UILabel alloc] init];
    CGFloat beancountLab_height = 18;
    CGFloat beancountLab_width_Max = screenW - CGRectGetMaxX(beanIV.frame) - beanLab_left;
    _beanCountLab.frame = CGRectMake(CGRectGetMaxX(beanLab.frame), CGRectGetMinY(beanLab.frame), beancountLab_width_Max, beancountLab_height);
    [_beanCountLab setAttributedText:[self positionNumber:[NSString stringWithFormat:@"%@ 枚",_totality]  withSize:beancountLab_height]];
    [_headView addSubview:_beanCountLab];
}

- (void)setName {
    
    _nameLab.text = _personName;
    [_beanCountLab setAttributedText:[self positionNumber:[NSString stringWithFormat:@"%@ 枚",_totality]  withSize:18]];
}


- (NSMutableAttributedString *)positionNumber:(NSString *)string withSize:(CGFloat)size {
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@"枚"].location);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:redRange];
    return noteStr;
}



- (void)addSegMentView {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", nil];
    self.segment = [[UISegmentedControl alloc] initWithItems:array];
    [_segment addTarget:self action:@selector(action:) forControlEvents:(UIControlEventValueChanged)];
    _segment.selectedSegmentIndex = 0;
    
    
    //正常状态
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                               NSForegroundColorAttributeName: [UIColor blackColor]};
    [_segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    
    //选中状态
     NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
     NSForegroundColorAttributeName: [UIColor redColor]};
     [_segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];

     
    
//    _segment.tintColor = [UIColor whiteColor];
    _segment.backgroundColor = [UIColor whiteColor];


    [_segment setTitle:@"收入" forSegmentAtIndex:0];
    [_segment setTitle:@"支出" forSegmentAtIndex:1];
    _segment.frame = CGRectMake(10, HEADVIEW_HEIGHT, screenW - 20, SEGMENT_HEIGHT);
    [self.view addSubview:_segment];
}

- (void)action:(UISegmentedControl *)seg {
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            _payType = @"01";
            [self.tableView.mj_header beginRefreshing];
            break;
        case 1:
            _payType = @"02";
            [self.tableView.mj_header beginRefreshing];
            break;
        default:
            break;
    }
}


- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SEGMENT_HEIGHT + HEADVIEW_HEIGHT, screenW, screenH - SEGMENT_HEIGHT - HEADVIEW_HEIGHT - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self refreshData];
}


- (void)refreshData {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    self.tableView.mj_header = header;
    
    //    MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
    //        [self loadDataFromNet:YES];
    //    }];
    //    self.tableView.mj_footer = footer;
    [self.tableView.mj_header beginRefreshing];
    
}



- (void)loadDataFromNet:(BOOL)isMore {
    
    
//    NSString *URLString = [baseUrl stringByAppendingString:URLSTRING];
    
    NSString *URLString = URLSTRING_11;
    
    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
    [requestParams setValue:@"01" forKey:@"currentpage"];
    [requestParams setValue:_payType forKey:@"PayType"];

    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        
        if (!isMore) {
            [_dataArray removeAllObjects];
        }
        NSArray *array = [NSArray arrayWithArray:responseObject];
        _totality = array[0][@"zyMony"];
        _personName = array[1][@"personName"];
        for (NSDictionary *dic in array[2]) {
            ZPFrefersModel *model = [[ZPFrefersModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];

        }
        [self setName];
        [self.tableView reloadData];
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    }];
    
}


#pragma make - tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    refersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[refersTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end


