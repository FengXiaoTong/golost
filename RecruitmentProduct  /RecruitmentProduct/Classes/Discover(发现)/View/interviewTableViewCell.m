//
//  interviewTableViewCell.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/1.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "interviewTableViewCell.h"
#import "Common.h"
#import "UIView+ZYFrame.h"

@implementation interviewTableViewCell

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
    static NSString *identifier = @"interviewVC";
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    return cell;
}

- (void)addSubViews
{
    self.titleimage = [[UIImageView alloc] init];
    self.titleimage.image = [UIImage imageNamed:@"wenzhi"];
    [self.contentView addSubview:self.titleimage];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"毕业生篇";
    [self.contentView addSubview:self.titleLabel];
    
    self.jtImage = [[UIImageView alloc] init];
    self.jtImage.image = [UIImage imageNamed:@"monimianshi"];
    [self.contentView addSubview:self.jtImage];
    
    
    
    self.docLabel = [[UILabel alloc] init];
    self.docLabel.text = @"1.1.要仔细检查已经成文的个人简历,绝不能出现错误,错别字,胡言乱语,语法的个人简历;两款手机掉了 奥尔加附件按时;我就按价格 破大家";
    self.docLabel.numberOfLines = 0;
    [self.contentView addSubview:self.docLabel];
}

- (void)layoutSubviews
{
    self.titleimage.x = 10;
    self.titleimage.y = 21;
    self.titleimage.width = 45;
    self.titleimage.height = 45;
    
    self.titleLabel.x = CGRectGetMaxX(self.titleimage.frame) + 16;
    self.titleLabel.y = 15;
    self.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.titleLabel.textColor = Color(93, 93, 93);
    [self.titleLabel sizeToFit];
    
    self.jtImage.x = screenW - 34;
    self.jtImage.y = 29;
    self.jtImage.width = 15;
    self.jtImage.height = 30;

    
    self.docLabel.x = self.titleLabel.x;
    self.docLabel.y = CGRectGetMaxY(self.titleLabel.frame) + 9;
    self.docLabel.font = [UIFont systemFontOfSize:12.0];
    self.docLabel.textColor = Color(110, 110, 110);
    self.docLabel.width = screenW - self.titleLabel.x - 51;
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
