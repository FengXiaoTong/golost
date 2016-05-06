//
//  findEnterpController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/14.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "findEnterpController.h"
#import "homeTableHeaderView.h"
#import "findEnterpTableViewCell.h"
#import "Common.h"

@interface findEnterpController ()
@property (nonatomic, strong) homeTableHeaderView *homeTabelHView;
@end

@implementation findEnterpController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillScroolViewImageDate];
   
    
    
}
-(void)fillScroolViewImageDate{
    self.title = @"行业名企";
    NSArray *arr = @[@"home-banner",@"home-banner",@"home-banner"];
    homeTableHeaderView *homeTabelHView = [homeTableHeaderView scrollViewImagesName:arr];
    self.tableView.tableHeaderView = homeTabelHView;
    homeTabelHView.scrollView.delegate = self;
    _homeTabelHView = homeTabelHView;
    self.tableView.rowHeight = 89;
    self.tableView.separatorStyle = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double page = scrollView.contentOffset.x/screenW;
    
    _homeTabelHView.pageControl.currentPage = (int)(page + 0.5);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    findEnterpTableViewCell *cell = [findEnterpTableViewCell cellWithTableView:tableView];
    
    return cell;
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
