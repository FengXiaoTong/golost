//
//  searchController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/1.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "searchController.h"
#import "detailSearchBar.h"
#import "ViewController.h"
#import "dropDownMenu.h"
#import "positionController.h"
#import "UIView+ZYFrame.h"
#import "downMenuController.h"
#import "tradeController.h"
#import "searchResultController.h"
#import "Common.h"
#import "zyzpHttpTool.h"
#import <AFNetworking.h>



#define margin 20


@interface searchController ()<UITextFieldDelegate,detailSearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITextField *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *detailArr;
@property (nonatomic, strong) UIView *clearView;
@end

@implementation searchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpHomeVCNav];
    [self setUpTableView];
    
  
}

// self.view 将要消失收键盘
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_searchBar resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_searchBar canBecomeFirstResponder];
    [_searchBar becomeFirstResponder];
}

- (void)setUpTableView{
    // 类别表
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _detailArr = @[@"行业类别",@"职位类别",@"工作地点"];
    //tableView.scrollEnabled = NO;
    tableView.separatorColor = [UIColor blackColor];
    _tableView = tableView;
    
}

-(void)setUpHomeVCNav{
    //首页搜索栏
   detailSearchBar *searchBar = [detailSearchBar searchBarWithFrame:CGRectMake(0, 0, screenW - 110, 35)];
    searchBar.delegate =self;
    searchBar.placeholder = @"搜索公司/职位";
    searchBar.myDelegate = self;
    self.navigationItem.titleView = searchBar;
    _searchBar = searchBar;
    _searchBar.delegate = self;
    [_searchBar setReturnKeyType:UIReturnKeySearch];
    [_searchBar addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - 监听搜索框内容
-(BOOL)textFieldChanged:(UITextField *)textField{
    
    
    MYLog(@"%@",_searchBar.text);
    return YES;
}

-(void)getSearchResult{
    
    NSString *baseURL = @"http://192.168.100.67/zyzpPhone/searchJob.htm";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"keyWord"] = _searchBar.text;

    [zyzpHttpTool GET:baseURL parameters:parameters progress:^{
        
    } success:^(id responseObject) {
       
    MYLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        MYLog(@"%@",error);
    }];
    
    
}




#pragma mark - detailSearchBarDelegate
-(void)detailSearchBarButtonCilck:(UIButton *)button{
   
    dropDownMenu *downMenu = [dropDownMenu menu];
    downMenuController *downMenuC =[[downMenuController alloc] init];
    downMenuC.view.height = 100;
    downMenuC.view.width  = 70;
    downMenu.contentViewController = downMenuC;
    
    [downMenu showWithFrame:button];
    
}

#pragma mark - UITextFileDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [_searchBar canBecomeFirstResponder];
    [_searchBar becomeFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _detailArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _detailArr[indexPath.row];
    
    return cell;
    
    }

#pragma mark - UITableViewDelegate
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"";
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *searchView = [[UIView alloc] init];
        
        searchView.width = screenW;
        searchView.height = 100;
        searchView.x = 0;
        searchView.y = 0;
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.x = screenW/4;
        btn.y = margin;
        btn.width = screenW/2;
        btn.height = 50;
        btn.layer.cornerRadius = btn.height/2;
        btn.clipsToBounds = YES;
        [btn setTitle:@"搜索" forState:UIControlStateNormal];
        [btn setBackgroundColor:zyMainColor];
        [btn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [searchView addSubview:btn];
        
        return searchView;
    }
    return nil;
   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            MYLog(@"行业类别");
            [self.navigationController pushViewController:[tradeController new] animated:YES];
            break;
        case 1:
            MYLog(@"职位类别");
//            [self.navigationController pushViewController:[QYContactsTableViewController new] animated:YES];
        case 2:
            MYLog(@"工作地点");
            
        default:
            break;
    }
    
}


-(void)searchBtnClick{
    [_searchBar resignFirstResponder];
    [self.navigationController pushViewController:[searchResultController new] animated:YES];
}
@end
