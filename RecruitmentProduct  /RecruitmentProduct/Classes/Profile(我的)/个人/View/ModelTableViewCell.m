//
//  ModelTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/7.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

//投递记录

#import "ModelTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZPFLableOperation.h"

#import "Common.h"
//#import "UIView+ZYFrame.h"

#define TITLE_FONT 17
#define NAME_FONT 13
#define DATE_FONT 11
#define STATE_FONT 11

@interface ModelTableViewCell ()
//设置图标
@property (nonatomic, strong) UIImageView *iconImageV;
//主标题
@property (nonatomic, strong) UILabel *titleLab;
//公司名称
@property (nonatomic, strong) UILabel *nameLab;
//简历状态
@property (nonatomic, strong) UILabel *stateLab;
//日期
@property (nonatomic, strong) UILabel *dateLab;

@property (nonatomic, copy) NSString *str;

@property (nonatomic, copy) NSString *dateString;


@end

@implementation ModelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self custom];
    }
    return self;
}

- (void)custom {

    _iconImageV = [[UIImageView alloc] init];
    _iconImageV.layer.cornerRadius = 15;
    [self.contentView addSubview:_iconImageV];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.font = [UIFont systemFontOfSize:TITLE_FONT];
    [self.contentView addSubview:_titleLab];
    
    _nameLab = [[UILabel alloc] init];
    _nameLab.font = [UIFont systemFontOfSize:NAME_FONT];
    [self.contentView addSubview:_nameLab];

    _stateLab = [[UILabel alloc] init];
    _stateLab.font = [UIFont systemFontOfSize:STATE_FONT];
    _stateLab.textColor = [UIColor blueColor];
    [self.contentView addSubview:_stateLab];
    
    _dateLab = [[UILabel alloc] init];
    _dateLab.font = [UIFont systemFontOfSize:DATE_FONT];
    [self.contentView addSubview:_dateLab];



}

- (void)setModel:(ZPFrecordModel *)model {
    _model = model;
    if ([model.sendState isEqualToString:@"00"]) {
        _str = @"投递成功";
    }else if ([model.sendState isEqualToString:@"01"]){
        _str = @"已被查看";
    }else if ([model.sendState isEqualToString:@"02"]){
        _str = @"面试邀请";
    }else if ([model.sendState isEqualToString:@"03"]){
        _str = @"暂不合适";
    }else if ([model.sendState isEqualToString:@"04"]){
        _str = @"对我有意";
    }
    
    

    
    [_iconImageV sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"moren"]];
    _titleLab.text = _model.jobName;
    _nameLab.text = _model.companyName;
    if ([_model.updateTime isEqualToString:@""]) {
        _dateString = @"";
    }else {
        NSRange range = {0,10};
        _dateString = [_model.updateTime substringWithRange:range];
    }
    _dateLab.text = _dateString;
    _stateLab.text = _str;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat icon_top = 15;
    CGFloat icon_left = 10;
    CGSize icon_size = CGSizeMake(56, 56);
    _iconImageV.frame = CGRectMake(icon_left, icon_top, icon_size.width, icon_size.height);
    
    CGFloat date_top = 26;
    CGFloat date_right = 11;
    CGSize date_size = [ZPFLableOperation sizeWithText:_dateString maxSize:CGSizeMake(CGFLOAT_MAX, DATE_FONT) font:[UIFont systemFontOfSize:DATE_FONT]];
    CGFloat date_X = screenW - date_right - date_size.width;
    _dateLab.frame = CGRectMake(date_X, date_top, date_size.width, date_size.height);

    CGFloat state_top = 16;
    CGFloat state_right = 10;
    CGSize state_size = [ZPFLableOperation sizeWithText:_str maxSize:CGSizeMake(CGFLOAT_MAX, STATE_FONT) font:[UIFont systemFontOfSize:STATE_FONT]];
    CGFloat state_X = screenW - state_right - state_size.width;
    _stateLab.frame = CGRectMake(state_X, CGRectGetMaxY(_dateLab.frame) + state_top, state_size.width, state_size.height);

    CGFloat title_top = 26;
    CGFloat title_left = 10;
    CGFloat title_width_max = state_X - CGRectGetMaxX(_iconImageV.frame) - title_left;
    CGSize title_size = [ZPFLableOperation sizeWithText:_model.jobName maxSize:CGSizeMake( title_width_max, CGFLOAT_MAX) font:[UIFont systemFontOfSize:TITLE_FONT]];
    _titleLab.frame = CGRectMake(CGRectGetMaxX(_iconImageV.frame) + title_left, title_top, title_size.width, title_size.height);
    
    CGFloat name_top = 11;
    CGFloat name_width_Max = state_X - CGRectGetMinX(_titleLab.frame);
    CGSize name_size = [ZPFLableOperation sizeWithText:_model.companyName maxSize:CGSizeMake( name_width_Max, CGFLOAT_MAX) font:[UIFont systemFontOfSize:NAME_FONT]];
    _nameLab.frame = CGRectMake(CGRectGetMinX(_titleLab.frame), CGRectGetMaxY(_titleLab.frame) + name_top, name_size.width, name_size.height);
    
}

@end
