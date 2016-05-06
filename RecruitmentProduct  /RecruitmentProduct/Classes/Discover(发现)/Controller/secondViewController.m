//
//  secondViewController.m
//  RecruitmentProduct
//
//  Created by andorid on 16/3/31.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  首页--招聘会

#import "secondViewController.h"
#import "secondTableViewCell.h"
#import "secondVC.h"
#import "ViewController.h"
#import "zyzpHttpTool.h"
#import "Common.h"
#import "AFNetworking.h"
#import "secondModel.h"


@interface secondViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;



@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 4.15 新增 title
    self.title = @"招聘会";
    self.view.backgroundColor = [UIColor orangeColor];
    [self addRightBarButton];
    [self addSubView];
    [self getDataFromNet];
}

-(void)getDataFromNet{
    
    NSString *str = [baseUrl stringByAppendingPathComponent:@"selectHomeRecruitmentListPhone.htm" ];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary]
    ;
    self.dataArray = [NSMutableArray array];
    parameters[@"locationName"] = @"郑州";
    
    [zyzpHttpTool GET:str parameters:parameters progress:^{
        
    } success:^(id responseObject) {
        MYLog(@"%@",responseObject);
        NSArray *dict = responseObject[0];
        
//        NSLog(@"%@", dict);
        NSDictionary *arr = dict[0];
//        NSLog(@"%@", arr);
//        for (NSDictionary *dic in arr) {
            // 创建model
            
            secondModel *model = [[secondModel alloc] init];
            [model setValuesForKeysWithDictionary:arr];
            // 保存到自己的数组中
            [self.dataArray addObject:model];
        [self.tableView reloadData];
        
//        }
 
    } failure:^(NSError *error) {
        MYLog(@"%@",error);
    }];
    
    
    
    
    
}



// 添加右边barButton
- (void)addRightBarButton
{
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemReply) target:self action:@selector(actionRightButton:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}


// cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
// cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *identifier = @"identifier";
    secondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[secondTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
//        cell.backgroundColor = [UIColor purpleColor];
    }
    secondModel *model = self.dataArray[indexPath.row];
    cell.nameLabel.font = [UIFont systemFontOfSize:15.0];
    
    
    cell.addressLabel.font = [UIFont systemFontOfSize:11.0];
    
    
    
    cell.dateLabel.font = [UIFont systemFontOfSize:11.0];
    
    cell.classLabel.font = [UIFont systemFontOfSize:11.0];
    
    
    cell.nameLabel.text = model.organizersName;
    cell.addressLabel.text = model.address;
    cell.classLabel.text = model.property;
    cell.dateLabel.text = model.createTime;
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)model.applyCount];
    
    self.recruitmentId = model.recruitmentId;
    

    return cell;
}

// cell的点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    secondVC *second = [[secondVC alloc] init];
    second.Id = self.recruitmentId;
    [self.navigationController pushViewController:second animated:YES];
}

// 右边barButton的点击方法
- (void)actionRightButton:(UIButton *)button
{
    ViewController *mapVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:mapVC animated:YES];
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
