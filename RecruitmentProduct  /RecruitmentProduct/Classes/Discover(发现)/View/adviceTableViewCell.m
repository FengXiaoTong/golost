//
//  adviceTableViewCell.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/1.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "adviceTableViewCell.h"
#import "Common.h"
#import "UIView+ZYFrame.h"

@implementation adviceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.height = 86;
        [self addSubViews];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"adviceVC";
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    
    
    return cell;
    
}

- (void)addSubViews
{
    // 图片
    self.adviceImageView = [[UIImageView alloc] init];
    self.adviceImageView.image = [UIImage imageNamed:@"profile_icon"];
    [self.contentView addSubview:self.adviceImageView];
    
    // 标题名
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"个人简历的9大注意事项";
    [self.contentView addSubview:self.titleLabel];
    
    // 日期
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.text = @"02-27";
    [self.contentView addSubview:self.dateLabel];
    
    // 文本
    self.docLabel = [[UILabel alloc] init];
    self.docLabel.text = @"1.要仔细检查已经成文的个人简历,绝不能出现错误,错别字,胡言乱语,语法的个人简历;两款手机掉了 奥尔加附件按时;我就按价格 破大家";
    [self.contentView addSubview:self.docLabel];
}

- (void)layoutSubviews
{
    self.adviceImageView.x = 10;
    self.adviceImageView.y = 16;
    self.adviceImageView.width = 55;
    self.adviceImageView.height = 55;
    
    self.titleLabel.x = CGRectGetMaxX(self.adviceImageView.frame) + 6;
    self.titleLabel.y = 16;
    _titleLabel.font = [UIFont systemFontOfSize:15.0];
    _titleLabel.textColor = Color(93, 93, 93);
    [self.titleLabel sizeToFit];
    
    self.dateLabel.font = [UIFont systemFontOfSize:12.0];
    self.dateLabel.textColor = Color(93, 93, 93);
    [self.dateLabel sizeToFit];
    self.dateLabel.x = screenW - 10 - self.dateLabel.width;
    self.dateLabel.y = 21;
    
    self.docLabel.font = [UIFont systemFontOfSize:12.0];
    self.docLabel.textColor = Color(110, 110, 110);
//    [self.docLabel sizeToFit];
    self.docLabel.numberOfLines = 0;
    self.docLabel.x = CGRectGetMaxX(self.adviceImageView.frame) + 7;
    self.docLabel.y = CGRectGetMaxY(self.titleLabel.frame) + 9;
    self.docLabel.width = screenW - self.docLabel.x - 10;
    self.docLabel.height = 31;
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
