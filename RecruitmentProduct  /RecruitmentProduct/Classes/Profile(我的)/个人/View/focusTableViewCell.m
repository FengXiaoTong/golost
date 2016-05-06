//
//  focusTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/7.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "focusTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZPFLableOperation.h"

#import "Common.h"
#import "UIView+ZYFrame.h"

#define TITLE_FONT 17
#define POSITIONNUMBER_FONT 12
#define DATE_FONT 11

//人事来信

@interface focusTableViewCell ()
//设置图标
@property (nonatomic, strong) UIImageView *iconImageV;
//公司名称
@property (nonatomic, strong) UILabel *titleLab;
//招聘职位
@property (nonatomic, strong) UILabel *positionNumberLab;
//日期
@property (nonatomic, strong) UILabel *dateLab;


@property (nonatomic, copy) NSString *string;
@property (nonatomic, copy) NSString *dateText;


@end

@implementation focusTableViewCell

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
    _iconImageV.clipsToBounds = YES;
    [self.contentView addSubview:_iconImageV];

    _titleLab = [[UILabel alloc] init];
    _titleLab.font = [UIFont systemFontOfSize:TITLE_FONT];
    _titleLab.textColor = Color(80, 80, 80);
    [self.contentView addSubview:_titleLab];
    
    _positionNumberLab = [[UILabel alloc] init];
    _positionNumberLab.font = [UIFont systemFontOfSize:POSITIONNUMBER_FONT];
    _positionNumberLab.textColor = Color(110, 110, 110);
    [self.contentView addSubview:_positionNumberLab];
    
    _dateLab = [[UILabel alloc] init];
    _dateLab.font = [UIFont systemFontOfSize:DATE_FONT];
    _dateLab.textColor = Color(110, 110, 110);
    [self.contentView addSubview:_dateLab];
    
    

}

-(void)setModel:(ZPFfocusModel *)model {

    _model = model;
    
    [_iconImageV sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"details_mr"]];
    
    _titleLab.text = _model.companyName;

    _string = [NSString stringWithFormat:@"%ld 个职位正在招聘",(long)_model.jobNum];

    [_positionNumberLab setAttributedText:[ZPFLableOperation positionNumber:_string withSize:18]] ;
    
    NSRange range = {0,10};
    _dateText = [_model.storeDate substringWithRange:range];

    _dateLab.text = _dateText;


}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat icon_top = 17;
    CGFloat icon_left = 10;
    CGSize icon_size = CGSizeMake(56, 56);
    
    _iconImageV.frame = CGRectMake(icon_left, icon_top, icon_size.width, icon_size.height);
    
    
    CGFloat title_top = 26;
    CGFloat title_left = 10;
    CGSize title_size = [ZPFLableOperation sizeWithText:_model.companyName maxSize:CGSizeMake(CGFLOAT_MAX, TITLE_FONT) font:[UIFont systemFontOfSize:TITLE_FONT]];
    _titleLab.frame = CGRectMake(CGRectGetMaxX(_iconImageV.frame) + title_left, title_top, title_size.width, title_size.height);
    
    
    CGFloat positionNumber_top = 12;
    CGFloat positionNumber_width_Max = [UIScreen mainScreen].bounds.size.width - CGRectGetMinX(_titleLab.frame);
    _positionNumberLab.frame = CGRectMake(CGRectGetMinX(_titleLab.frame), CGRectGetMaxY(_titleLab.frame) + positionNumber_top, positionNumber_width_Max, POSITIONNUMBER_FONT);
    
    
    CGFloat date_top = 33;
    CGFloat date_right = 11;
    CGSize date_size = [ZPFLableOperation sizeWithText:_dateText maxSize:CGSizeMake(CGFLOAT_MAX, DATE_FONT) font:[UIFont systemFontOfSize:DATE_FONT]];
    CGFloat date_X = [UIScreen mainScreen].bounds.size.width - date_right - date_size.width;
    
    _dateLab.frame = CGRectMake(date_X, date_top, date_size.width, date_size.height);
    
}






@end
