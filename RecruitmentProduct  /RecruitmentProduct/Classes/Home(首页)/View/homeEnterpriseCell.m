//
//  homeEnterpriseCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/19.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//
// !!!!!!!!!!!!!!!!!!!!!!!  企业首页人才推荐cell！！！！！！！！！！！！！！！！！！

#import "homeEnterpriseCell.h"
#import "UIView+ZYFrame.h"
#import "Common.h"

#define littleFont [UIFont systemFontOfSize:12]
#define margin 17
@interface homeEnterpriseCell ()
/**
 *  头像图标
 */
@property (nonatomic, strong) UIImageView *iconImageV;
/**
 *  主标题
 */
@property (nonatomic, strong) UILabel *titleLab;
/**
 *  基本信息
 */
@property (nonatomic, strong) UILabel *infoLab;
/**
 *  事件日期
 */
@property (nonatomic, strong) UILabel *dateLab;
/**
 *  技能特长
 */
@property (nonatomic, strong) UILabel *specialtyLab;
@end



@implementation homeEnterpriseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.height = 89;
        [self setUpSubViews];
        self.separatorInset = UIEdgeInsetsMake(0, 10, 0, -10);
    }
    return self;
}


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"EnterpriseCell";

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
    //基本信息
    _infoLab = [[UILabel alloc] init];
    _infoLab.text = @"王贾贾/男/23岁/上海/本科/3年工作经验";
    [self addSubview:_infoLab];
    // 技能特长
    _specialtyLab = [[UILabel alloc] init];
    _specialtyLab.text = @"三年的iOS开发经验，熟练掌握OC,熟练使用MVC,MVVM,MVP等主流设计框架";
    [self addSubview:_specialtyLab];
    // 日期
    _dateLab = [[UILabel alloc] init];
    _dateLab.text = @"03.03";
    [self addSubview:_dateLab];
}
-(void)layoutSubviews{
    _iconImageV.width = 55;
    _iconImageV.height = 55;
    _iconImageV.x = 10;
    _iconImageV.y = margin;
    _iconImageV.layer.cornerRadius =  _iconImageV.height/2;
    _iconImageV.clipsToBounds = YES;
    
    _titleLab.y = margin;
    _titleLab.x = CGRectGetMaxX(_iconImageV.frame) + 10;
    [_titleLab setFont:[UIFont systemFontOfSize:16]];
    _titleLab.textColor = [UIColor blackColor];
    [_titleLab sizeToFit];
    
    _infoLab.x = _titleLab.x;
    _infoLab.y = CGRectGetMaxY(_titleLab.frame) + 5;
    _infoLab.font = littleFont;
    _infoLab.textColor = [UIColor grayColor];
    [_infoLab sizeToFit];
    
    _specialtyLab.x= _titleLab.x;
    _specialtyLab.font = [UIFont systemFontOfSize:10];
    _specialtyLab.textColor = [UIColor grayColor];
    [_specialtyLab sizeToFit];
    _specialtyLab.width = screenW - _specialtyLab.x;
    _specialtyLab.y = CGRectGetMaxY(_iconImageV.frame) - _specialtyLab.height;

    _dateLab.font = [UIFont systemFontOfSize:10];
    [_dateLab sizeToFit];
    _dateLab.textColor = [UIColor grayColor];
    _dateLab.x = screenW - 10 - _dateLab.width;
    _dateLab.y = _iconImageV.y;
    
}
@end
