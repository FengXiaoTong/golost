//
//  QYpositionTableViewCell.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/19.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

/**
 4.19新增 管理职位列表cell
 */

#import "QYpositionTableViewCell.h"
#import "Common.h"
#import "UIView+ZYFrame.h"

@implementation QYpositionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.height = 86;
        [self addSubViews];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"positionVC";
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    return cell;
}

- (void)addSubViews
{
    self.topImageView = [[UIImageView alloc] init];
    self.topImageView.image = [UIImage imageNamed:@"default_square"];
    [self.contentView addSubview:self.topImageView];
    
    self.nameLable = [[UILabel alloc] init];
    self.nameLable.text = @"网页美工/网页设计/前端开发/";
    [self.contentView addSubview:self.nameLable];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.text = @"上海 / 本科 / 9年工作经验";
    [self.contentView addSubview:self.addressLabel];
    
    self.stopLabel = [[UILabel alloc] init];
    self.stopLabel.text = @"截止日期 :";
    [self.contentView addSubview:self.stopLabel];
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.text = @"2016-05-19";
    [self.contentView addSubview:self.dateLabel];
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.text = @"3";
    [self.contentView addSubview:self.numberLabel];
    
    self.deliveryLabel = [[UILabel alloc] init];
    self.deliveryLabel.text = @"人投递";
    [self.contentView addSubview:self.deliveryLabel];
}

- (void)layoutSubviews
{
    // 图片
    self.topImageView.x = 10;
    self.topImageView.y = 16;
    self.topImageView.width = 56;
    self.topImageView.height = 56;
    
    // 名称
    self.nameLable.font = [UIFont systemFontOfSize:16.0];
    self.nameLable.textColor = Color(93, 93, 93);
    self.nameLable.x = CGRectGetMaxX(self.topImageView.frame) + 10;
    self.nameLable.y = 17;
    self.nameLable.width = 215;
    self.nameLable.height = 16;
    
    // 地址学历工作经验综合
    self.addressLabel.font = [UIFont systemFontOfSize:12.0];
    self.addressLabel.textColor = Color(110, 110, 110);
    self.addressLabel.x = self.nameLable.x;
    self.addressLabel.y = CGRectGetMaxY(self.nameLable.frame) + 7;
    [self.addressLabel sizeToFit];
    
    // 截止日期
    self.stopLabel.font = [UIFont systemFontOfSize:11.0];
    self.stopLabel.textColor = Color(110, 110, 110);
    [self.stopLabel sizeToFit];
    self.stopLabel.x = self.nameLable.x;
    self.stopLabel.y = CGRectGetMaxY(self.topImageView.frame) - self.stopLabel.height;
    
    // 日期
    self.dateLabel.font = [UIFont systemFontOfSize:11.0];
    self.dateLabel.textColor = Color(110, 110, 110);
    self.dateLabel.x = CGRectGetMaxX(self.stopLabel.frame) + 2;
    self.dateLabel.y = self.stopLabel.y;
    [self.dateLabel sizeToFit];
    
    // 人投递
    self.deliveryLabel.font = [UIFont systemFontOfSize:11.0];
    self.deliveryLabel.textColor = Color(110, 110, 110);
    [self.deliveryLabel sizeToFit];
    self.deliveryLabel.x = screenW - 10 - self.deliveryLabel.width;
    self.deliveryLabel.y = self.stopLabel.y;
    
    // 人数
    self.numberLabel.font = [UIFont systemFontOfSize:15.0];
    self.numberLabel.textColor = zyMainColor;
    [self.numberLabel sizeToFit];
    self.numberLabel.x = self.deliveryLabel.x - self.numberLabel.width;
    self.numberLabel.y = CGRectGetMaxY(self.deliveryLabel.frame) - self.numberLabel.height;
    
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
