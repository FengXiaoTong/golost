//
//  positionSectionHeaderView.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/8.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>
@class positionGroup;
@interface positionSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) positionGroup *group;
@property (nonatomic, strong) void (^headerViewClick)(void);

+(instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
