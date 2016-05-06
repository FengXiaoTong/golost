//
//  detailCellHeaderView.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/13.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "detailCellHeaderView.h"

#define WMargin 10
#define HMargin 5


@interface detailCellHeaderView ()
/**
 *  职位名称
 */
@property (nonatomic, strong) UILabel *nameLab;
/**
 *  日期
 */
@property (nonatomic, strong) UILabel *dateLab;
/**
 *  地址
 */
@property (nonatomic, strong) UILabel *addressLab;
/**
 *  职位性质
 */
@property (nonatomic, strong) UILabel *natureLab;
/**
 *  职位类型
 */
@property (nonatomic, strong) UILabel *kindLab;
/**
 *  薪资
 */
@property (nonatomic, strong) UILabel *payLab;
/**
 *  学历
 */
@property (nonatomic, strong) UILabel *eduLab;

@end


@implementation detailCellHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)setupSubViews{
   // 名字
    UILabel *nameLab = [[UILabel alloc] init];
    [self addSubview:nameLab];
    _nameLab = nameLab;
   // 日期
    UILabel *dateLab = [[UILabel alloc] init];
    [self addSubview:dateLab];
    _dateLab = dateLab;
   // 黑线
    
    
   // 地址
    UILabel *addressLab = [[UILabel alloc] init];
    [self addSubview:addressLab];
    _addressLab = addressLab;
   // 工作性质
    UILabel *natureLab = [[UILabel alloc] init];
    [self addSubview:natureLab];
    _natureLab = natureLab;
    
    
    // 岗位类别
    UILabel *kindLab = [[UILabel alloc] init];
    [self addSubview:kindLab];
    _kindLab = kindLab;
    //薪资
    UILabel *payLab = [[UILabel alloc] init];
    [self addSubview:payLab];
    _payLab = payLab;
    //学历
    UILabel *eduLab =[[UILabel alloc] init];
    [self addSubview:eduLab];
    _eduLab = eduLab;
    
    // 公司详情
    
    
    // 职位亮点
    
    
    // 任职要求
    
    
    // 投诉/收藏/分享btn
    
    
    
    
}

-(void)layoutSubviews{
    
    
}

@end
