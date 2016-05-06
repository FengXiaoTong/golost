//
//  SetupUITableView.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/13.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "SetupViewController.h"
#import "Common.h"
#import "UIView+ZYFrame.h"
#import "ChangeViewController.h"
#import "MoreViewController.h"
#import "SwitchViewController.h"
#import "zyzpNavigationController.h"
#import "LoginViewController.h"
#import "Account.h"
@interface SetupViewController ()

@property(nonatomic, strong) NSArray *titleArr;

@end

@implementation SetupViewController

-(NSArray *)titleArr{
    if (_titleArr == nil) {
        
        _titleArr = @[@"修改密码",@"更多内容",@"版本切换                                       找人才"];
    }
    return _titleArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"设置";
    self.navigationController.navigationBar.hidden = NO;
    self.tableView.sectionFooterHeight = 100;
    self.tableView.tableFooterView = [self createFooterView];
}

-(UIView *)createFooterView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 20, screenW - 40, 40)];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, screenW - 40, 40);
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}

-(void)buttonAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定退出登录？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [[Account currentAccount] logout];


    }];
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ChangeViewController *ChangeVC = [[ChangeViewController alloc] init];
        [self.navigationController pushViewController:ChangeVC animated:YES];
    }else if (indexPath.row == 1) {
        MoreViewController *moreVC = [[MoreViewController alloc] init];
        [self.navigationController pushViewController:moreVC animated:YES];
    }else if (indexPath.row == 2){
        SwitchViewController  *swiVC = [[SwitchViewController alloc] init];
        [self.navigationController pushViewController:swiVC animated:YES];
    }
}

        



        




@end

