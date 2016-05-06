//
//  searchResultController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/11.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "searchResultController.h"
#import "detailSearchBar.h"
#import "homeTableViewCell.h"
#import "detailResultController.h"
#import "Common.h"

@interface searchResultController ()<detailSearchBarDelegate,UITextFieldDelegate>
@property (nonatomic, strong) detailSearchBar *searchBar;
@property (nonatomic, strong) UIView *clearView;
@end

@implementation searchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSearchBar];
    self.tableView.rowHeight = 100;
    // 监听键盘弹出通知~
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addClearView) name:UIKeyboardDidShowNotification object:nil];
    
}

- (void)setUpSearchBar {
    detailSearchBar *searchBar = [detailSearchBar searchBarWithFrame:CGRectMake(0, 0, screenW - 110, 35)];
    searchBar.delegate =self;
    searchBar.placeholder = @"搜索公司/职位";
    searchBar.myDelegate = self;
    self.navigationItem.titleView = searchBar;
    _searchBar = searchBar;

}

-(void)addClearView{
    UIView *clearView = [[UIView alloc] initWithFrame:self.view.frame];
    clearView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:clearView];
    
    UITapGestureRecognizer *gestureR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeboard)];
    
    [clearView addGestureRecognizer:gestureR];
    _clearView = clearView;

}


// 收searchBar键盘
-(void)hideKeboard{

    [_searchBar resignFirstResponder];
    [_clearView removeFromSuperview];
   
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    homeTableViewCell *cell = [homeTableViewCell cellWithTableView:tableView];
    
    return cell;
}

#pragma mark - Table View delegat
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MYLog(@"cell");
 
    [self.navigationController pushViewController:[detailResultController new] animated:YES];
  
}
// 拖动收键盘
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
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
