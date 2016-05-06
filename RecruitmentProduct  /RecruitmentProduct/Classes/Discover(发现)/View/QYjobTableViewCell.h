//
//  QYjobTableViewCell.h
//  RecruitmentProduct
//
//  Created by andorid on 16/4/15.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYjobTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLable;

@property (nonatomic, strong) UIImageView *imageV;


/**
 *  4.18新增 发布新职位 后面的label
 */

@property (nonatomic, strong) UILabel *lastLabel;

@end
