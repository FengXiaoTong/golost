//
//  GRseconfd.h
//  RecruitmentProduct
//
//  Created by andorid on 16/4/16.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>
@class secondXQModel;
@interface GRseconfd : UITableViewHeaderFooterView

@property (nonatomic, strong) secondXQModel *model;

/**
 *  日期图片
 */
@property (nonatomic, strong) UIImageView *dateImage;

/**
 *  日期图片上的label
 */

@property (nonatomic, strong) UILabel *dataImageLabelUp;

@property (nonatomic, strong) UILabel *dataImageLabelDown;

/**
 *  招聘会名称
 */

@property (nonatomic, strong) UILabel *nameLabel;

/**
 *  开始时间
 */

@property (nonatomic, strong) UILabel *beginLabel;

/**
 *  结束时间
 */

@property (nonatomic, strong) UILabel *endLabel;

/**
 *  上边横线
 */

@property (nonatomic, strong) UIImageView *upImageView;

/**
 *  中间竖线
 */

@property (nonatomic, strong) UIImageView *midImageView;

/**
 *  下边横线
 */

@property (nonatomic, strong) UIImageView *downImageView;

/**
 *  报名人数
 */

@property (nonatomic, strong) UILabel *peopleLabel;

/**
 *  报名具体数字
 */

@property (nonatomic, strong) UILabel *peopleCountLabel;

/**
 *  立即报名
 */

@property (nonatomic, strong) UIButton *button;

/**
 *  具体地址
 */

@property (nonatomic, strong) UILabel *addressNameLabel;


/**
 *  详细地址
 */
@property (nonatomic, strong) UILabel *addressLabel;

/**
 *  乘车路线
 */

@property (nonatomic, strong) UILabel *wayNameLabel;


/**
 *  详细路线
 */

@property (nonatomic, strong) UILabel *wayLabel;

/**
 *  参会对象
 */

@property (nonatomic, strong) UILabel *joinNameLabel;

/**
 *  详细对象
 */

@property (nonatomic, strong) UILabel *joinLabel;

@end
