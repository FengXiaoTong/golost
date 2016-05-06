//
//  HrTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/7.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "HrTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZPFLableOperation.h"

//#import "UIView+ZYFrame.h"


#define TITLE_FONT 17
#define LETTER_FONT 13
#define DATE_FONT 11


@interface HrTableViewCell ()
//设置图标
@property (nonatomic, strong) UIImageView *iconImageV;
//公司名称
@property (nonatomic, strong) UILabel *titleLab;
//详情
@property (nonatomic, strong) UILabel *letterLab;
//日期
@property (nonatomic, strong) UILabel *dateLab;

@property (nonatomic, copy) NSString *dateString;

//@property (nonatomic, assign) BOOL isSlided;

@end

@implementation HrTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self custom];
    }
    return self;
}

- (void)custom{

    _iconImageV = [[UIImageView alloc] init];
    _iconImageV.layer.cornerRadius = 15;
    _iconImageV.clipsToBounds = YES;
    [self.contentView addSubview:_iconImageV];

    _titleLab = [[UILabel alloc] init];
    _titleLab.font = [UIFont systemFontOfSize:TITLE_FONT];
    [self.contentView addSubview:_titleLab];
    
    _letterLab = [[UILabel alloc] init];
    _letterLab.font = [UIFont systemFontOfSize:LETTER_FONT];
    [self.contentView addSubview:_letterLab];
    
    _dateLab = [[UILabel alloc] init];
    _dateLab.font = [UIFont systemFontOfSize:DATE_FONT];
    [self.contentView addSubview:_dateLab];
}

-(void)setModel:(ZPFHrLetterModel *)model {
    
    _model = model;
    
        
    [_iconImageV sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"details_mr"]];

    _titleLab.text = _model.sendPerson;
    
    _letterLab.text = _model.lettersContent;

    if ([_model.sendTime isEqualToString:@""]) {
        _dateString = @"";
    }else {
        NSRange range = {0,10};
        _dateString = [_model.sendTime substringWithRange:range];
    }
    _dateLab.text = _dateString;

}

#pragma mark - private actions


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat icon_top = 16;
    CGFloat icon_left = 10;
    CGSize icon_size = CGSizeMake(56, 56);
    
    _iconImageV.frame = CGRectMake(icon_left, icon_top, icon_size.width, icon_size.height);
    
    
    CGFloat title_top = 21;
    CGFloat title_left = 10;
    CGSize title_size = [ZPFLableOperation sizeWithText:_model.sendPerson maxSize:CGSizeMake(CGFLOAT_MAX, TITLE_FONT) font:[UIFont systemFontOfSize:TITLE_FONT]];
    _titleLab.frame = CGRectMake(CGRectGetMaxX(_iconImageV.frame) + title_left, title_top, title_size.width, title_size.height);
    
    
    CGFloat letter_top = 11;
//    CGFloat letter_left = 10;
    CGFloat letter_width_Max = [UIScreen mainScreen].bounds.size.width - CGRectGetMinX(_titleLab.frame);

    _letterLab.frame = CGRectMake(CGRectGetMinX(_titleLab.frame), CGRectGetMaxY(_titleLab.frame) + letter_top, letter_width_Max, LETTER_FONT);
    
    
    CGFloat date_top = 21;
    CGFloat date_right = 11;
    CGSize date_size = [ZPFLableOperation sizeWithText:_dateString maxSize:CGSizeMake(CGFLOAT_MAX, DATE_FONT) font:[UIFont systemFontOfSize:DATE_FONT]];
    CGFloat date_X = [UIScreen mainScreen].bounds.size.width - date_right - date_size.width;
    
    _dateLab.frame = CGRectMake(date_X, date_top, date_size.width, date_size.height);

        
}




@end
