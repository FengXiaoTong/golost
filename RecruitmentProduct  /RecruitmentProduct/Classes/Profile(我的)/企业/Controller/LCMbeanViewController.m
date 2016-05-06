//
//  LCMbeanViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/28.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMbeanViewController.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "ZPFLableOperation.h"
#import "LCMbeanTableViewCell.h"
#import "LCMprepaidViewController.h"
#import "LCMbeanModel.h"
#import "Common.h"
#import "Account.h"
#import "zyzpHttpTool.h"

#define HEADVIEW_HEIGHTS 90
#define SEGMENT_HEIGHTS 43

#define BEANURL @"selectPhoneCompanyzyMoney.htm"

@interface LCMbeanViewController ()<UITableViewDelegate,UITableViewDataSource>

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
@property (nonatomic, strong) UIButton *prepaidButton;


@end

@implementation LCMbeanViewController

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

- (UIButton *)setUpButton {
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"我的指慧豆" forState:UIControlStateNormal];
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, -15);
    titleBtn.frame = CGRectMake(0, 0, 80, 40);
    return titleBtn;
    
}


- (void)createHeadView {
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, HEADVIEW_HEIGHTS)];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    
    UIImageView *icon = [[UIImageView alloc] init];
    
    CGFloat icon_top = 15;
    CGFloat icon_left = 12;
    CGSize icon_size = CGSizeMake(61, 61);
   
    icon.frame = CGRectMake(icon_left, icon_top, icon_size.width, icon_size.height);
    [icon sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    [_headView addSubview:icon];
    
    _nameLab = [[UILabel alloc] init];
    CGFloat name_top = 24;
    CGFloat name_left = 12;
    CGFloat name_height = 18;
    CGFloat name_width_max = screenW - CGRectGetMaxX(icon.frame) - name_left;
    _nameLab.frame = CGRectMake(CGRectGetMaxX(icon.frame) + name_left, name_top, name_width_max, name_height);
    _nameLab.text = @"阿里巴巴集团";
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
    


    _prepaidButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat top = 13;
    CGFloat perpaidBt_right = 20;
    CGFloat perpaid_width = 70;
    CGFloat perpaid_height = 30;
    _prepaidButton.frame = CGRectMake(screenW - perpaidBt_right- perpaid_width, CGRectGetMaxY(_nameLab.frame) + top/2, perpaid_width, perpaid_height);
    _prepaidButton.layer.cornerRadius = 10;
    _prepaidButton.backgroundColor = [UIColor orangeColor];
    [_prepaidButton setTitle:@"去充值" forState:UIControlStateNormal];
    [_prepaidButton addTarget:self action:@selector(perpaidAction) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_prepaidButton];
    
    
    CGFloat beancountLab_height = 18;
    CGFloat beanCount_width_Max = CGRectGetMinX(_prepaidButton.frame) - CGRectGetMaxX(beanLab.frame);
    _beanCountLab = [[UILabel alloc] init];
    [_beanCountLab setAttributedText:[self positionNumber:[NSString stringWithFormat:@"%@ 枚",_totality]  withSize:beancountLab_height]];
    _beanCountLab.frame = CGRectMake(CGRectGetMaxX(beanLab.frame), CGRectGetMinY(beanLab.frame), beanCount_width_Max, beancountLab_height);
    [_headView addSubview:_beanCountLab];
    
}
- (void)perpaidAction {

    LCMprepaidViewController *perpaidVC = [[LCMprepaidViewController alloc] init];
    perpaidVC.iconImageURL = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1462006761&di=dae2d3ff9645b21276263ff16b5e8f26&src=http://img4.duitang.com/uploads/item/201312/05/20131205171756_cfAFz.thumb.600_0.jpeg";
    
    perpaidVC.companyName = _nameLab.text;
    [self.navigationController pushViewController:perpaidVC animated:YES];

    
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
    
    
    [_segment setTitle:@"充值明细" forSegmentAtIndex:0];
    [_segment setTitle:@"消费明细" forSegmentAtIndex:1];
    _segment.frame = CGRectMake(12, HEADVIEW_HEIGHTS, screenW - 20, SEGMENT_HEIGHTS);
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SEGMENT_HEIGHTS + HEADVIEW_HEIGHTS, screenW, screenH - SEGMENT_HEIGHTS - HEADVIEW_HEIGHTS - 64)];
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
    
    NSString *URLString = BEANURL;
    
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
            LCMbeanModel *model = [[LCMbeanModel alloc] init];
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
    LCMbeanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LCMbeanTableViewCell  alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _dataArray[indexPath.row];
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
