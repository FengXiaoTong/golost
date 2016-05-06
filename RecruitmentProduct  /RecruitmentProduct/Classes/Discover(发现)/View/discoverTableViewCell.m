//
//  discoverTableViewCell.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/12.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "discoverTableViewCell.h"
#import "Common.h"

@implementation discoverTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
    }
    return self;
}

// 布局子视图
- (void)addSubViews
{
    // 4.15布局改动
    // 名字
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(54, 25, 70, 15)];

    self.titleLabel.textColor = Color(120, 120, 120);

    self.titleLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:15.0];
//    self.titleLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.titleLabel];
    
    // 图片
    self.titleIamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 16, 22, 22)];
//    self.titleIamgeView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.titleIamgeView];
    
    // 4.15新增 后面小箭头图片
    self.jtImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenW - 31, 23, 9, 15)];
//    self.jtImageView.backgroundColor = [UIColor yellowColor];
    self.jtImageView.image = [UIImage imageNamed:@"find_go"];
    [self.contentView addSubview:self.jtImageView]; 

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

