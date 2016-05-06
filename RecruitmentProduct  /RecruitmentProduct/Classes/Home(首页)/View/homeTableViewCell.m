//
//  homeTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/5.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//
// !!!!!!!!!!!!!!!!!!!!!!!个人首页cell！！！！！！！！！！！！！！！！！！！！！！

#import "homeTableViewCell.h"
#import "UIView+ZYFrame.h"
#import "Common.h"
#define littleFont [UIFont systemFontOfSize:12]
#define margin 17

@interface homeTableViewCell ()
/**
 *  头像图标
 */
@property (nonatomic, strong) UIImageView *iconImageV;
/**
 *  主标题
 */
@property (nonatomic, strong) UILabel *titleLab;
/**
 *  公司名称
 */
@property (nonatomic, strong) UILabel *nameLab;
/**
 *  地区名称
 */
@property (nonatomic, strong) UILabel *infoLab;

@property (nonatomic, strong) UIImageView *locationImaView;

@property (nonatomic, strong) UIButton *locationBtn;
/**
 *  学历图
 */
@property (nonatomic, strong) UIImageView *educationImaView;
/**
 *  学历名称
 */
@property (nonatomic, strong) UILabel *educationLab;
/**
 *  日期
 */
@property (nonatomic, strong) UIImageView *dateImaView;
@property (nonatomic, strong) UILabel *dateLab;
/**
 *  薪资
 */
@property (nonatomic, strong) UILabel *payLab;
@end




@implementation homeTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.height = 89;
        [self setUpSubViews];
       
    }
    return self;
}


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    return cell;
}

-(void)setUpSubViews{
    // 图标
    UIImageView *iconImageV = [[UIImageView alloc] init];
    iconImageV.image = [UIImage imageNamed:@"details_mr"];
    [self addSubview:iconImageV];
    _iconImageV = iconImageV;
    // 主标题
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"iOS高级工程师";
    [self addSubview:titleLab];
    _titleLab = titleLab;
    // 公司名称
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = @"润升信息技术";
    [self addSubview:nameLab];
    _nameLab = nameLab;
    // 地区图标
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locationBtn.backgroundColor = [UIColor clearColor];
    
    UIImageView *locationImaView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_tuijian_icon_1"]];
    [self addSubview:locationImaView];
    [locationImaView addSubview:locationBtn];
    _locationImaView = locationImaView;
    _locationBtn = locationBtn;
    // 地区名称
    UILabel *infoLab = [[UILabel alloc] init];
    infoLab.text = @"河南郑州";
    [self addSubview:infoLab];
    _infoLab = infoLab;
    
    // 学历图
    UIImageView *educationImaView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_tuijian_icon_2"]];
    [self addSubview:educationImaView];
    _educationImaView = educationImaView;
    
    UILabel *educationLab = [[UILabel alloc] init];
    educationLab.text = @"本科";
    [self addSubview:educationLab];
    _educationLab = educationLab;
    
    // 日期
    UILabel *dateLab = [[UILabel alloc] init];
    dateLab.text = @"2016.03.03";
    [self addSubview:dateLab];
    _dateLab = dateLab;
    
    UIImageView *dateImaView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_tuijian_icon_3"]];
    [self addSubview:dateImaView];
    _dateImaView = dateImaView;
    // 薪资
    UILabel *payLab = [[UILabel alloc] init];
    payLab.text = @"1千-2千";
    [self addSubview:payLab];
    _payLab = payLab;
}
-(void)layoutSubviews{
    
    _iconImageV.width = 55;
    _iconImageV.height = 55;
    _iconImageV.x = 10;
    _iconImageV.y = margin;
    _iconImageV.layer.cornerRadius = 10;
    _iconImageV.clipsToBounds = YES;
    
    _titleLab.y = margin;
    _titleLab.x = CGRectGetMaxX(_iconImageV.frame) + 10;
    [_titleLab setFont:[UIFont systemFontOfSize:16]];
    _titleLab.textColor = [UIColor blackColor];
    [_titleLab sizeToFit];
    
    _nameLab.x = _titleLab.x;
    _nameLab.y = CGRectGetMaxY(_titleLab.frame)+5;
    _nameLab.font = littleFont;
    _nameLab.textColor = [UIColor grayColor];
    [_nameLab sizeToFit];
    
    _locationImaView.x = _titleLab.x;
    [_locationImaView sizeToFit];
    _locationImaView.y =  CGRectGetMaxY(_iconImageV.frame) - _locationImaView.height;
    _locationBtn.frame = _locationImaView.frame;
   
    
    _infoLab.x = CGRectGetMaxX(_locationImaView.frame) + 5;
    _infoLab.y = _locationImaView.y;
    _infoLab.font = [UIFont systemFontOfSize:11];
    _infoLab.textColor = [UIColor grayColor];
    [_infoLab sizeToFit];
    
    _educationImaView.x = CGRectGetMaxX(_infoLab.frame) + 15;
    [_educationImaView sizeToFit];
    _educationImaView.y = _infoLab.y;
    
    _educationLab.x = CGRectGetMaxX(_educationImaView.frame) + 5;
    _educationLab.y = _infoLab.y;
    _educationLab.textColor = [UIColor grayColor];
    _educationLab.font = [UIFont systemFontOfSize:11];
    [_educationLab sizeToFit];
    
    _dateLab.font = littleFont;
    _dateLab.textColor = [UIColor grayColor];
     [_dateLab sizeToFit];

    _dateLab.y = _titleLab.y;
    _dateLab.x = screenW - _dateLab.width-margin;
   
    
    [_payLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    _payLab.textColor = [UIColor grayColor];

    _dateLab.y = _infoLab.y;
    _dateLab.x = screenW - _dateLab.width-margin;
    
    
    _dateImaView.x = _dateLab.x - 5 - _dateImaView.width;
    [_dateImaView sizeToFit];
    _dateImaView.y = _infoLab.y;
    
    [_payLab setFont:[UIFont systemFontOfSize:16]];
    _payLab.textColor = [UIColor redColor];

     [_payLab sizeToFit];
    _payLab.y = _nameLab.y;
    _payLab.x = screenW - _payLab.width -margin;
   
    
}


@end
