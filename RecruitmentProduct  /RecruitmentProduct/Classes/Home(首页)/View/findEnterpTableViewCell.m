//
//  findEnterpTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/16.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "findEnterpTableViewCell.h"
#import "UIView+ZYFrame.h"
#import "Common.h"

#define littleFont [UIFont systemFontOfSize:12]
#define margin 17


@interface findEnterpTableViewCell ()

/**
 *  头像图标
 */
@property (nonatomic, strong) UIImageView *iconImageV;
/**
 *  主标题
 */
@property (nonatomic, strong) UILabel *titleLab;
/**
 *  亮点职位一
 */
@property (nonatomic, strong) UILabel *firstSpeLab;
/**
 *  亮点职位二
 */
@property (nonatomic, strong) UILabel *secSpeLab;
/**
 *  地点图标
 */
@property (nonatomic, strong) UIImageView *locationImaView;
/**
 *  地点Lab
 */
@property (nonatomic, strong) UILabel *locationLab;
/**
 *  在招职位
 */
@property (nonatomic, strong) UILabel *fixLab;
/**
 *  个数
 */
@property (nonatomic, strong) UILabel *numberLab;

@end

@implementation findEnterpTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    UIImageView *iconImageV = [[UIImageView alloc] init];
    iconImageV.image = [UIImage imageNamed:@"details_mr"];
    [self addSubview:iconImageV];
    _iconImageV = iconImageV;
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.text = @"河南润升信息技术有限公司";
    [self addSubview:_titleLab];
    
    _firstSpeLab = [[UILabel alloc] init];
    _firstSpeLab.text = @"超级xxxxxx工程师";
    [self addSubview:_firstSpeLab];
    
    _secSpeLab = [[UILabel alloc] init];
    _secSpeLab.text = @"不知道写点儿啥";
    [self addSubview:_secSpeLab];
    
    _locationImaView = [[UIImageView alloc] init];
    _locationImaView.image = [UIImage imageNamed:@"details_place"];
    [self addSubview:_locationImaView];
    
    _locationLab = [[UILabel alloc] init];
    _locationLab.text = @"郑州";
    [self addSubview:_locationLab];
    
    _numberLab = [[UILabel alloc] init];
    _numberLab.text = @"2";
    [self addSubview:_numberLab];
    
    _fixLab = [[UILabel alloc] init];
    _fixLab.text = @"个在招职位";
    [self addSubview:_fixLab];
    
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
    
    _firstSpeLab.x = _titleLab.x;
    _firstSpeLab.y = CGRectGetMaxY(_titleLab.frame)+5;
    _firstSpeLab.font = littleFont;
    _firstSpeLab.textColor = [UIColor grayColor];
    [_firstSpeLab sizeToFit];
    
    _secSpeLab.x = _titleLab.x;
    _secSpeLab.y = CGRectGetMaxY(_firstSpeLab.frame) + 5;
    _secSpeLab.font = littleFont;
    _secSpeLab.textColor = [UIColor grayColor];
    [_secSpeLab sizeToFit];
    
     _locationLab.font = littleFont;
    [_locationLab sizeToFit];
    _locationLab.textColor = [UIColor grayColor];
    _locationLab.x = self.width - 10 - _locationLab.width;
    _locationLab.y = _firstSpeLab.y;
    
    [_locationImaView sizeToFit];
    _locationImaView.x = _locationLab.x - 6 - _locationImaView.width;
    _locationImaView.y = _firstSpeLab.y;

}

@end
