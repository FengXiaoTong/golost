//
//  QYJobViewController.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/15.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//
/**
 *  4.15日 新增企业发布职位
 */

#import "QYJobViewController.h"
#import "Common.h"
#import "UIView+ZYFrame.h"
#import "QYjobTableViewCell.h"
#import "newJobNameViewController.h"
#import "MHActionSheet.h"
#import "newJobNatureViewController.h"
#import "newJobClassViewController.h"
#import "newJobNumberViewController.h"
#import "newJobStudyViewController.h"
#import "newJobExpViewController.h"
#import "newJobWagesViewController.h"
#import "newJobWriteViewController.h"
#import "newJobTagViewController.h"
#import "newJobAddressViewController.h"
#import "newJobDateViewController.h"
#import "newJobAcceptViewController.h"
#import "newJobToppppViewController.h"
#import "newJobReplyViewController.h"
#import "newJobPlaceViewController.h"
#import "newJobPhoneViewController.h"



@interface QYJobViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

// 表尾view
@property (nonatomic, strong) UIView *BWview;

// 名字array
@property (nonatomic, strong) NSArray *nameArray;


/**
 *  4.18新增 全局cell
 */
@property (nonatomic, strong) QYjobTableViewCell *cell;

@end



@implementation QYJobViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 4.15 新增 title
    self.title = @"发布新职位";
    
    self.nameArray = @[@"职位性质", @"职位名称", @"职位类别", @"招聘人数", @"学历要求", @"经验要求", @"职位月薪", @"职位描述", @"亮点标签", @"职位发布地点", @"发布截止日期", @"简历接收设置", @"高级发布设置", @"职位申请回复", @"工作地址", @"联系方式"];
    
    
    [self addUIView];
    [self addSubView];
}

- (void)addUIView
{
    // 表尾view
    self.BWview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, 150)];
    self.BWview.backgroundColor = [UIColor whiteColor];
    
    // 预览职位按钮
    UIButton *ylButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    ylButton.frame = CGRectMake(23, 30, 158, 44);
    ylButton.x = 23;
    ylButton.y = 30;
    ylButton.width = (screenW - 23 - 23 - 15) / 2;
    ylButton.height = 44;
    
    [ylButton setTitle:@"预览职位" forState:0];
    ylButton.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:18.0];
    [ylButton.layer setCornerRadius:5.0];
    [ylButton setTintColor:[UIColor whiteColor]];
    [ylButton addTarget:self action:@selector(actionYLbutton:) forControlEvents:(UIControlEventTouchUpInside)];
    ylButton.backgroundColor = zyMainColor;
    [self.BWview addSubview:ylButton];
    
    // 保存为未发布按钮
    UIButton *bcButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    bcButton.frame = CGRectMake(screenW - 23 - 158, 30, 158, 44);
    bcButton.x = CGRectGetMaxX(ylButton.frame) + 15;
    bcButton.y = ylButton.y;
    bcButton.width = ylButton.width;
    bcButton.height = ylButton.height;
    
    [bcButton setTitle:@"保存为未发布" forState:0];
    bcButton.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:18.0];
    [bcButton.layer setCornerRadius:5.0];
    [bcButton setTintColor:[UIColor whiteColor]];
    [bcButton addTarget:self action:@selector(actionBCbutton:) forControlEvents:(UIControlEventTouchUpInside)];
    bcButton.backgroundColor = zyMainColor;
    [self.BWview addSubview:bcButton];
}

- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.tableView.tableFooterView = self.BWview;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
}

// 预览button的点击实现
- (void)actionYLbutton:(UIButton *)btn
{
    NSLog(@"预览");
}

// 保存为未发布button的点击实现
- (void)actionBCbutton:(UIButton *)btn
{
    NSLog(@"保存为未发布");
}

// cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameArray.count;
}

/**
 *  cell高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    newJobNameViewController *jobName = [[newJobNameViewController alloc] init];
    static NSString *identifier = @"QYjobVC";
    _cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_cell == nil) {
        _cell = [[QYjobTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }

    _cell.nameLable.textColor = Color(138, 138, 138);
    _cell.nameLable.text = self.nameArray[indexPath.row];
    _cell.imageV.image = [UIImage imageNamed:@"find_go"];
    return _cell;
}

/**
 *  cell点击方法
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        newJobNatureViewController *newJobNatureVC = [[newJobNatureViewController alloc] init];
        [self.navigationController pushViewController:newJobNatureVC animated:YES];
        
    } else if (indexPath.row == 1) {
        newJobNameViewController *jobName = [[newJobNameViewController alloc] init];
        [self.navigationController pushViewController:jobName animated:YES];
    } else if (indexPath.row == 2) {
        newJobClassViewController *newJobClass = [[newJobClassViewController alloc] init];
        [self.navigationController pushViewController:newJobClass animated:YES];
    } else if (indexPath.row == 3) {
        newJobNumberViewController *newJobNumber = [[newJobNumberViewController alloc] init];
        [self.navigationController pushViewController:newJobNumber animated:YES];
    } else if (indexPath.row == 4) {
        newJobStudyViewController *newJobStudy = [[newJobStudyViewController alloc] init];
        [self.navigationController pushViewController:newJobStudy animated:YES];
    } else if (indexPath.row == 5) {
        newJobExpViewController *newJobExp = [[newJobExpViewController alloc] init];
        [self.navigationController pushViewController:newJobExp animated:YES];
    } else if (indexPath.row == 6) {
        newJobWagesViewController *newJobWages = [[newJobWagesViewController alloc] init];
        [self.navigationController pushViewController:newJobWages animated:YES];
    } else if (indexPath.row == 7) {
        newJobWriteViewController *newJobWrite = [[newJobWriteViewController alloc] init];
        [self.navigationController pushViewController:newJobWrite animated:YES];
    } else if (indexPath.row == 8) {
        newJobTagViewController *newJobTag = [[newJobTagViewController alloc] init];
        [self.navigationController pushViewController:newJobTag animated:YES];
    } else if (indexPath.row == 9) {
        newJobAddressViewController *newJobAddress = [[newJobAddressViewController alloc] init];
        [self.navigationController pushViewController:newJobAddress animated:YES];
    } else if (indexPath.row == 10) {
        newJobDateViewController *newJobDate = [[newJobDateViewController alloc] init];
        [self.navigationController pushViewController:newJobDate animated:YES];
    } else if (indexPath.row == 11) {
        newJobAcceptViewController *newJobAccept = [[newJobAcceptViewController alloc] init];
        [self.navigationController pushViewController:newJobAccept animated:YES];
    } else if (indexPath.row == 12) {
        newJobToppppViewController *newJobTop = [[newJobToppppViewController alloc] init];
        [self.navigationController pushViewController:newJobTop animated:YES];
    } else if (indexPath.row == 13) {
        newJobReplyViewController *newJobReply = [[newJobReplyViewController alloc] init];
        [self.navigationController pushViewController:newJobReply animated:YES];
    } else if (indexPath.row == 14) {
        newJobPlaceViewController *newJobPlace = [[newJobPlaceViewController alloc] init];
        [self.navigationController pushViewController:newJobPlace animated:YES];
    } else if (indexPath.row == 15) {
        newJobPhoneViewController *newJobPhone = [[newJobPhoneViewController alloc] init];
        [self.navigationController pushViewController:newJobPhone animated:YES];
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
