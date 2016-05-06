//
//  interviewTableViewCell.h
//  RecruitmentProduct
//
//  Created by andorid on 16/4/1.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface interviewTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

// 图片
@property (nonatomic, strong) UIImageView *titleimage;

// 标题
@property (nonatomic, strong) UILabel *titleLabel;

// 内容
@property (nonatomic, strong) UILabel *docLabel;

/**
 *  4.19新增 图片
 */

@property (nonatomic, strong) UIImageView *jtImage;

@end
