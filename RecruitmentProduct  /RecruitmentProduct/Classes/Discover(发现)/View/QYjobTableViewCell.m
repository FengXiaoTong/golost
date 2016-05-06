//
//  QYjobTableViewCell.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/15.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//
/**
 *  4.15新增企业职位cell
 */

#import "QYjobTableViewCell.h"
#import "UIView+ZYFrame.h"
#import "Common.h"

@implementation QYjobTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        [self autoLayout];
    }
    return self;
}

- (void)addSubViews
{
    self.nameLable = [[UILabel alloc] init];
    self.nameLable.font = [UIFont fontWithName:@"MicrosoftYaHei" size:15.0];
    self.nameLable.x = 23;
    self.nameLable.y = 23;
    self.nameLable.text = @"职位发布地点";
    [self.nameLable sizeToFit];
    [self.contentView addSubview:self.nameLable];
    
    self.imageV = [[UIImageView alloc] init];
//    self.imageV.backgroundColor = [UIColor yellowColor];
    
    [self.contentView addSubview:self.imageV];
    
    
    self.lastLabel = [[UILabel alloc] init];
    self.lastLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.lastLabel];
}

- (void)autoLayout
{
    self.imageV.x = screenW - 40;
    self.imageV.y = 23;
    self.imageV.width = 9;
    self.imageV.height = 15;
    
    self.lastLabel.x = CGRectGetMaxX(self.nameLable.frame) + 20;
    self.lastLabel.y = 23;
    self.lastLabel.width = self.imageV.x - CGRectGetMaxX(self.nameLable.frame) - 40;
    self.lastLabel.height = 18;
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
