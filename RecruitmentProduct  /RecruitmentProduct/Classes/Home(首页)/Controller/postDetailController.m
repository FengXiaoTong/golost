//
//  postDetailController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/15.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//


/**
 *  ！！！！！！！！！！！！！！！！！职位详情页！！！！！！！！！！！！！！！！！！！！
 */


#import "postDetailController.h"
#import "postDetailHeaderView.h"
#import "homeTableViewCell.h"
#import "Common.h"
#import "UIView+ZYFrame.h"

@interface postDetailController ()<postDetailBtnToCompanyDelegate>

@end

@implementation postDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.title = @"职位详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   postDetailHeaderView *PDHeaderView = [postDetailHeaderView setUpPostDetailHeaderView];
    PDHeaderView.companyDelegate =self;
    self.tableView.tableHeaderView = PDHeaderView;
    self.tableView.rowHeight = 89;
}

-(void)clickBigButtonToCompany:(UIView *)view{
    MYLog(@"进入公司详情");
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    homeTableViewCell *homeTVCell =[homeTableViewCell cellWithTableView:tableView];
    
    return homeTVCell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW,  40)];
//    sectionView.backgroundColor = zyMainColor;
    UIView *downView = [[UIView alloc] init];
    downView.x = 0;
    downView.y = 0;
    downView.width = screenW;
    downView.height = 30;
    downView.backgroundColor = zyMainColor;
    
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"相似职位";
    lab.textColor = [UIColor whiteColor];
    [lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    lab.backgroundColor = zyMainColor;
    [lab sizeToFit];
    lab.x = (screenW - lab.width)/2;
    lab.y = (downView.height - lab.height)/2;
    
    UIImageView *lineImageV1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_tuijian_line"]];
    lineImageV1.height = 1;
    lineImageV1.y = (downView.height - lineImageV1.height)/2;
    lineImageV1.width = 80;
    lineImageV1.x = lab.x - 20 - lineImageV1.width;
    [downView addSubview:lineImageV1];
    
    UIImageView *lineImageV2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_tuijian_line"]];
    lineImageV2.height = lineImageV1.height;
    lineImageV2.width = lineImageV1.width;
    lineImageV2.x = CGRectGetMaxX(lab.frame) + 20;
    lineImageV2.y = (downView.height - lineImageV1.height)/2;
    [downView addSubview:lineImageV2];
    [downView addSubview:lab];
    return downView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 31;
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
