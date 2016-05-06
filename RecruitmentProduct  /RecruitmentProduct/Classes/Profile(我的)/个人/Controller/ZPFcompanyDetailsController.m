//
//  ZPFcompanyDetailsController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/23.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ZPFcompanyDetailsController.h"
#import <MJRefresh/MJRefresh.h>
#import "Common.h"
#import "UIView+ZYFrame.h"
#import <UIImageView+WebCache.h>
#import "Account.h"
#import "zyzpHttpTool.h"
#import "ZPFcompanyDetailsModel.h"
#import "ZPFLableOperation.h"
#import "ZPFcompanyDetailsCell.h"
#import "BaiDuMapViewController.h"

#define NAME_FONT 15
#define COMPANYURL_FONT 12
#define DETAILS_FONT 13
#define DETAILSMESSAGE_FONT 11
#define FOOTERLABEL_FONT 16

#define URLSTRING @"selectCompanyDetailsByCompanyId.htm"

@interface ZPFcompanyDetailsController () {
    ZPFcompanyDetailsModel *_model;
    NSMutableArray *_dataArray;

    BOOL isHeadView;


}

@end

@implementation ZPFcompanyDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = [self setUpButton];
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    isHeadView = YES;
    [self refreshData];
}

//标签页名称
- (UILabel *)setUpButton {
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"公司详情" forState:UIControlStateNormal];
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, -15);
    titleBtn.frame = CGRectMake(0, 0, 80, 40);
    return titleBtn;
    
}

- (void)refreshData {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    self.tableView.mj_header = header;
    
    //    MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
    //        [self loadDataFromNet:YES];
    //    }];
    //    self.tableView.mj_footer = footer;
    [self.tableView.mj_header beginRefreshing];
    
}



