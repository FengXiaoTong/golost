//
//  secondVC.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/1.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  招聘会详细页面

#import "secondVC.h"
#import "GRseconfd.h"
#import "zyzpHttpTool.h"
#import "Common.h"
#import "secondViewController.h"
#import "secondXQModel.h"


@interface secondVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;



@end

@implementation secondVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"招聘会详情";
    [self getDataForNet];
    [self giveData];
    [self addSubView];
}

- (void)getDataForNet
{
    
    NSString *str = [baseUrl stringByAppendingPathComponent:@"selectRecruitmentMessagePhone.htm" ];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"recruitmentId"] = self.Id;
    MYLog(@",,,,,,,,,,,,,,,,,,%@", self.Id);
    [zyzpHttpTool GET:str parameters:parameters progress:^{
        
    } success:^(id responseObject) {
        
//        MYLog(@"%@", responseObject);
        NSDictionary *dic = responseObject[@"recruitmentDTO"];
//        MYLog(@"%@", dic);
        self.dataArray = [NSMutableArray array];
        
        secondXQModel *model = [[secondXQModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
//        MYLog(@"%@", model);
        
        // 重写set方法
//        GRseconfd *view = [[GRseconfd alloc] init];
//        view.model = model;
        
        NSMutableDictionary *dict =[NSMutableDictionary dictionary];
        dict[@"model"] = model;
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"headerModel" object:dict];
        
        
        
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)giveData
{
    
}

- (void)addSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = [[GRseconfd alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"publishVC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    return cell;
    
    // Configure the cell...
    
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
