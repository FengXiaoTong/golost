//
//  QYmanageTableViewCell.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/15.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

/**
 *  4.15 新增企业界面cell
 */

#import "QYmanageTableViewCell.h"
#import "UIView+ZYFrame.h"
#import "Common.h"

@implementation QYmanageTableViewCell

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
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:15.0];
    [self.contentView addSubview:self.nameLabel];
    
    self.jtimage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.jtimage];
}

- (void)autoLayout
{
    self.nameLabel.x = 23;
    self.nameLabel.y = 23;
    self.nameLabel.width = 200;
    self.nameLabel.height = 15;
    
    self.jtimage.x = screenW - 40;
    self.jtimage.y = 23;
    self.jtimage.width = 9;
    self.jtimage.height = 15;
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
