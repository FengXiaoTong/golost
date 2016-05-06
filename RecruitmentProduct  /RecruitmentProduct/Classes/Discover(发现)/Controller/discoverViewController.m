//
//  discoverViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/3/29.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  找工作--发现

#import "discoverViewController.h"
#import "Common.h"
#import "discoverTableViewCell.h"
#import "secondViewController.h"
#import "publishViewController.h"
#import "adviceViewController.h"
#import "interviewViewController.h"
#import "schoolViewController.h"
#import "companyViewController.h"
#import "QYmanageViewController.h"
#import "findEnterpController.h"




@interface discoverViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation discoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor = RandomColor;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 4.15 新增 title
    
    
    // 4.15 改动  从cell初始化里面移动到这
    self.titleArray = @[@"招聘会", @"求职指导", @"模拟面试", @"行业名企", @"校园招聘", @""];
    self.imageArray = @[@"find_meeting", @"find_zd", @"find_mnms", @"find_hymq", @"find_xyzp", @""];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}




#pragma mark - Table view data source

// 设置每个分区cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 4.15改动  具体数字改成array的长度
    return self.titleArray.count;

}

// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 4.15改动 60改成43
    return 43;
}

// cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifier = @"identifier";
    discoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[discoverTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
        // 4.15改动  小箭头方法删除
        cell.titleLabel.text = [self.titleArray objectAtIndex:indexPath.row];
        
    }
    
    cell.titleIamgeView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        secondViewController *secondVC = [[secondViewController alloc] init];
        [self.navigationController pushViewController:secondVC animated:YES];
    } else if (indexPath.row == 1) {
        adviceViewController *adviceVC = [[adviceViewController alloc] init];
        [self.navigationController pushViewController:adviceVC animated:YES];

    } else if (indexPath.row == 2) {

        interviewViewController *interviewVC = [[interviewViewController alloc] init];
        [self.navigationController pushViewController:interviewVC animated:YES];
    } else if (indexPath.row == 3) {
        // 4.20改动找名企页面
        findEnterpController *company = [[findEnterpController alloc] init];
    
        [self.navigationController pushViewController:company animated:YES];
    } else if (indexPath.row == 4) {
        schoolViewController *school = [[schoolViewController alloc] init];
        [self.navigationController pushViewController:school animated:YES];
    } else if (indexPath.row == 5) {

        QYmanageViewController *QYmanage = [[QYmanageViewController alloc] init];
        [self.navigationController pushViewController:QYmanage animated:YES];
    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
