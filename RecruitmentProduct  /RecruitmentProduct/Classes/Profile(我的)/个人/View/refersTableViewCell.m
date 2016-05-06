//
//  refersTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/12.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "refersTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZPFLableOperation.h"


#import "Common.h"
//#import "UIView+ZYFrame.h"

#define LABLE_FONT 15

@interface refersTableViewCell ()

@property (nonatomic, strong) UILabel *messageLab;

@property (nonatomic, strong) UILabel *countLab;

@property (nonatomic, strong) UILabel *dateLab;

@property (nonatomic, copy) NSString *dateString;

@property (nonatomic, copy) NSString *countString;

@end

@implementation refersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self custom];
    }
    return self;
}

- (void)custom {

    _messageLab = [[UILabel alloc] init];
    _messageLab.font = [UIFont systemFontOfSize:LABLE_FONT];
    _messageLab.numberOfLines = 0;
    [self.contentView addSubview:_messageLab];
    
    _countLab = [[UILabel alloc] init];
    _countLab.font = [UIFont systemFontOfSize:LABLE_FONT];
    _countLab.textColor = [UIColor redColor];
    [self.contentView addSubview:_countLab];
    
    _dateLab = [[UILabel alloc] init];
    _dateLab.font =[UIFont systemFontOfSize:LABLE_FONT];
    [self.contentView addSubview:_dateLab];
}

- (void)setModel:(ZPFrefersModel *)model {

    _model = model;
    
    _messageLab.text = _model.remark;
    _countString = [NSString stringWithFormat:@"+%ld",_model.turnOver];
    _countLab.text = _countString;
    NSRange range = {0,10};
    _dateString = [_model.createDate substringWithRange:range];
    _dateLab.text = _dateString;


}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat message_top = 24;
    CGFloat message_left = 12;
    CGSize message_size = [ZPFLableOperation sizeWithText:_model.remark maxSize:CGSizeMake(screenW/2 - message_left, CGFLOAT_MAX) font:[UIFont systemFontOfSize:LABLE_FONT]];
    _messageLab.frame = CGRectMake(message_left, message_top, message_size.width, message_size.height);
    
    
    CGFloat date_top = 25;
    CGFloat date_right = 10;
    CGSize date_size = [ZPFLableOperation sizeWithText:_dateString maxSize:CGSizeMake(CGFLOAT_MAX, LABLE_FONT) font:[UIFont systemFontOfSize:LABLE_FONT]];
    CGFloat date_X = screenW - date_right - date_size.width;
    _dateLab.frame = CGRectMake(date_X, date_top, date_size.width, date_size.height);
    
    
    CGFloat count_top = 25;
    CGSize count_size = [ZPFLableOperation sizeWithText:_countString maxSize:CGSizeMake(CGFLOAT_MAX, LABLE_FONT) font:[UIFont systemFontOfSize:LABLE_FONT]];
    CGFloat count_X = (CGRectGetMinX(_dateLab.frame) + CGRectGetMaxX(_messageLab.frame))/2;
    _countLab.frame = CGRectMake(count_X, count_top, count_size.width, count_size.height);
    
    

}




@end