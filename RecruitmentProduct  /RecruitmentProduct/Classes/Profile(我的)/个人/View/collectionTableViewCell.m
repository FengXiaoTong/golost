//
//  collectionTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/7.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

//我的收藏

#import "collectionTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZPFLableOperation.h"
#import "Common.h"

//#import "UIView+ZYFrame.h"


#define TITLE_FONT 17
#define PAY_FONT 16
#define NAME_FONT 13
#define INFO_FONT 11
#define EDUCATIONAL_FONT 11
#define DATE_FONT 11


#define littleFont [UIFont systemFontOfSize:12]
#define margin 15

@interface collectionTableViewCell ()

//头像图标
@property (nonatomic, strong) UIImageView *iconImageV;
//标题
@property (nonatomic, strong) UILabel *titleLab;
//公司名称
@property (nonatomic, strong) UILabel *nameLab;
//地区、信息
@property (nonatomic, strong) UIImageView *infoImageV;

@property (nonatomic, strong) UILabel *infoLab;
//日期
@property (nonatomic, strong) UIImageView *dateImageV;

@property (nonatomic, strong) UILabel *dateLab;
//薪资
@property (nonatomic, strong) UILabel *payLab;
//学历背景
@property (nonatomic, strong) UIImageView *educationalImageV;

@property (nonatomic, strong) UILabel *educationalLab;

@property (nonatomic, strong) NSString *education;

@property (nonatomic, copy) NSString *dateString;

@end

@implementation collectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self custom];
    }
    return self;
}

- (void)custom {
    
    _iconImageV = [[UIImageView alloc] init];
    _iconImageV.layer.cornerRadius = 15;
    _infoImageV.clipsToBounds = YES;
    [self.contentView addSubview:_iconImageV];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.font = [UIFont systemFontOfSize:TITLE_FONT];
    _titleLab.textColor = Color(80, 80, 80);
    [self.contentView addSubview:_titleLab];
    
    _nameLab = [[UILabel alloc] init];
    _nameLab.font = [UIFont systemFontOfSize:NAME_FONT];
    _nameLab.textColor = Color(110, 110, 110);
    [self.contentView addSubview:_nameLab];
    
    _payLab = [[UILabel alloc] init];
    _payLab.textColor = [UIColor colorWithRed:255/255.0 green:68/255.0 blue:102/255.0 alpha:1.0];
    _payLab.font = [UIFont systemFontOfSize:PAY_FONT];
    [self.contentView addSubview:_payLab];
    
    
    
    _infoImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:_infoImageV];
    
    _infoLab = [[UILabel alloc] init];
    _infoLab.font = [UIFont systemFontOfSize:INFO_FONT];
    _infoLab.textColor = Color(110, 110, 110);
    [self.contentView addSubview:_infoLab];
    
    _dateImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:_dateImageV];
    
    _dateLab = [[UILabel alloc] init];
    _dateLab.font = [UIFont systemFontOfSize:DATE_FONT];
    _dateLab.textColor = Color(110, 110, 110);
    [self.contentView addSubview:_dateLab];
    

    
    _educationalImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:_educationalImageV];
    
    _educationalLab = [[UILabel alloc] init];
    _educationalLab.font = [UIFont systemFontOfSize:EDUCATIONAL_FONT];
    _educationalLab.textColor = Color(110, 110, 110);
    [self.contentView addSubview:_educationalLab];
    
    
}

