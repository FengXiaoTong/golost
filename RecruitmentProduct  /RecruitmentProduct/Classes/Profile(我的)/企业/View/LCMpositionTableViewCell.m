//
//  LCMpositionTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/26.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMpositionTableViewCell.h"
#import "ZPFLableOperation.h"
#import <UIImageView+WebCache.h>
#import "Common.h"

#define TITLE_FONT 17

#define NAME_FONT 13

@interface LCMpositionTableViewCell ()
//职位名称
@property (nonatomic, strong) UILabel *positonLabel;
//地点
@property (nonatomic, strong) UIImageView *addressImage;
@property (nonatomic, strong) UILabel *addessLabel;
//浏览数
@property (nonatomic, strong) UIImageView *browseImage;
@property (nonatomic, strong) UILabel *browseLabel;
//申请数
@property (nonatomic, strong) UIImageView *applyImage;
@property (nonatomic, strong) UILabel *applyLabel;
//刷新时间
@property (nonatomic, strong) UIImageView *refreshImage;
@property (nonatomic, strong) UILabel *refreshLabel;
//有效时间
@property (nonatomic, strong) UIImageView *effectiveImage;
@property (nonatomic, strong) UILabel *effectiveLabel;

//虚线
@property (nonatomic, strong) UIImageView *xuxianImage;

@property (nonatomic, strong) NSString *string;
@end

