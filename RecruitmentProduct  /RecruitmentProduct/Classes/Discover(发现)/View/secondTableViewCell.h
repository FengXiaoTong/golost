//
//  secondTableViewCell.h
//  RecruitmentProduct
//
//  Created by andorid on 16/4/1.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface secondTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *dateLabel;



/**
 *  4.16新增地址图片
 */
@property (nonatomic, strong) UIImageView *addressImage;


/**
 *  4.16新增日期图片
 */
@property (nonatomic, strong) UIImageView *dateImage;

/**
 *  4.19新增报名label
 */
@property (nonatomic, strong) UILabel *joinLabel;

/**
 *  4.19新增 人数label
 */
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *classLabel;

@end
