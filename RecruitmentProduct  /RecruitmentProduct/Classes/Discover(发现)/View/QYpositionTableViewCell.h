//
//  QYpositionTableViewCell.h
//  RecruitmentProduct
//
//  Created by andorid on 16/4/19.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYpositionTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  图片
 */
@property (nonatomic, strong) UIImageView *topImageView;

/**
 *  职位名称
 */
@property (nonatomic, strong) UILabel *nameLable;

/**
 *  地址学历工作经验
 */
@property (nonatomic, strong) UILabel *addressLabel;

/**
 *  截止日期
 */
@property (nonatomic, strong) UILabel *stopLabel;

/**
 *  日期
 */
@property (nonatomic, strong) UILabel *dateLabel;

/**
 *  人数
 */
@property (nonatomic, strong) UILabel *numberLabel;

/**
 *  人投递
 */
@property (nonatomic, strong) UILabel *deliveryLabel;

@end
