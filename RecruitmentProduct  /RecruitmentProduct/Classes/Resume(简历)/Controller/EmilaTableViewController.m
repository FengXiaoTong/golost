//
//  EmilaTableViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/21.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//   企业简历夹页面

#import "EmilaTableViewController.h"
#import "Common.h"

@interface EmilaTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISegmentedControl *segControl;  //条件索引
@property (nonatomic, strong)NSArray *datas;   //所有数据
@end

@implementation EmilaTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 60)];
    header .backgroundColor = [UIColor whiteColor];
    [tableView addSubview:header];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"待处理",@"待沟通",@"已发送邀请",@"不合适", nil];
    _segControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    _segControl.frame = CGRectMake(30, 10, screenW-60, 40) ;
    [_segControl addTarget:self action:@selector(choose:) forControlEvents:UIControlEventValueChanged];
    _segControl.selectedSegmentIndex = 0;
    [header addSubview:_segControl];
    return header;
}



-(void)choose:(UISegmentedControl *)segment
{
//    NSInteger index = segment.selectedSegmentIndex;
//    switch (index) {
//        case 0:
//            [self.tableView reloadData];
//            break;
//        case 1:
//            [self.tableView reloadData];
//            break;
//        case 2:
//            [self.tableView reloadData];
//            break;
//        case 3:
//            [self.tableView reloadData];
//            break;
//        default:
//            break;
//    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier  = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 80, 80)];
        iconView.image = [UIImage imageNamed:@"profile_icon"];
        [cell.contentView addSubview:iconView];
        
        UILabel *resumeLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 120, 20)];
        resumeLabel.text = @"工程师";
        [cell.contentView addSubview:resumeLabel];
        
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(300, 5, 60, 20)];
        dateLabel.text = @"02-22";
        [cell.contentView addSubview:dateLabel];
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 30, 60, 20)];
        nameLabel.text = @"Mr/Mrs";
        [cell.contentView addSubview:nameLabel];
        
        UILabel *ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 30, 40, 20)];
        ageLabel.text = @"22";
        [cell.contentView addSubview:ageLabel];
        
        UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 55, 120, 20)];
        addressLabel.text = @"上海/本科/2年";
        [cell.contentView addSubview:addressLabel];
        
        UILabel *detailStringLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 80, screenW - 100, 20)];
        detailStringLabel.text = @"随便的数据我的和哦啊大家快来打进来撒打算几点就偶是大神就开了加快了加快了就是大即可拉伸";
        [cell.contentView addSubview:detailStringLabel];
        
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    
    }   
}


-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"保存到人才储备" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"1");
    }];
    
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"移动到简历夹" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"2");
        
    }];
    
    UITableViewRowAction *thirRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"通知信" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"3");
    }];
    deleteRowAction.backgroundColor = [UIColor orangeColor];
    editRowAction.backgroundColor = [UIColor greenColor];
    thirRowAction.backgroundColor = [UIColor blueColor];
    return @[deleteRowAction, editRowAction,thirRowAction];
}

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
