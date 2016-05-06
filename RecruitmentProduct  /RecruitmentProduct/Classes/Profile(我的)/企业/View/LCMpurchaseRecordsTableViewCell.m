//
//  LCMpurchaseRecordsTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/26.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMpurchaseRecordsTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZPFLableOperation.h"
#import "Common.h"
#import "UIView+ZYFrame.h"


#define TITLE_FONT 17
#define PAY_FONT 16
#define NAME_FONT 13
#define INFO_FONT 11
#define EDUCATIONAL_FONT 11
#define DATE_FONT 11

#define littleFont [UIFont systemFontOfSize:12]
#define margin 15
#define TITLECOLOSCM  [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0]
#define TITLECOLOSCY  [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0]



@interface LCMpurchaseRecordsTableViewCell ()
//显示头像
@property (nonatomic, strong) UIImageView *iconImage;
//显示简历名称
@property (nonatomic ,strong) UILabel *positionLabel;
//显示时间
@property (nonatomic, strong) UILabel *timeLabel;
//名字
@property (nonatomic, strong) UILabel *nameLabel;
//性别
@property (nonatomic, strong) UILabel *genderLabel;
//年龄
@property (nonatomic, strong) UILabel *ageLabel;
//地址
@property (nonatomic, strong) UILabel *addressLabel;
//学历
@property (nonatomic, strong) UILabel *educationLabel;
//工作经验
@property (nonatomic, strong) UILabel *workExperience;
//介绍
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, copy) NSString *str;
@end

@implementation LCMpurchaseRecordsTableViewCell

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
    
    _iconImage = [[UIImageView alloc] init];
    _iconImage.layer.cornerRadius = 15;
    [self.contentView addSubview:_iconImage];
    
    _positionLabel = [[UILabel alloc] init];
    _positionLabel.font = [UIFont systemFontOfSize:TITLE_FONT];
    _positionLabel.textColor = Color(80, 80, 80);
    [self.contentView addSubview:_positionLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:DATE_FONT];
    _timeLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_timeLabel];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _nameLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_nameLabel];
    
    _ageLabel = [[UILabel alloc] init];
    _ageLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _ageLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_ageLabel];
 
    _genderLabel = [[UILabel alloc] init];
    _genderLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _genderLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_genderLabel];
    
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _addressLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_addressLabel];
    
    _educationLabel = [[UILabel alloc] init];
    _educationLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _educationLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_educationLabel];
    
    _workExperience = [[UILabel alloc] init];
    _workExperience.font = [UIFont systemFontOfSize:NAME_FONT];
    _workExperience.textColor = Color(100, 100, 100);
    [self.contentView addSubview: _workExperience];
    
    _introduceLabel = [[UILabel alloc] init];
    _introduceLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _introduceLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_introduceLabel];
    
    

}
-(void)setModel:(LCMpurchaseRecordsModel *)model {


    _model = model;
    [_iconImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"moren"]];
   //职位名称
    _positionLabel.text = _model.resumeName;
    //购买时间
    _str = [_model.paidTime substringToIndex:19];
    _timeLabel.text = _str;
    //名字
    _nameLabel.text = _model.personName;
    //性别
    _genderLabel.text = _model.personSex;
    //年龄
    _ageLabel.text = [NSString stringWithFormat:@"%ld",(long)_model.birthdayStr];
    //地址
    _addressLabel.text = _model.nowAddress;
    //学历
    _educationLabel.text = _model.degree;
    //工作经验
    _workExperience.text= _model.jobBeginYearStr;
    //自我评价标题
    _introduceLabel.text  = _model.commentTitle;
    
    
}
- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat icon_top = 13.0;
    CGFloat icon_left = 16.0;
    CGSize icon_size = CGSizeMake(56, 56);
    
    _iconImage.frame =  CGRectMake(icon_left, icon_top, icon_size.width, icon_size.height);
    
    CGFloat title_top = 13;
    CGFloat title_left = 11;
    CGFloat time_right = 13;
    CGFloat  gap = 6;
    CGSize title_size = [ZPFLableOperation sizeWithText:_model.resumeName maxSize:CGSizeMake(CGFLOAT_MAX, TITLE_FONT) font:[UIFont systemFontOfSize:TITLE_FONT]];
    _positionLabel.frame = CGRectMake(CGRectGetMaxX(_iconImage.frame) + title_left, title_top, title_size.width, title_size.height);
    
    CGSize time_size = [ZPFLableOperation sizeWithText:_str maxSize:CGSizeMake(CGFLOAT_MAX, DATE_FONT) font:[UIFont systemFontOfSize:DATE_FONT]];
    _timeLabel.frame = CGRectMake(screenW - time_right - time_size.width, title_top, time_size.width, time_size.height);
//    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_positionLabel.frame) + gap, title_top, time_size.width, time_size.height);
    
    CGSize name_size = [ZPFLableOperation sizeWithText:_model.personName maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_iconImage.frame) + title_left, CGRectGetMaxY(_positionLabel.frame) + gap, name_size.width, name_size.height);
   
    CGSize gender_size = [ZPFLableOperation sizeWithText:_model.personSex maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _genderLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame) + gap, CGRectGetMaxY(_positionLabel.frame) + gap, gender_size.width, gender_size.height);

    
    CGSize age_size = [ZPFLableOperation sizeWithText:[NSString stringWithFormat:@"%ld",(long)_model.birthdayStr] maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _ageLabel.frame = CGRectMake(CGRectGetMaxX(_genderLabel.frame) + gap, CGRectGetMaxY(_positionLabel.frame) + gap, age_size.width,age_size.height);
    
    
    CGSize address_size = [ZPFLableOperation sizeWithText:_model.nowAddress maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _addressLabel.frame = CGRectMake(CGRectGetMaxX(_ageLabel.frame) + gap, CGRectGetMaxY(_positionLabel.frame) + gap, address_size.width, address_size.height);
    
    CGSize education_size = [ZPFLableOperation sizeWithText:_model.degree maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _educationLabel.frame = CGRectMake(CGRectGetMaxX(_addressLabel.frame) + gap, CGRectGetMaxY(_positionLabel.frame) + gap, education_size.width, education_size.height);
    
    CGSize workExper_size = [ZPFLableOperation sizeWithText:_model.jobBeginYearStr maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _workExperience.frame = CGRectMake(CGRectGetMaxX(_educationLabel.frame) + gap, CGRectGetMaxY(_positionLabel.frame)  + gap, workExper_size.width, workExper_size.height);
    
    CGSize introduce_size = [ZPFLableOperation sizeWithText:_model.commentTitle maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _introduceLabel.frame = CGRectMake(CGRectGetMaxX(_iconImage.frame) + title_left, CGRectGetMaxY(_nameLabel.frame) + gap, introduce_size.width, introduce_size.height);


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
