//
//  secondTableViewCell.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/1.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "secondTableViewCell.h"
#import "Common.h"
#import "UIView+ZYFrame.h"

#define kW 10
#define kH 15

@implementation secondTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
    }
    return self;
}

/**
 *  4.16 修改布局
 */

- (void)addSubViews
{
    // 标题
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.x = kW;
    self.nameLabel.y = kH;
    self.nameLabel.width = screenW / 3 * 2;
    self.nameLabel.height = 16;
//    self.nameLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:15.0];
    self.nameLabel.textColor = Color(80, 80, 80);
    self.nameLabel.text = @"郑州CBD国际会展中心春季万人大型活动";
    
//    self.nameLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.nameLabel];
    
    /**
     4.16新增
     */
    self.addressImage = [[UIImageView alloc] init];
    self.addressImage.x = kW;
    self.addressImage.y = CGRectGetMaxY(self.nameLabel.frame) + 7;
    self.addressImage.width = 9;
    self.addressImage.height = 13;
    self.addressImage.image = [UIImage imageNamed:@"place"];
    [self.contentView addSubview:self.addressImage];
    
    // 地址
    self.addressLabel = [[UILabel alloc] init];
     self.addressLabel.text = @"这点是活动地址";
//    [self.addressLabel sizeToFit];
    self.addressLabel.x = CGRectGetMaxX(self.addressImage.frame) + 6;
    self.addressLabel.y = self.addressImage.y;
    
    self.addressLabel.width = 120;
    self.addressLabel.height = 11;
    
    
    self.addressLabel.textColor = Color(120, 120, 120);
    
    [self.contentView addSubview:self.addressLabel];
    
    /**
     4.20新增
     */
    self.classLabel = [[UILabel alloc] init];
    _classLabel.text = @"综合招聘会";
    _classLabel.x = CGRectGetMaxX(_addressLabel.frame) + 10;
    _classLabel.y = _addressLabel.y;
    _classLabel.width = 150;
    _classLabel.height = 11;
    _classLabel.textColor = Color(120, 120, 120);
    [self.contentView addSubview:_classLabel];

    
    
    
    // 日期
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.text = @"2016-01-01";
    [self.dateLabel sizeToFit];
    self.dateLabel.x = screenW - self.dateLabel.width + 20;
    
    self.dateLabel.y = self.addressLabel.y - 3;
    self.dateLabel.textColor = Color(120, 120, 120);
    [self.contentView addSubview:self.dateLabel];
    
    // 日期图片
    self.dateImage = [[UIImageView alloc] init];
    self.dateImage.x = self.dateLabel.x - 18;
    self.dateImage.y = self.addressLabel.y;
    self.dateImage.width = 12;
    self.dateImage.height = 12;
    self.dateImage.image = [UIImage imageNamed:@"time"];
    [self.contentView addSubview:self.dateImage];
    
    // 人报名
    self.joinLabel = [[UILabel alloc] init];
    self.joinLabel.text = @"人报名";
    self.joinLabel.textColor = Color(80, 80, 80);
    [self.joinLabel sizeToFit];
    self.joinLabel.x = screenW - _joinLabel.width;
    self.joinLabel.y = self.nameLabel.y;
    
    [self.contentView addSubview:self.joinLabel];
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.textColor = Color(255, 68, 102);
    self.numberLabel.text = @"100";
    [_numberLabel sizeToFit];
    _numberLabel.x = self.joinLabel.x - self.numberLabel.width;
    _numberLabel.y = self.joinLabel.y;
    [self.contentView addSubview:self.numberLabel];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