-(void)setModel:(ZPFcollectionModel *)model {
    _model = model;
    
    
    [_iconImageV sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"details_mr"]];
    
    _titleLab.text = _model.jobName;
    
    _payLab.text = _model.salary;

    _nameLab.text = _model.companyName;
    
    _infoImageV.image = [UIImage imageNamed:@"details_place"];
    _infoLab.text = _model.jobArea;
    _educationalImageV.image = [UIImage imageNamed:@"xueli"];
    
    if (!_model.education) {
        _education = @"不限";
    } else {
        _education = _model.education;
    }
    _educationalLab.text = _education;

    _dateImageV.image = [UIImage imageNamed:@"details_time"];
    
    
    if ([_model.storeDate isEqualToString:@""]) {
        _dateString = @"";
    }else {
        NSRange range = {0,10};
        _dateString = [_model.storeDate substringWithRange:range];
    }
    _dateLab.text = _dateString;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat icon_top = 13;
    CGFloat icon_left = 10;
    CGSize icon_size = CGSizeMake(56, 56);
    _iconImageV.frame = CGRectMake(icon_left, icon_top, icon_size.width, icon_size.height);
    
    
    CGFloat title_top = 13;
    CGFloat title_left = 11;
    CGSize title_size = [ZPFLableOperation sizeWithText:_model.jobName maxSize:CGSizeMake(CGFLOAT_MAX, TITLE_FONT) font:[UIFont systemFontOfSize:TITLE_FONT]];
    _titleLab.frame = CGRectMake(CGRectGetMaxX(_iconImageV.frame) + title_left, title_top, title_size.width, title_size.height);
    
    
    CGFloat name_top = 10;
    CGSize name_size = [ZPFLableOperation sizeWithText:_model.companyName maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _nameLab.frame = CGRectMake(CGRectGetMinX(_titleLab.frame), CGRectGetMaxY(_titleLab.frame) + name_top, name_size.width, name_size.height);
    
    
    CGFloat pay_top = 36;
    CGFloat pay_right = 10;
    CGSize pay_size = [ZPFLableOperation sizeWithText:_model.salary maxSize:CGSizeMake(CGFLOAT_MAX, PAY_FONT) font:[UIFont systemFontOfSize:PAY_FONT]];
    CGFloat pay_X = [UIScreen mainScreen].bounds.size.width - pay_right - pay_size.width;
    
    _payLab.frame = CGRectMake(pay_X, pay_top, pay_size.width, pay_size.height);

    
    CGFloat infoIV_top = 6;
    CGSize infoIV_size = CGSizeMake(9, 13);
    _infoImageV.frame = CGRectMake(CGRectGetMinX(_nameLab.frame), CGRectGetMaxY(_nameLab.frame) + infoIV_top, infoIV_size.width, infoIV_size.height);
    
    
    CGFloat info_left = 6;
    CGSize info_size = CGSizeMake(52, 11);//[ZPFLableOperation sizeWithText:_model.jobArea maxSize:CGSizeMake(CGFLOAT_MAX, INFO_FONT) font:[UIFont systemFontOfSize:INFO_FONT]];
    _infoLab.frame = CGRectMake(CGRectGetMaxX(_infoImageV.frame) + info_left, CGRectGetMinY(_infoImageV.frame), info_size.width, info_size.height);
    
    
    CGFloat educationalIV_left = 16;
    CGSize educationalIV_size = CGSizeMake(9, 13);
    _educationalImageV.frame = CGRectMake(CGRectGetMaxX(_infoLab.frame) + educationalIV_left, CGRectGetMinY(_infoLab.frame), educationalIV_size.width, educationalIV_size.height);
    
    
    CGFloat educational_left = 6;
    CGSize educational_size = [ZPFLableOperation sizeWithText:_education maxSize:CGSizeMake(CGFLOAT_MAX, EDUCATIONAL_FONT) font:[UIFont systemFontOfSize:EDUCATIONAL_FONT]];
    _educationalLab.frame = CGRectMake(CGRectGetMaxX(_educationalImageV.frame) + educational_left, CGRectGetMinY(_educationalImageV.frame), educational_size.width, educational_size.height);
    
    
    
//    CGFloat date_top = 7;
    CGFloat date_right = 10;
    CGSize date_size = [ZPFLableOperation sizeWithText:_dateString maxSize:CGSizeMake(CGFLOAT_MAX, DATE_FONT) font:[UIFont systemFontOfSize:DATE_FONT]];
    CGFloat date_X = [UIScreen mainScreen].bounds.size.width - date_right - date_size.width;
    _dateLab.frame = CGRectMake(date_X, CGRectGetMinY(_educationalLab.frame), date_size.width, date_size.height);
    
    
    
    CGFloat dateIV_right = 6;
    CGSize dateIV_size = CGSizeMake(12, 12);
    _dateImageV.frame = CGRectMake(CGRectGetMinX(_dateLab.frame) - dateIV_right - dateIV_size.width, CGRectGetMinY(_dateLab.frame), dateIV_size.width, dateIV_size.height);
    

}






@end


