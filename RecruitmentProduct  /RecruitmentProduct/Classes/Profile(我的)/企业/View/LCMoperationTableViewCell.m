//
//  LCMoperationTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/27.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMoperationTableViewCell.h"
#import "ZPFLableOperation.h"
#import <UIImageView+WebCache.h>
#import "Common.h"

#define TITLE_FONT 16

#define NAME_FONT 13

@interface LCMoperationTableViewCell ()
//头像图标
@property (nonatomic, strong) UIImageView *iconImage;
//名字
@property (nonatomic, strong) UILabel *nameLabel;
//时间图标
@property (nonatomic, strong) UIImageView *timeImage;
@property (nonatomic, strong) UILabel *timeLabel;
//用户标识
@property (nonatomic, strong) UIImageView *userImage;
@property (nonatomic, strong) UILabel *userLabel;
//IP图票
@property (nonatomic, strong) UIImageView *ipImage;
@property (nonatomic, strong) UILabel *ipLabel;

@end
@implementation LCMoperationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addCustom];
    }
    return self;
}
- (void)addCustom {

    _iconImage  = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImage];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:TITLE_FONT];
    _nameLabel.textColor = Color(80, 80, 80);
    [self.contentView addSubview: _nameLabel];
    
    _timeImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_timeImage];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _timeLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_timeLabel];
    
    _userImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_userImage];
    
    _userLabel = [[UILabel alloc] init];
    _userLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _userLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_userLabel];
    
    _ipImage = [[UIImageView alloc] init];
    [self.contentView addSubview: _ipImage];
    
    _ipLabel = [[UILabel alloc] init];
    _ipLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _ipLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_ipLabel];
    
}

-(void)setModel:(LCMoperationModel *)model {

    _model = model;
    
    [_iconImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"yonghu"]];
    
    _nameLabel.text = _model.user;
    [_timeImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"time"]];
    _timeLabel.text = _model.occurDate;
    
    [_userImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"qiyeyonghu"]];
    _userLabel.text = _model.occurContent;
    
    [_ipImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"ip"]];
    _ipLabel.text = _model.occurIp;
    

}
- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat top = 10.0;//上边距
    CGFloat icon_left = 10.0;//左边距
    CGFloat label_label = 10;//字体与字体行间距
    CGFloat pic_lab = 5;//图片与字体间距
    CGFloat lab_pic = 10;//字体与图间距
    CGFloat pic_pic = 10;
    
    CGSize  icon_size = CGSizeMake(17, 20);
    _iconImage.frame = CGRectMake(icon_left, top, icon_size.width, icon_size.height);
    
    CGSize nameLa_size = [ZPFLableOperation sizeWithText:_model.user maxSize:CGSizeMake(CGFLOAT_MAX, TITLE_FONT) font:[UIFont systemFontOfSize:TITLE_FONT]];
    _nameLabel.frame = CGRectMake(CGRectGetMaxY(_iconImage.frame) + pic_lab, top, nameLa_size.width, nameLa_size.height);
    
    CGSize timeImage_size = CGSizeMake(12, 12);
    _timeImage.frame = CGRectMake(icon_left, CGRectGetMaxY(_nameLabel.frame) + pic_pic, timeImage_size.width, timeImage_size.height);
    CGSize timeLab_size = [ZPFLableOperation sizeWithText:_model.occurDate maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_timeImage.frame) + pic_lab, CGRectGetMaxY(_nameLabel.frame) + label_label, timeLab_size.width, timeLab_size.height);
    
    CGSize userImage_size = CGSizeMake(10, 11);
    _userImage.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame) + lab_pic, CGRectGetMaxY(_iconImage.frame) + pic_pic, userImage_size.width, userImage_size.height);
   
    CGSize userLab_size = [ZPFLableOperation sizeWithText:_model.occurContent maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _userLabel.frame = CGRectMake(CGRectGetMaxX(_userImage.frame) + pic_lab, CGRectGetMaxY(_nameLabel.frame) + label_label, userLab_size.width, userLab_size.height);
    
    CGSize ipIma_size = CGSizeMake(11, 12);
    _ipImage.frame = CGRectMake(CGRectGetMaxX(_userLabel.frame) + lab_pic, CGRectGetMaxY(_iconImage.frame) + pic_pic, ipIma_size.width, ipIma_size.height);
    
    CGSize ipLab_size = [ZPFLableOperation sizeWithText:_model.occurIp maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _ipLabel.frame = CGRectMake(CGRectGetMaxX(_ipImage.frame) + pic_lab, CGRectGetMaxY(_nameLabel.frame) + label_label, ipLab_size.width, ipLab_size.height);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