- (void)loadDataFromNet:(BOOL)isMore {
    
    
    NSString *URLString = [baseUrl stringByAppendingString:URLSTRING];
    
    NSDictionary *requestParams = @{@"companyId":_companyId};
    
    
    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        
        if (!isMore) {
            [_dataArray removeAllObjects];
        }
        NSDictionary *companyDict = responseObject[@"company"];
        _model = [[ZPFcompanyDetailsModel alloc] init];
        [_model setValuesForKeysWithDictionary:companyDict];
        
        NSArray *jobListArray = responseObject[@"jobList"];
        NSArray *array = jobListArray[0];
        for (NSDictionary *dic in array) {
            JobList *model = [[JobList alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }

        if (isHeadView) {
            isHeadView = NO;
            self.tableView.tableHeaderView = [self tableViewHeadView];
        }
        [self.tableView reloadData];
        
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

-(UIView *)tableViewHeadView {
    
    UIView *headView = [[UIView alloc] init];
    
    UIImageView *iconImageV = [[UIImageView alloc] init];
    CGFloat icon_top = 11;
    CGFloat icon_left = 10;
    CGSize icon_size = CGSizeMake(56, 56);
    [iconImageV sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"moren"]];
    iconImageV.frame = CGRectMake(icon_left, icon_top, icon_size.width, icon_size.height);
    [headView addSubview:iconImageV];
    
    UILabel *companyName = [[UILabel alloc] init];
    CGFloat companyName_top = 10;
    CGFloat companyName_left = 5;
    CGFloat companyName_width_Max = screenW - companyName_left - CGRectGetMaxX(iconImageV.frame);
    companyName.textColor = Color(80, 80, 80);
    companyName.text = _model.companyName;
    companyName.font = [UIFont systemFontOfSize:NAME_FONT];
    companyName.frame = CGRectMake(CGRectGetMaxX(iconImageV.frame) + companyName_left, companyName_top, companyName_width_Max, NAME_FONT);
    [headView addSubview:companyName];
    
    UILabel *companyURL = [[UILabel alloc] init];
    CGFloat companyURL_top = 10;
    CGFloat companyURL_width_Max = screenW - companyName_left - CGRectGetMaxX(iconImageV.frame);
    companyURL.textColor = Color(110, 110, 110);
    companyURL.text = _model.companyUrl;
    companyURL.font = [UIFont systemFontOfSize:COMPANYURL_FONT];
    companyURL.frame = CGRectMake(CGRectGetMinX(companyName.frame), CGRectGetMaxY(companyName.frame) + companyURL_top, companyURL_width_Max, COMPANYURL_FONT);
    [headView addSubview:companyURL];
    
    
    
    CGFloat thirdLine_top = 5;
    CGFloat thirdLine_Y = CGRectGetMaxY(companyURL.frame) + thirdLine_top;
    CGSize blueLable_size = CGSizeMake(6, 12);
    
    UILabel *blueLable1 = [[UILabel alloc] init];
    blueLable1.backgroundColor = Color(70, 120, 220);
    blueLable1.frame = CGRectMake(CGRectGetMinX(companyURL.frame), thirdLine_Y, blueLable_size.width, blueLable_size.height);
    [headView addSubview:blueLable1];
    
    UILabel *business = [[UILabel alloc] init];
    CGFloat business_left = 6;
    CGSize business_size = [ZPFLableOperation sizeWithText:_model.industry maxSize:CGSizeMake(CGFLOAT_MAX, COMPANYURL_FONT) font:[UIFont systemFontOfSize:COMPANYURL_FONT]] ;
    business.textColor = Color(110, 110, 110);
    business.text = _model.industry;
    business.font = [UIFont systemFontOfSize:COMPANYURL_FONT];
    business.frame = CGRectMake(CGRectGetMaxX(blueLable1.frame) + business_left, thirdLine_Y, business_size.width, COMPANYURL_FONT);
    [headView addSubview:business];
    
    
    
    CGFloat blueLable2_left = 12;
    
    UILabel *blueLable2 = [[UILabel alloc] init];
    blueLable2.frame = CGRectMake(CGRectGetMaxX(business.frame) + blueLable2_left, thirdLine_Y, blueLable_size.width, blueLable_size.height);
    blueLable2.backgroundColor = Color(70, 120, 220);
    [headView addSubview:blueLable2];
    
    
    UILabel *nature = [[UILabel alloc] init];
    CGFloat nature_left = 7;
    CGSize nature_size = [ZPFLableOperation sizeWithText:_model.companyType maxSize:CGSizeMake(CGFLOAT_MAX, COMPANYURL_FONT) font:[UIFont systemFontOfSize:COMPANYURL_FONT]] ;
    nature.textColor = Color(110, 110, 110);
    nature.text = _model.companyType;
    nature.font = [UIFont systemFontOfSize:COMPANYURL_FONT];
    nature.frame = CGRectMake(CGRectGetMaxX(blueLable2.frame) + nature_left, thirdLine_Y, nature_size.width, COMPANYURL_FONT);
    [headView addSubview:nature];
    
    
    
    CGFloat blueLable3_left = 12;
    UILabel *blueLable3 = [[UILabel alloc] init];
       blueLable3.backgroundColor = Color(70, 120, 220);
    blueLable3.frame = CGRectMake(CGRectGetMaxX(nature.frame) + blueLable3_left, thirdLine_Y, blueLable_size.width, blueLable_size.height);
    [headView addSubview:blueLable3];
    
    
    UILabel *peopleNumber = [[UILabel alloc] init];
    CGFloat peopleNumber_left = 7;
    CGSize peopleNumber_size = [ZPFLableOperation sizeWithText:_model.compnayPersons maxSize:CGSizeMake(CGFLOAT_MAX, COMPANYURL_FONT) font:[UIFont systemFontOfSize:COMPANYURL_FONT]] ;
    peopleNumber.textColor = Color(110, 110, 110);
    peopleNumber.text = _model.compnayPersons;
    peopleNumber.font = [UIFont systemFontOfSize:COMPANYURL_FONT];
    peopleNumber.frame = CGRectMake(CGRectGetMaxX(blueLable3.frame) + peopleNumber_left, thirdLine_Y, peopleNumber_size.width, COMPANYURL_FONT);
    [headView addSubview:peopleNumber];
    
    
    
    
    UILabel *address = [[UILabel alloc] init];
    CGFloat address_top = 11;
    CGFloat address_left = 10;
    CGSize address_size = [ZPFLableOperation sizeWithText:@"公司地址：" maxSize:CGSizeMake(CGFLOAT_MAX, COMPANYURL_FONT) font:[UIFont systemFontOfSize:COMPANYURL_FONT]] ;
    address.textColor = Color(110, 110, 110);
    address.text = @"公司地址：";
    address.font = [UIFont systemFontOfSize:COMPANYURL_FONT];
    address.frame = CGRectMake(address_left, CGRectGetMaxY(blueLable1.frame) + address_top, address_size.width, COMPANYURL_FONT);
    [headView addSubview:address];
    
    
    UILabel *addressInfo = [[UILabel alloc] init];
    CGFloat addressInfo_right = 16;
    CGFloat addressInfo_width_Max = screenW - addressInfo_right - CGRectGetMaxX(address.frame);
    CGSize addressInfo_size = [ZPFLableOperation sizeWithText:_model.companyAddress maxSize:CGSizeMake(addressInfo_width_Max, CGFLOAT_MAX) font:[UIFont systemFontOfSize:COMPANYURL_FONT]] ;
    addressInfo.numberOfLines = 0;
    addressInfo.textColor = Color(110, 110, 110);
    addressInfo.attributedText = [ZPFLableOperation setLineSpace:6 withString:_model.companyAddress];
    addressInfo.font = [UIFont systemFontOfSize:COMPANYURL_FONT];
    addressInfo.frame = CGRectMake(CGRectGetMaxX(address.frame), CGRectGetMinY(address.frame), addressInfo_size.width, addressInfo_size.height+6);
    [headView addSubview:addressInfo];
    
    
    UILabel *mapLab = [[UILabel alloc] init];
    CGFloat map_right = 10;
    CGSize mapLab_size = CGSizeMake(48, 12);
    mapLab.font = [UIFont systemFontOfSize:COMPANYURL_FONT];
    mapLab.text = @"查看地图";
    mapLab.textColor = Color(70, 120, 220);
    mapLab.frame = CGRectMake(screenW - map_right - mapLab_size.width, CGRectGetMaxY(addressInfo.frame)/* - mapLab_size.height */, mapLab_size.width, mapLab_size.height);
    [headView addSubview:mapLab];
    
    
    UIImageView *mapView = [[UIImageView alloc] init];
    CGFloat mapView_right = 6;
    CGSize mapView_size = CGSizeMake(16, 16);
    mapView.image = [UIImage imageNamed:@"map"];
    mapView.frame = CGRectMake(CGRectGetMinX(mapLab.frame) - mapView_right - mapView_size.width, CGRectGetMinY(mapLab.frame)-3, mapView_size.width, mapView_size.height);
    [headView addSubview:mapView];
    
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat mapBT_width = CGRectGetMaxX(mapLab.frame) - CGRectGetMinX(mapView.frame);
    CGFloat mapBT_height = CGRectGetWidth(mapView.frame);
    [mapButton addTarget:self action:@selector(mapButtonAction) forControlEvents:UIControlEventTouchUpInside];
    mapButton.frame = CGRectMake(CGRectGetMinX(mapView.frame), CGRectGetMinY(mapView.frame), mapBT_width, mapBT_height);
    [headView addSubview:mapButton];
    
    
    
    
    
    
    UILabel *line = [[UILabel alloc] init];
    CGFloat line_top = 17;
    CGFloat line_left = 10;
    line.backgroundColor = Color(221, 221, 221);
    line.frame = CGRectMake(line_left, CGRectGetMaxY(addressInfo.frame) + line_top, screenW - 2*line_left, 1);
    [headView addSubview:line];
    
    
    UILabel *details = [[UILabel alloc] init];
    CGFloat details_top = 15;
    CGFloat details_left = 10;
    CGSize details_size = CGSizeMake(52, 13);
    details.text = @"公司详情";
    details.font = [UIFont systemFontOfSize:DETAILS_FONT];
    details.textColor = Color(93, 93, 93);
    details.frame = CGRectMake(details_left, details_top + CGRectGetMaxY(line.frame), details_size.width, details_size.height);
    [headView addSubview:details];
    
    
    
    
    
    
    UILabel *detailsMessage = [[UILabel alloc] init];
    
    NSString *detailsString = _model.companyDesc;
    
    
    CGFloat detailsM_top = 15;
    CGFloat detailsM_left = 10;
    CGFloat detailsM_right = 12;
    CGFloat detailsM_width_Max = screenW - detailsM_left - detailsM_right;
    CGSize detailsM_size = [ZPFLableOperation sizeWithText:detailsString maxSize:CGSizeMake(detailsM_width_Max, CGFLOAT_MAX) font:[UIFont systemFontOfSize:DETAILSMESSAGE_FONT]];
    
    detailsMessage.textColor = Color(110, 110, 110);
    detailsMessage.font = [UIFont systemFontOfSize:DETAILSMESSAGE_FONT];
    detailsMessage.numberOfLines = 0;
    detailsMessage.attributedText = [ZPFLableOperation setLineSpace:6 withString:detailsString];
    detailsMessage.frame = CGRectMake(detailsM_left, CGRectGetMaxY(details.frame) + detailsM_top, detailsM_size.width, detailsM_size.height);
    [detailsMessage sizeToFit];
    [headView addSubview:detailsMessage];
    
    
    
    UIView *footerView = [[UIView alloc] init];
    CGFloat footerView_height = 31;
    CGFloat footerView_top = 15;
    footerView.backgroundColor = Color(70, 120, 220);
    footerView.frame = CGRectMake(0, CGRectGetMaxY(detailsMessage.frame) + footerView_top, screenW, footerView_height);
    [headView addSubview:footerView];
    
    UILabel *footerLab = [[UILabel alloc] init];
    CGSize footerLab_size = CGSizeMake(112, 16);
    CGFloat footerLab_Y = (footerView_height - footerLab_size.height)/2;
    footerLab.text = @"该公司招聘职位";
    footerLab.textColor = Color(255, 255, 255);
    footerLab.font = [UIFont systemFontOfSize:FOOTERLABEL_FONT];
    
    footerLab.frame = CGRectMake((screenW - footerLab_size.width)/2, footerLab_Y, footerLab_size.width, footerLab_size.height);
    [footerView addSubview:footerLab];
    
    
    CGFloat line_Y = footerView_height/2;
    CGFloat line_space = 10;
    CGSize line_size = CGSizeMake(70, 1);
    
    UILabel *footerLine_left = [[UILabel alloc] init];
    footerLine_left.backgroundColor = Color(255, 255, 255);
    footerLine_left.frame = CGRectMake(CGRectGetMinX(footerLab.frame) - line_space - line_size.width, line_Y, line_size.width, line_size.height);
    [footerView addSubview:footerLine_left];
    
    UILabel *footerLine_right = [[UILabel alloc] init];
    footerLine_right.backgroundColor = Color(255, 255, 255);
    footerLine_right.frame = CGRectMake(CGRectGetMaxX(footerLab.frame) + line_space, line_Y, line_size.width, line_size.height);
    [footerView addSubview:footerLine_right];

    headView.frame = CGRectMake(0, 0, screenW, CGRectGetMaxY(footerView.frame));
    
    return headView;
}



-(void)mapButtonAction {
    
    BaiDuMapViewController *mapViewController = [[BaiDuMapViewController alloc] init];
    mapViewController.address = _model.companyAddress;
    [self.navigationController pushViewController:mapViewController animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    
    ZPFcompanyDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZPFcompanyDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = _dataArray[indexPath.row];
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
