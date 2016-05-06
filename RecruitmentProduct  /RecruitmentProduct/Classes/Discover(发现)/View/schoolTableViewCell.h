//
//  schoolTableViewCell.h
//  RecruitmentProduct
//
//  Created by andorid on 16/4/13.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface schoolTableViewCell : UITableViewCell

/**
 *  4.19新增 重写cell方法
 */
+(instancetype)cellWithTableView:(UITableView *)tableView;

// 企业图片
@property (nonatomic, strong) UIImageView *qyimage;

// 职位名称
@property (nonatomic, strong) UILabel *zwnameLable;

// 公司名称
@property (nonatomic, strong) UILabel *qynameLable;

// 日期
@property (nonatomic, strong) UILabel *dateLable;

// 薪资
@property (nonatomic, strong) UILabel *moneyLabel;


/**
 *  4.20新增 地址图片
 */
@property (nonatomic, strong) UIImageView *addressImageView;

/**
 *  4.20新增 公司地址
 */
@property (nonatomic, strong) UILabel *addressLabel;

/**
 *  4.20新增 学历图片
 */
@property (nonatomic, strong) UIImageView *schoolImageView;

/**
 *  4.20新增 学历
 */
@property (nonatomic, strong) UILabel *schoolLabel;


@end
