//
//  schoolTableViewCell.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/13.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "schoolTableViewCell.h"
#import "Common.h"
#import "UIView+ZYFrame.h"


@implementation schoolTableViewCell

// 校园招聘自定义cell
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
    static NSString *identifier = @"schoolVC";
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    return cell;
}


/**
 *  4.20修改
 */

- (void)addSubViews
{
    
    
    // 添加企业图片
    self.qyimage = [[UIImageView alloc] init];
    self.qyimage.image = [UIImage imageNamed:@"default_square"];
    [self.contentView addSubview:_qyimage];
    
    // 添加职位名称
    self.zwnameLable = [[UILabel alloc] init];
    self.zwnameLable.text = @"ios/Android开发工程师";
    [self.contentView addSubview:_zwnameLable];
    
    // 添加企业名称
    self.qynameLable = [[UILabel alloc] init];
    _qynameLable.text = @"河南润升信息技术有限公司";
    [self.contentView addSubview:_qynameLable];
    
    // 4.20 地址图片
    _addressImageView = [[UIImageView alloc] init];
    _addressImageView.image = [UIImage imageNamed:@"place"];
    [self.contentView addSubview:_addressImageView];
    
    // 4.20 地址
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.text = @"郑州";
    [self.contentView addSubview:_addressLabel];
    
    // 4.20 学历图片
    _schoolImageView = [[UIImageView alloc] init];
    _schoolImageView.image = [UIImage imageNamed:@"xueli"];
    [self.contentView addSubview:_schoolImageView];
    
    // 4.20 学历
    _schoolLabel = [[UILabel alloc] init];
    _schoolLabel.text = @"本科 | 10-15年";
    [self.contentView addSubview:_schoolLabel];
    
    // 添加日期
    self.dateLable = [[UILabel alloc] init];
    _dateLable.text = @"05.19";
    [self.contentView addSubview:_dateLable];
    
    // 添加薪资
    self.moneyLabel = [[UILabel alloc] init];
    _moneyLabel.text = @"10k-15k";
    [self.contentView addSubview:self.moneyLabel];
    
    
}

- (void)layoutSubviews
{
    // 企业图片
    self.qyimage.x = 10;
    self.qyimage.y = 15;
    self.qyimage.width = 56;
    _qyimage.height = 56;
    
    // 职位名称
    _zwnameLable.font = [UIFont systemFontOfSize:17.0];
    _zwnameLable.textColor = Color(93, 93, 93);
    _zwnameLable.x = CGRectGetMaxY(_qyimage.frame) + 10;
    _zwnameLable.y = _qyimage.y;
    [_zwnameLable sizeToFit];
    
    // 企业名称
    _qynameLable.font = [UIFont systemFontOfSize:13.0];
    _qynameLable.textColor = Color(110, 110, 110);
    _qynameLable.x = _zwnameLable.x;
    _qynameLable.y = CGRectGetMaxY(_zwnameLable.frame) + 5;
    [_qynameLable sizeToFit];
    
    // 地址图片
    _addressImageView.height = 13;
    _addressImageView.width = 9;
    _addressImageView.x = _zwnameLable.x;
    _addressImageView.y = CGRectGetMaxY(_qyimage.frame) - _addressImageView.height;
    
    // 地址
    _addressLabel.font = [UIFont systemFontOfSize:11.0];
    _addressLabel.textColor = Color(110, 110, 110);
    _addressLabel.x = CGRectGetMaxX(_addressImageView.frame) + 3;
    _addressLabel.y = _addressImageView.y;
    [_addressLabel sizeToFit];
    
    // 学历图片
    _schoolImageView.x = CGRectGetMaxX(_addressLabel.frame)  + 10;
    _schoolImageView.y = _addressLabel.y;
    _schoolImageView.width = 9;
    _schoolImageView.height = 13;
    
    // 学历
    _schoolLabel.font = [UIFont systemFontOfSize:11.0];
    _schoolLabel.textColor = Color(110, 110, 110);
    _schoolLabel.x = CGRectGetMaxX(_schoolImageView.frame) + 3;
    _schoolLabel.y = _schoolImageView.y;
    [_schoolLabel sizeToFit];
    
    // 薪资
    _moneyLabel.font = [UIFont systemFontOfSize:16.0];
    _moneyLabel.textColor = Color(255, 68, 102);
    [_moneyLabel sizeToFit];
    _moneyLabel.x = screenW - 10 - _moneyLabel.width;
    _moneyLabel.y = CGRectGetMaxY(_qyimage.frame) - _moneyLabel.height;
    
    // 时间
    _dateLable.font = [UIFont systemFontOfSize:11.0];
    _dateLable.textColor = Color(110, 110, 110);
    [_dateLable sizeToFit];
    _dateLable.x = screenW - 10 - _dateLable.width;
    _dateLable.y = _zwnameLable.y;
    
    
    
    
    
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
