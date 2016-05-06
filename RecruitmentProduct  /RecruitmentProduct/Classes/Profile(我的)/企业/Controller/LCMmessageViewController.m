//
//  LCMmessageViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/27.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMmessageViewController.h"
#import "LCMmessageTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "zyzpHttpTool.h"
#import "Common.h"
#import "Account.h"


#define IP @"http://192.168.100.67/zyzpPhone/"

#define MESSAGEURL @"selectPhoneMessageByReceiveId.htm"

#define DELETEMESSAGEURL @"deletePhoneMessage.htm"

@interface LCMmessageViewController ()<UITableViewDelegate,UITableViewDataSource> {

    NSMutableArray *_dataArray;
    UITableView *_messageView;
    NSMutableArray *_selectedIndexPaths;
    UIButton *_allDelete;
    UIButton *_generationsbutton;
    UIView *_view;
    NSMutableArray *_internetArray;
    
}

@end

@implementation LCMmessageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    _selectedIndexPaths = [NSMutableArray array];
    _internetArray = [NSMutableArray array];
    [self loadDataFromNet:YES];
    [self createTableView];
    
     if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    [self createBarButtonItem];
}

- (void)createBarButtonItem {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonHandle:)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)rightButtonHandle:(UIBarButtonItem *)item {
    if (_messageView.isEditing) {
        item.title = @"编辑";
        [self deleteMessage:_internetArray];
        [_view removeFromSuperview];
        [_messageView setEditing:NO animated:YES];
    }else {
        [self createButton];
        [_selectedIndexPaths removeAllObjects];
        item.title = @"完成";
        [_messageView setEditing:YES animated:YES];
    }
}

- (void)createButton {
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, screenH - 104 , screenW, 40)];
    _view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_view];

    
    _allDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    _allDelete.frame = CGRectMake(screenW/2 - 30 - (screenW/2 - 60), /*screenH - 40 - 64*/0, screenW/2 - 60, 40);
    _allDelete.backgroundColor = [UIColor blueColor];
    [_allDelete setTitle:@"全选" forState:UIControlStateNormal];
    _allDelete.tintColor = [UIColor whiteColor];
    _allDelete.layer.cornerRadius = 10;
    [_allDelete addTarget:self action:@selector(allDeleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:_allDelete];

    _generationsbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _generationsbutton.frame = CGRectMake(screenW/2 + 30,  /*screenH - 40 - 64*/0, screenW/2 - 60, 40);
    _generationsbutton.backgroundColor = [UIColor redColor];
    [_generationsbutton setTitle:@"删除" forState:UIControlStateNormal];
    _generationsbutton.tintColor = [UIColor whiteColor];
    _generationsbutton.layer.cornerRadius = 10;
    [_generationsbutton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:_generationsbutton];
    

}

//从页面删除
-(void)buttonAction:(UIButton *)button {

    //排序
    NSArray *array = [_selectedIndexPaths sortedArrayUsingSelector:@selector(compare:)];
    //然后倒序删除(后面的不会影响前面元素的顺序)
    for (NSInteger i = array.count-1; i >= 0; i--) {
        NSIndexPath *index = array[i];
        [_dataArray removeObjectAtIndex:index.row];
    }
    
    [_messageView deleteRowsAtIndexPaths:_selectedIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [_messageView reloadData];
  
    [_selectedIndexPaths removeAllObjects];
    
   
}

//从服务器删除数据
- (void)deleteMessage:(NSMutableArray *)array {
    
    
    MYLog(@"%@",array[0]);
    

    NSString *URLString = [baseUrl stringByAppendingString:DELETEMESSAGEURL];
    
    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
    
    
    for (NSString *string in array) {
        [requestParams setValue:string forKey:@"messageIds"];
    }
    
    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        
        [_internetArray removeAllObjects];
        [_messageView.mj_header beginRefreshing];

    } failure:^(NSError *error) {
    
    }];
    
}


//全选
- (void)allDeleteClick:(UIButton *)button {

    NSString *str = [button.currentTitle isEqualToString:@"全选"]?@"取消":@"全选";
    [button setTitle:str forState:UIControlStateNormal];
    
    [_selectedIndexPaths removeAllObjects];
    [_internetArray removeAllObjects];
    for (NSInteger i = 0; i < _dataArray.count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        if ([button.currentTitle isEqualToString:@"全选"]) {
            [_messageView deselectRowAtIndexPath:indexPath animated:YES];
        } else {
            LCMmessageModel *model = _dataArray[indexPath.row];
            [_internetArray addObject:model.messageId];
            [_messageView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [_selectedIndexPaths addObject:indexPath];
            
        }
        
    }
    
}





- (void)createTableView {
    
    _messageView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH - 40)];
    _messageView.delegate = self;
    _messageView.dataSource = self;
    _messageView.allowsSelectionDuringEditing = YES;
    [self.view addSubview:_messageView];
    [self refreshData];

}

- (void)refreshData {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    _messageView.mj_header = header;
    /*
     MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
     [self loadDataFromNet:YES];
     }];
     self.tableView.mj_footer = footer;
     */
    [_messageView.mj_header beginRefreshing];
    
}

- (void)loadDataFromNet:(BOOL)isMore {
    
    NSString *URLString = [baseUrl stringByAppendingString:MESSAGEURL];
    
    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
    [requestParams setValue:@"535662D0416911E5A076F8F061532E9D" forKey:@"companyId"];
    
//    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
//    [requestParams setValue:@"64D2FE800B7411E6BE80B3FAC72EF2F6" forKey:@"companyId"];
    
    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        
        if (!isMore) {
            [_dataArray removeAllObjects];
        }
    
        NSArray *array = responseObject[@"messageList"];
        for (NSDictionary *dic in array) {
            LCMmessageModel *model = [[LCMmessageModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
            
        }
        [_messageView reloadData];
        
        isMore?[_messageView.mj_footer endRefreshing]:[_messageView.mj_header endRefreshing];
         
    } failure:^(NSError *error) {
        MYLog(@"%@",[error description]);
        isMore?[_messageView.mj_footer endRefreshing]:[_messageView.mj_header endRefreshing];
    }];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //相或之后，会是多选样式
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //将选中的行的indexPath保存到数组中
    LCMmessageModel *model = _dataArray[indexPath.row];
    [_internetArray addObject:model.messageId];
    [_selectedIndexPaths addObject:indexPath];

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    //当取消选中时，应该将已保存到数组中的对象删除
    LCMmessageModel *model = _dataArray[indexPath.row];
    [_internetArray removeObject:model.messageId];
    [_selectedIndexPaths removeObject:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    MYLog(@"%ld",_dataArray.count);
    
    return _dataArray.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    static NSString *identifier = @"identifier";
    LCMmessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[LCMmessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

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



