//
//  LCMinformatioViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/2.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMinformatioViewController.h"
#import "ZPFprivateLetterModel.h"
#import "ZPFprivateLetterTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "zyzpHttpTool.h"


#import "ZPFsingleChatViewController.h"

#define URL @"http://192.168.100.20:8081/zyjyPhone/"

#define MEMBERID @"F2E5A8C0940611E5A8C0B8F8EF0015CF"

#define PRIVATE_LETTER @"selectPhonePrivateletter.htm"





//#define sdsd @"http://192.168.100.20:8081/zyjyPhone/selectPhonePrivateletter.htm?memberId=F2E5A8C0940611E5A8C0B8F8EF0015CF"


@interface LCMinformatioViewController ()<UITableViewDelegate,UITableViewDataSource> {

    UITableView *_privateLetterTV;
    NSMutableArray *_privateArr;
    
    UIButton *_button;
}


@end

@implementation LCMinformatioViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonAction:(UIButton *)button {
    [super buttonAction:button];
    if ([_button isEqual:button]) {
        return;
    }
    if (button.tag == 100) {
        if (!_privateLetterTV) {
            _privateArr = [NSMutableArray array];
           [self createTableView]; 
        }
    }else if (button.tag == 101) {
    
    }else if (button.tag == 102) {
    
    }else if (button.tag == 103) {
    
    }
    _button = button;
}
- (void)createTableView {
    
    _privateLetterTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, VIEW_HEIGHT)];
    _privateLetterTV.delegate = self;
    _privateLetterTV.dataSource = self;
    [self.scrollView addSubview:_privateLetterTV];
    _privateLetterTV.showsVerticalScrollIndicator = NO;

    [self refreshData];
}
- (void)refreshData {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    _privateLetterTV.mj_header = header;
    
    /*    MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
    //        [self loadDataFromNet:YES];
    //    }];
    //    self.tableView.mj_footer = footer;*/
    [_privateLetterTV.mj_header beginRefreshing];
    
}

- (void)loadDataFromNet:(BOOL)isMore {
    
    
/*//    NSString *URLString = [baseUrl stringByAppendingString:URLSTRING];
    
//    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
    
//    if (_viewState.length) {
//        [requestParams setValue:_viewState forKey:@"viewState"];
//    }
    */
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",URL,PRIVATE_LETTER];
    
    NSDictionary *parameters = @{@"memberId":MEMBERID};
    
    [zyzpHttpTool GET:urlString parameters:parameters progress:^{
        
    } success:^(id responseObject) {
        
        if (!isMore) {
            [_privateArr removeAllObjects];
        }

        NSArray *array = responseObject[@"privateletterList"];
        for (NSDictionary *dic in array[0]) {
            ZPFprivateLetterModel *model = [[ZPFprivateLetterModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_privateArr addObject:model];
        }
        
        
        [_privateLetterTV reloadData];
        
        isMore?[_privateLetterTV.mj_footer endRefreshing]:[_privateLetterTV.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        isMore?[_privateLetterTV.mj_footer endRefreshing]:[_privateLetterTV.mj_header endRefreshing];
    }];
    
    
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _privateArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 120;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"identifier";
    ZPFprivateLetterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZPFprivateLetterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell privateLetterSetModel:_privateArr[indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ZPFsingleChatViewController *chatVC = [[ZPFsingleChatViewController alloc] init];
   
    ZPFprivateLetterModel *model = _privateArr[indexPath.row];
    chatVC.memberId = model.memberId;
    chatVC.dialogueId = model.dialogueId;
    
    [self.navigationController pushViewController:chatVC animated:YES];

}

@end
