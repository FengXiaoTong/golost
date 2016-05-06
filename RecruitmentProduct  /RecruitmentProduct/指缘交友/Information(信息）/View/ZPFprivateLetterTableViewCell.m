//
//  ZPFprivateLetterTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/4.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ZPFprivateLetterTableViewCell.h"
#import "Common.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "ZPFLableOperation.h"


#import "UIView+ZYFrame.h"

#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self

#define UIColorFromRGB(rgbValue, pellucidity) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:pellucidity]

#define NAME_FONT 16
#define NAME_COLOR 0x333333
#define AGE_FONT 12
#define AGE_COLOR 0x666666
#define SIGNATURE_FONT 13
#define DATE_FONT 10



//#define <#macro#>


@interface ZPFprivateLetterTableViewCell ()

//头像
@property (nonatomic, strong) UIImageView *iconIV;
//昵称
@property (nonatomic, strong) UILabel *nameLab;
//年龄
@property (nonatomic, strong) UILabel *ageLab;
//地址
@property (nonatomic, strong) UILabel *addressLab;
//职业
@property (nonatomic, strong) UILabel *professionLab;
//身高
@property (nonatomic, strong) UILabel *heightLab;

//个性签名
@property (nonatomic, strong) UILabel *signatureLab;
//时间
@property (nonatomic, strong) UILabel *dateLab;
//关注
@property (nonatomic, strong) UIButton *attentionBt;
//未读
@property (nonatomic, strong) UILabel *unReadLab;

//个性签名string
@property (nonatomic, copy) NSString *signatureStr;


@property (nonatomic, assign) CGFloat signature_height;

@end




@implementation ZPFprivateLetterTableViewCell

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

- (void)custom {

    //头像
    _iconIV = [[UIImageView alloc] init];
    _iconIV.layer.cornerRadius = 5;
    _iconIV.clipsToBounds = YES;
    [self.contentView addSubview:_iconIV];
    
    //昵称
    _nameLab = [[UILabel alloc] init];
    _nameLab.font = [UIFont systemFontOfSize:NAME_FONT];
    _nameLab.textColor = UIColorFromRGB(NAME_COLOR, 1.0);
    [self.contentView addSubview:_nameLab];
    
    //年龄
    _ageLab = [[UILabel alloc] init];
    _ageLab.font = [UIFont systemFontOfSize:AGE_FONT];
    _ageLab.textColor = UIColorFromRGB(AGE_COLOR, 1.0);
    [self.contentView addSubview:_ageLab];
    
    //地址
    _addressLab = [[UILabel alloc] init];
    _addressLab.font = [UIFont systemFontOfSize:AGE_FONT];
    _addressLab.textColor = UIColorFromRGB(AGE_COLOR, 1.0);
    [self.contentView addSubview:_addressLab];

    //职业
    _professionLab = [[UILabel alloc] init];
    _professionLab.font = [UIFont systemFontOfSize:AGE_FONT];
    _professionLab.textColor = UIColorFromRGB(AGE_COLOR, 1.0);
    [self.contentView addSubview:_professionLab];

    //身高
    _heightLab = [[UILabel alloc] init];
    _heightLab.font = [UIFont systemFontOfSize:AGE_FONT];
    _heightLab.textColor = UIColorFromRGB(AGE_COLOR, 1.0);
    [self.contentView addSubview:_heightLab];

    //个性签名
    _signatureLab = [[UILabel alloc] init];
    _signatureLab.numberOfLines = 2;
    _signatureLab.textColor = UIColorFromRGB(NAME_COLOR, 1.0);
    _signatureLab.font = [UIFont systemFontOfSize:SIGNATURE_FONT];
    [self.contentView addSubview:_signatureLab];

    //时间
    _dateLab = [[UILabel alloc] init];
    _dateLab.font = [UIFont systemFontOfSize:DATE_FONT];
    _dateLab.textColor = UIColorFromRGB(AGE_COLOR, 1.0);
    [self.contentView addSubview:_dateLab];
    
    //关注
    _attentionBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_attentionBt setTitle:@"关注" forState:UIControlStateNormal];
    [_attentionBt addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_attentionBt setBackgroundImage:[[UIImage imageNamed:@"n_btn_attention"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_attentionBt setBackgroundImage:[UIImage imageNamed:@"n_brn_yiguanzhu"] forState:UIControlStateSelected];
    [self.contentView addSubview:_attentionBt];
    
    //未读
    _unReadLab = [[UILabel alloc] init];
    _unReadLab.backgroundColor = [UIColor redColor];
    _unReadLab.layer.cornerRadius = 2;
    _unReadLab.clipsToBounds = YES;
    
    
}

- (NSMutableAttributedString *)positionNumber:(NSString *)string withSize:(CGFloat)size {
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange colorRange = NSMakeRange(0, [[noteStr string] rangeOfString:@"："].location+1);
    [noteStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(NAME_COLOR, 1.0) range:colorRange];
    return noteStr;
}

-(void)privateLetterSetModel:(ZPFprivateLetterModel *)model {

    self.model = model;
    if (!_model.signature) {
        _signatureStr = [NSString stringWithFormat:@"个性签名：%@",_model.signature];
    }
    _signatureLab.text = _signatureStr;
    _signature_height = SIGNATURE_FONT*2+6;
}


-(void)setModel:(ZPFprivateLetterModel *)model {
    _model = model;
    
    [_iconIV sd_setImageWithURL:[NSURL URLWithString:_model.minAvatar] placeholderImage:[UIImage imageNamed:@"moren"]];
    
    _nameLab.text = _model.nickName;
    
    _ageLab.text = [NSString stringWithFormat:@"%ld岁",_model.birthday];
    _addressLab.text = _model.resideCityName;
    _professionLab.text = _model.occupation;
    _heightLab.text = _model.heightAnd;
    _dateLab.text = _model.sendTime;
    
    if ([_model.exitAttentionRecord isEqualToString:@"1"]) {
        _attentionBt.selected = YES;
    }else {
        _attentionBt.selected = NO;
    }
    
    
    //如果未读，贴上一个红色label，否则把label从父视图remove掉
    if ([model.isRead isEqualToString:@"02"] && ![_unReadLab.superview isEqual:self.contentView]) {
        [self unRead];
    }else if ([model.isRead isEqualToString:@"01"] && [_unReadLab.superview isEqual:self.contentView]){
        
        [_unReadLab removeFromSuperview];
    }

}


- (void)buttonAction:(UIButton *)button {
    if (button.isSelected) {
        button.selected = NO;
    }else {
        button.selected = YES;
    }
    
}


-(void)unRead {
    
    WS(weakSelf);

    [self.contentView addSubview:_unReadLab];
    [_unReadLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(8);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-6);
        make.size.mas_equalTo(CGSizeMake(4, 4));
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    WS(weakSelf);
    
    //头像
    [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView).offset(7);
        make.left.mas_equalTo(weakSelf.contentView).offset(6);
        make.size.mas_equalTo(CGSizeMake(105, 105));
    }];

    
    //昵称
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView).offset(11);
        make.left.mas_equalTo(_iconIV.mas_right).offset(10);
        make.right.mas_equalTo(weakSelf.contentView).offset(-10);
        make.height.mas_equalTo(AGE_FONT);
    }];
    
   //年龄
    CGFloat age_width = [ZPFLableOperation sizeWithText:[NSString stringWithFormat:@"%ld岁",_model.birthday] maxSize:CGSizeMake(CGFLOAT_MAX, AGE_FONT) font:[UIFont systemFontOfSize:AGE_FONT]].width+1;
    [_ageLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLab.mas_bottom).offset(12);
        make.left.mas_equalTo(_iconIV.mas_right).offset(10);
        make.width.mas_equalTo(age_width);
        make.height.mas_equalTo(AGE_FONT);
    }];
    
     //地址
    CGFloat address_width = [ZPFLableOperation sizeWithText:_model.resideCityName maxSize:CGSizeMake(CGFLOAT_MAX, AGE_FONT) font:[UIFont systemFontOfSize:AGE_FONT]].width;
    [_addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLab.mas_bottom).offset(12);
        make.left.mas_equalTo(_ageLab.mas_right).offset(15);
        make.width.mas_equalTo(address_width);
        make.height.mas_equalTo(AGE_FONT);
    }];
    
    //职业
    CGFloat profession_width = [ZPFLableOperation sizeWithText:_model.occupation maxSize:CGSizeMake(CGFLOAT_MAX, AGE_FONT) font:[UIFont systemFontOfSize:AGE_FONT]].width;
    [_professionLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLab.mas_bottom).offset(12);
        make.left.mas_equalTo(_addressLab.mas_right).offset(15);
        make.width.mas_equalTo(profession_width);
        make.height.mas_equalTo(AGE_FONT);
    }];

    //身高
    [_heightLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLab.mas_bottom).offset(12);
        make.left.mas_equalTo(_professionLab.mas_right).offset(15);
        make.right.mas_equalTo(weakSelf.contentView).offset(-10);
        make.height.mas_equalTo(AGE_FONT);
    }];
    
    
    //个性签名
    [_signatureLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ageLab.mas_bottom).offset(13);
        make.left.mas_equalTo(_iconIV.mas_right).offset(10);
        make.right.mas_equalTo(weakSelf.contentView).offset(-10);
        make.height.mas_equalTo(_signature_height);
    }];

    
    //时间
    [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_signatureLab.mas_bottom).offset(12);
        make.left.mas_equalTo(_iconIV.mas_right).offset(10);
        make.right.mas_equalTo(_attentionBt.mas_left).offset(10);
        make.height.mas_equalTo(DATE_FONT);
    }];

    
    //关注按钮
    [_attentionBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-6);
        make.right.mas_equalTo(weakSelf.contentView).offset(-9);
        make.size.mas_equalTo(CGSizeMake(53, 22.5));
    }];

}


@end
