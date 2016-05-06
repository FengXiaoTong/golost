//
//  adviceTableViewCell.h
//  RecruitmentProduct
//
//  Created by andorid on 16/4/1.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adviceTableViewCell : UITableViewCell

// 4.19新增
+(instancetype)cellWithTableView:(UITableView *)tableView;

// 图片
@property (nonatomic, strong) UIImageView *adviceImageView;

// 标题名
@property (nonatomic, strong) UILabel *titleLabel;

// 日期
@property (nonatomic, strong) UILabel *dateLabel;

// 内容
@property (nonatomic, strong) UILabel *docLabel;


@end
