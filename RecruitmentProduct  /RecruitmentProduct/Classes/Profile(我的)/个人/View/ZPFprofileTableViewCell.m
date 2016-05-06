//
//  ZPFprofileTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/19.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ZPFprofileTableViewCell.h"
#import "ZPFLableOperation.h"
#import "Common.h"

#define TITLE_FONT 15




@interface ZPFprofileTableViewCell () {

    UIImageView *_iconImageV;
    UILabel *_titleLabel;
    UIImageView *_indicatorImageV;


}

@end


@implementation ZPFprofileTableViewCell


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
    [self.contentView addSubview:_iconImageV];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = Color(100, 100, 100);
    _titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT];
    [self.contentView addSubview:_titleLabel];
    
    _indicatorImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:_indicatorImageV];
    
}

-(void)setModel:(ZPFprofileModel *)model {
    
    _model = model;
    
    _iconImageV.image = [UIImage imageNamed:model.iconName];
    _titleLabel.text = model.title;
    _indicatorImageV.image = [UIImage imageNamed:model.indicatorName];

}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGFloat icon_top = 18.0;
    CGFloat icon_left = 22.0;
    CGFloat icon_width = 26.0;
    CGFloat icon_hight = 26.0;
    
    _iconImageV.frame = CGRectMake(icon_left, icon_top, icon_width, icon_hight);


    CGFloat title_top = 23.0;
    CGFloat title_left = 11.0;
    CGSize size = [ZPFLableOperation sizeWithText:_model.title maxSize:CGSizeMake(CGFLOAT_MAX, TITLE_FONT) font:[UIFont systemFontOfSize:TITLE_FONT]];
    
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_iconImageV.frame) + title_left, title_top, size.width, size.height);
    
    CGFloat indicator_top = 21.0;
    CGFloat indicator_right = 31.0;
    CGSize indicator_size = CGSizeMake(9, 15);
    CGFloat indicator_X = CGRectGetMaxX(self.contentView.frame) - indicator_right - indicator_size.width;
    _indicatorImageV.frame = CGRectMake(indicator_X, indicator_top, indicator_size.width, indicator_size.height);

}

@end
