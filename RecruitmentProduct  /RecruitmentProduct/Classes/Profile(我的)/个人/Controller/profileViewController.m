//
//  profileViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/3/29.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "profileViewController.h"
#import "ZPFprofileModel.h"
#import "ZPFprofileTableViewCell.h"
#import "Account.h"
#import <UIImageView+WebCache.h>

#import "Common.h"
#import "UIView+ZYFrame.h"

#import "DeliverydetailsViewController.h"
#import "HrViewController.h"
#import "collectionViewController.h"
#import "focusViewController.h"
#import "lookViewController.h"
#import "refersViewController.h"
#import "SetupViewController.h"
#import "LoginViewController.h"
#import "zyzpNavigationController.h"
#import "PersonalViewController.h"
#import "ZPFcompanyDetailsController.h"
#import "LCMcompanyMYViewController.h"

//企业
#import "LCMpurchaseRecordsViewController.h"
#import "LCMpositionViewController.h"
#import "LCMoperationViewController.h"
#import "LCMmessageViewController.h"
#import "LCMcompanyMYViewController.h"
#import "LCMauditViewController.h"
#import "LCMprepaidViewController.h"




@interface profileViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation profileViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.bounces = NO;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(clickSet)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.tableView.tableHeaderView = [self setUpSectionHeaderView];
}




#pragma mark -- 点击设置
-(void)clickSet
{
    if (![[Account currentAccount] isLogin]) {
        [self loginToRemind];
    }
    SetupViewController * set = [[SetupViewController alloc]init];
    [self.navigationController pushViewController:set  animated:YES];

}
//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }else {
        [_dataSource removeAllObjects];
    }
    NSArray *titleArr;
    NSArray *imageNameArr;
    if ([[Account currentAccount] isCompany]) { 
        titleArr = @[@"我的购买记录",@"职位发布统计",@"操作日志",@"消息中心",@"修改公司设置",@"审核状态",@"我的指慧豆"];
        imageNameArr = @[@"goumaijilu",@"rate",@"contacts",@"feedback",@"my_settings",@"gallery",@"bean"];
    } else {
        titleArr = @[@"我的申请记录",@"人事来信",@"我的收藏",@"关注公司",@"谁看了我",@"指慧豆"];
        imageNameArr = @[@"shenqingjilu",@"letter",@"star",@"attention",@"eye",@"bean"];
    }

    for (int i = 0; i < titleArr.count; i++) {
        ZPFprofileModel *model = [[ZPFprofileModel alloc] init];
        model.iconName = imageNameArr[i];
        model.title = titleArr[i];
        model.indicatorName = @"gogo";
        [_dataSource addObject:model];
    }
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    ZPFprofileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[ZPFprofileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = _dataSource[indexPath.row];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (![[Account currentAccount] isLogin]) {
        [self loginToRemind];
    }
    
   
    if (indexPath.row == 0) {
        if ([[Account currentAccount] isCompany]) {
            LCMpurchaseRecordsViewController *recordsVC  = [[LCMpurchaseRecordsViewController alloc] init];
            [self.navigationController pushViewController:recordsVC animated:YES];
        } else {
            DeliverydetailsViewController *deliveryVC = [[DeliverydetailsViewController alloc] init];
            [self.navigationController pushViewController:deliveryVC animated:YES];
        }
       
    }else if (indexPath.row == 1) {
        if ([[Account currentAccount] isCompany]) {
            LCMpositionViewController *positionVC = [[LCMpositionViewController alloc] init];
            [self.navigationController pushViewController:positionVC animated:YES];
        } else {
            HrViewController *hrVC = [[HrViewController alloc] init];
            [self.navigationController pushViewController:hrVC animated:YES];
        }
       
    }else if (indexPath.row == 2) {
        if ([[Account currentAccount] isCompany]) {
            LCMoperationViewController  *operationVC = [[LCMoperationViewController alloc] init];
            [self.navigationController pushViewController:operationVC animated:YES];

        } else {
            collectionViewController  *collerctionVC = [[collectionViewController alloc] init];
            [self.navigationController pushViewController:collerctionVC animated:YES];
        }
        
    }else if (indexPath.row == 3) {
        if ([[Account currentAccount] isCompany]) {
            LCMmessageViewController *messageVC = [[LCMmessageViewController alloc] init];
            [self.navigationController pushViewController:messageVC animated:YES];

        } else {
            focusViewController *focusVC = [[focusViewController alloc] init];
            [self.navigationController pushViewController:focusVC animated:YES];
        }
    }else if (indexPath.row == 4) {
        if ([[Account currentAccount] isCompany]) {
            LCMcompanyMYViewController *comapnyVC = [[LCMcompanyMYViewController alloc] init];
            [self.navigationController pushViewController:comapnyVC animated:YES];
        } else {
            lookViewController *lookVC = [[lookViewController alloc] init];
            [self.navigationController pushViewController:lookVC animated:YES];
        }
    }else if (indexPath.row == 5) {
        if ([[Account currentAccount] isCompany]) {
            LCMauditViewController *auditVC = [[LCMauditViewController alloc] init];
            [self.navigationController pushViewController:auditVC animated:YES];
        } else {
            refersViewController *refersVC = [[refersViewController alloc] init];
            [self.navigationController pushViewController:refersVC animated:YES];
        }
    }else if (indexPath.row == 6) {
        if ([[Account currentAccount] isCompany]) {
            LCMprepaidViewController *prepaidVC = [[LCMprepaidViewController alloc] init];
            [self.navigationController pushViewController:prepaidVC animated:YES];
        }

    
    }
}



- (UIView *)setUpSectionHeaderView{
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenW/2)];

    //设置头像图标
    UIImageView *iconImageView = [[UIImageView alloc] init];
//    [iconImageView setBackgroundColor:[UIColor redColor]];

    [iconImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"moren"]];
    
    iconImageView.x = screenW/3;
    iconImageView.y = 15;
    iconImageView.width = screenW/3;
    iconImageView.height = screenW/3;
    iconImageView.layer.cornerRadius = iconImageView.width/2;
    iconImageView.clipsToBounds = YES;
    
    iconImageView.userInteractionEnabled = YES;
    [sectionView addSubview:iconImageView];

    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconBtnClick)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [iconImageView addGestureRecognizer:singleRecognizer];
    
    //显示文字lable
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"欢迎使用，点我登录";
    titleLab.font = [UIFont systemFontOfSize:15];
    [titleLab sizeToFit];
    titleLab.x =  (screenW - titleLab.width) / 2;
    titleLab.y =  iconImageView.height + iconImageView.y + 10;
    
    titleLab.textColor = [UIColor blackColor];
    [sectionView addSubview:titleLab];
    
    
    
    return sectionView;
    
}

- (void)loginToRemind{

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲爱的用户，您好！" message:@"您还未登录，请确认登录！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self iconBtnClick];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
    
    [self presentViewController:alertController animated:YES completion:nil];


}



- (void)iconBtnClick{
    
    
    //未登录状态下   跳转登录页面
    
    if (![[Account currentAccount] isLogin]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        zyzpNavigationController *nav = [[zyzpNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else {
        PersonalViewController *personal = [[PersonalViewController alloc] init];
        [self.navigationController pushViewController:personal animated:YES];
    }
    
    //登录状态下。。。。。。。
    
}




@end

