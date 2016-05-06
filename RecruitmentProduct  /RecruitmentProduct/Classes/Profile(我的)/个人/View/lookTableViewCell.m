//
//  lookTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/8.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "lookTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZPFLableOperation.h"
#import "Common.h"
//#import "UIView+ZYFrame.h"
//#define littleFont [UIFont systemFontOfSize:12]
//#define margin 15


#define COMPANY_FONT 16
#define POSITIONNUMBER_FONT 12
#define MESSAGE_FONT 11
#define DATE_FONT 11


@interface lookTableViewCell ()
//设置图标
@property (nonatomic, strong) UIImageView *iconImageV;
//公司名称
@property (nonatomic, strong) UILabel *companyNameLab;
//招聘职位个数
@property (nonatomic, strong) UILabel *positionNumberLab;
//信息
@property (nonatomic, strong) UILabel *messageLab;
//日期
@property (nonatomic, strong) UILabel *dateLab;
//职位个数
@property (nonatomic, copy) NSString *string;
//消息
@property (nonatomic, copy) NSString *messageStr;

@property (nonatomic, copy) NSString *dateString;


@end

@implementation lookTableViewCell





- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self costom];
    }
    return self;
}


- (void)costom {

    _iconImageV = [[UIImageView alloc] init];
    _iconImageV.layer.cornerRadius = 15;
    _iconImageV.clipsToBounds = YES;
    [self.contentView addSubview:_iconImageV];
    
    _companyNameLab = [[UILabel alloc] init];
    _companyNameLab.font = [UIFont systemFontOfSize:COMPANY_FONT];
    _companyNameLab.textColor = Color(80, 80, 80);
    [self.contentView addSubview:_companyNameLab];
    
    _messageLab = [[UILabel alloc] init];
    _messageLab.font = [UIFont systemFontOfSize:MESSAGE_FONT];
    _messageLab.textColor = Color(110, 110, 110);
    [self.contentView addSubview:_messageLab];
    
    _positionNumberLab = [[UILabel alloc] init];
    _positionNumberLab.font = [UIFont systemFontOfSize:POSITIONNUMBER_FONT];
    _positionNumberLab.textColor = Color(110, 110, 110);
    [self.contentView addSubview:_positionNumberLab];

    _dateLab = [[UILabel alloc] init];
    _dateLab.font = [UIFont systemFontOfSize:DATE_FONT];
    _dateLab.textColor = Color(110, 110, 110);
    [self.contentView addSubview:_dateLab];


}

-(void)setModel:(ZPFlookModel *)model {
    _model = model;

    [_iconImageV sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"moren"]];
    
    _companyNameLab.text = _model.companyName;
    
    _string = [NSString stringWithFormat:@"%@ 个职位正在招聘",_model.jobNum];
    
    [_positionNumberLab setAttributedText:[ZPFLableOperation positionNumber:_string withSize:15]] ;
    
    _messageStr = [NSString stringWithFormat:@"查看了我的%@",_model.resumeName];
    _messageLab.text = _messageStr;
    
    if (![_model.viewedDate isEqualToString:@""]) {
        NSRange range = {0,10};
        _dateString = [_model.viewedDate substringWithRange:range];
    }
    
    _dateLab.text = _dateString;

}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat icon_top = 15;
    CGFloat icon_left = 10;
    CGSize icon_size = CGSizeMake(56, 56);
    
    _iconImageV.frame = CGRectMake(icon_left, icon_top, icon_size.width, icon_size.height);
    
    
    CGFloat company_top = 16;
    CGFloat company_left = 10;
    CGSize company_size = [ZPFLableOperation sizeWithText:_model.companyName maxSize:CGSizeMake(CGFLOAT_MAX, COMPANY_FONT) font:[UIFont systemFontOfSize:COMPANY_FONT]];
    _companyNameLab.frame = CGRectMake(CGRectGetMaxX(_iconImageV.frame) + company_left, company_top, company_size.width, company_size.height);
    
    
    CGFloat positionNumber_top = 9;
    CGFloat positionNumber_width_Max = screenW - CGRectGetMinX(_companyNameLab.frame);
    _positionNumberLab.frame = CGRectMake(CGRectGetMinX(_companyNameLab.frame), CGRectGetMaxY(_companyNameLab.frame) + positionNumber_top, positionNumber_width_Max, POSITIONNUMBER_FONT);
    
    
    CGFloat message_top = 6;
    CGSize message_size = [ZPFLableOperation sizeWithText:_messageStr maxSize:CGSizeMake(CGFLOAT_MAX, MESSAGE_FONT) font:[UIFont systemFontOfSize:MESSAGE_FONT]];
    _messageLab.frame = CGRectMake(CGRectGetMinX(_companyNameLab.frame), CGRectGetMaxY(_positionNumberLab.frame) + message_top, message_size.width, message_size.height);

    
    
    CGFloat date_top = 62;
    CGFloat date_right = 10;
    CGSize date_size = [ZPFLableOperation sizeWithText:_dateString maxSize:CGSizeMake(CGFLOAT_MAX, DATE_FONT) font:[UIFont systemFontOfSize:DATE_FONT]];
    CGFloat date_X = [UIScreen mainScreen].bounds.size.width - date_right - date_size.width;
    
    _dateLab.frame = CGRectMake(date_X, date_top, date_size.width, date_size.height);
    
}

@end