@implementation LCMpositionTableViewCell

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
    
    _positonLabel = [[UILabel alloc] init];
    _positonLabel.font = [UIFont systemFontOfSize:TITLE_FONT];
    _positonLabel.textColor = Color(80, 80,80);
    [self.contentView addSubview:_positonLabel];
    
    _addressImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_addressImage];
    
    _addessLabel = [[UILabel alloc] init];
    _addessLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _addessLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_addessLabel];
    
    
    _browseImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_browseImage];
    
    _browseLabel = [[UILabel alloc] init];
    _browseLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _browseLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_browseLabel];
    
    _applyImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_applyImage];
    
    _applyLabel = [[UILabel alloc] init];
    _applyLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _applyLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_applyLabel];
    
    _refreshImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_refreshImage];
    
    _refreshLabel = [[UILabel alloc] init];
    _refreshLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _refreshLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_refreshLabel];
    
    _effectiveImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_effectiveImage];
    
    _effectiveLabel  = [[UILabel alloc] init];
    _effectiveLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _effectiveLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview: _effectiveLabel];
    
    _xuxianImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_xuxianImage];
    

}
- (void)setModel:(LCMpositionModel *)model {

    _model = model;
    
    _positonLabel.text = _model.jobName;
    
    [_addressImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"place"]];
    
    _addessLabel.text = _model.publishAreaName;
    
    [_browseImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"liulan"]];
    _browseLabel.attributedText = [self positionNumber:[NSString stringWithFormat:@"%@人浏览",_model.countResumeNum] withSize:TITLE_FONT];
    
    [_applyImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"shenqing"]];
    
    
    _applyLabel.attributedText = [self positionNumber:[NSString stringWithFormat:@"%ld人申请",_model.personCount] withSize:TITLE_FONT];
    
    [_xuxianImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"xuxian"]];
    
    [_refreshImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"shuaxin"]];
    //NSString *string = [_model.updateDate substringToIndex:18];
    _refreshLabel.text = [NSString stringWithFormat:@"刷新时间：%@",_model.updateDate];
    
    [_effectiveImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"youxiao"]];
    _string  = [_model.createDate stringByAppendingString:_model.finallyDate];
    
    _effectiveLabel.text = [NSString stringWithFormat:@"有效时间：%@-%@",_model.createDate,_model.finallyDate];
    

}
- (NSMutableAttributedString *)positionNumber:(NSString *)string withSize:(CGFloat)size {
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@"人"].location);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:redRange];
    return noteStr;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat  title_top = 13.0;//上边距
    CGFloat title_left = 10.0;//左边距
    CGFloat gap = 14;//第一行与第二行间距
    CGFloat gaps = 6;//图片与文字的间距
    CGFloat image_gap = 10.0;//文字距离图片
    CGFloat xuxian_title = 8;//虚线距离文字
    CGFloat picture_picture = 10;
    CGSize position_size = [ZPFLableOperation sizeWithText:_model.jobName maxSize:CGSizeMake(CGFLOAT_MAX, TITLE_FONT) font:[UIFont systemFontOfSize:TITLE_FONT]];
    _positonLabel.frame = CGRectMake(title_left, title_top, position_size.width, position_size.height);
    
    CGSize iconaddr_size = CGSizeMake(9, 13);
    _addressImage.frame = CGRectMake(title_left, CGRectGetMaxY(_positonLabel.frame) + gap , iconaddr_size.width, iconaddr_size.height);
    
    CGSize address_size = [ZPFLableOperation sizeWithText:_model.publishAreaName maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT + 4) font:[UIFont systemFontOfSize:NAME_FONT]];
    _addessLabel.frame = CGRectMake(CGRectGetMaxX(_addressImage.frame) + gaps, CGRectGetMaxY(_positonLabel.frame) + gap, address_size.width, address_size.height);
    
    CGSize iconbrowse_size = CGSizeMake(13, 11);
    _browseImage.frame = CGRectMake(CGRectGetMaxX(_addessLabel.frame)  + image_gap, CGRectGetMaxY(_positonLabel.frame) + gap, iconbrowse_size.width, iconbrowse_size.height);
    
    CGSize browse_size = [ZPFLableOperation sizeWithText:[NSString stringWithFormat:@"      %ld人浏览",_model.seeCount] maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _browseLabel.frame = CGRectMake(CGRectGetMaxX(_browseImage.frame) + gaps , CGRectGetMaxY(_positonLabel.frame) + gap, browse_size.width, browse_size.height);
    
    CGSize iconapply_size = CGSizeMake(10, 12);
    _applyImage.frame = CGRectMake(CGRectGetMaxX(_browseLabel.frame) + image_gap, CGRectGetMaxY(_positonLabel.frame) + gap, iconapply_size.width, iconapply_size.height);
    
    CGSize apply_size = [ZPFLableOperation sizeWithText:[NSString stringWithFormat:@"     %@人申请",_model.countResumeNum] maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _applyLabel.frame = CGRectMake(CGRectGetMaxX(_applyImage.frame) + gaps, CGRectGetMaxY(_positonLabel.frame) + gap, apply_size.width, apply_size.height);
    
    CGSize xuxianIcon_size = CGSizeMake(356, 1);
    _xuxianImage.frame = CGRectMake(title_left, CGRectGetMaxY(_addessLabel.frame) + xuxian_title, xuxianIcon_size.width, xuxianIcon_size.height);
   //刷新时间
    CGSize refreshIcon_size = CGSizeMake(10, 10);
    _refreshImage.frame = CGRectMake(title_left, CGRectGetMaxY(_xuxianImage.frame) + xuxian_title, refreshIcon_size.width, refreshIcon_size.height);
    CGSize reresh_size = [ZPFLableOperation sizeWithText:[NSString stringWithFormat:@"刷新时间：%@",_model.updateDate] maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _refreshLabel.frame = CGRectMake(CGRectGetMaxX(_refreshImage.frame) + gaps, CGRectGetMaxY(_xuxianImage.frame) + gaps, reresh_size.width, reresh_size.height);
    //有效时间
    CGSize effective_size = CGSizeMake(10, 10);
    _effectiveImage.frame = CGRectMake(title_left, CGRectGetMaxY(_refreshImage.frame) + picture_picture, effective_size.width, effective_size.height);
    CGSize effect_size = [ZPFLableOperation sizeWithText:[NSString stringWithFormat:@"有效时间：%@-%@",_model.createDate,_model.finallyDate] maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _effectiveLabel.frame = CGRectMake(CGRectGetMaxX(_effectiveImage.frame) + gaps, CGRectGetMaxY(_refreshLabel.frame) + gaps, effect_size.width, effect_size.height);
    
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
