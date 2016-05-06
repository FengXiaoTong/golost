//
//  postDetailHeaderView.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/15.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

/**
 *  ！！！！！！！！！！！！！！！职位详情 自定义头部！！！！！！！！！！！！！！！！
 */

#import "postDetailHeaderView.h"
#import "Common.h"
#import "UIView+ZYFrame.h"

// 边距
#define edgeMargin 10
// 标题字
#define titleFont [UIFont systemFontOfSize:15]
// 最小字
#define littleFont [UIFont systemFontOfSize:12]
// 普通字
#define normalFont [UIFont systemFontOfSize:12]

@interface postDetailHeaderView ()
/**
 *  职位名称
 **/
@property (nonatomic, strong) UILabel *postNameLab;
/**
 *  日期
 */
@property (nonatomic, strong) UILabel *dateLab;
/**
 *  灰线
 */
@property (nonatomic, strong) UIView *lineView;
/**
 *  位置图标
 */
@property (nonatomic, strong) UIImageView *locationImageView;
/**
 *  位置lable、
 */
@property (nonatomic, strong) UILabel *locationLab;
/**
 *  薪资
 */
@property (nonatomic, strong) UILabel *payLab;
/**
 *  工作性质
 */
@property (nonatomic, strong) UILabel *kindLab;
/**
 *  所属行业
 */
@property (nonatomic, strong) UILabel *industryLab;
/**
 *  学历|大学时间|招聘人数
 */
@property (nonatomic, strong) UILabel *educationLab;



/**
 *  公司详情btn
 */
@property (nonatomic, strong) UIButton *companyBtn;
/**
 *  公司图标
 */
@property (nonatomic, strong) UIImageView *companyImageView;
/**
 *  公司名称
 */
@property (nonatomic, strong) UILabel *companyNameLab;
/**
 *  网址信息
 */
@property (nonatomic, strong) UILabel *URLLab;
/**
 *  集团名
 */
@property (nonatomic, strong) UILabel *bigCompanyNameLab;
/**
 *  箭头图标
 */
@property (nonatomic, strong) UIImageView *arrow;
/**
 *  透明View
 */
@property (nonatomic, strong) UIView *clearView;
/**
 *  福利标签数组
 */
@property (nonatomic, strong) NSArray *welfareArr;
/**
 *  福利承载view
 */
@property (nonatomic, strong) UIView *welfView;
/**
 *  任职要求背景
 */
@property (nonatomic, strong) UIImageView *postRequireImageView;
/**
 *  任职要求
 */
@property (nonatomic, strong) UITextView *postRequireTextView;
/**
 *  任职要求标题
 */
@property (nonatomic, strong) UILabel *postRequireTitleLab;
/**
 *  收藏按钮
 */
@property (nonatomic, strong) UIButton *collectBtn;
/**
 *  分享btn、
 */
@property (nonatomic, strong) UIButton *shareBtn;
@end


@implementation postDetailHeaderView

-(NSArray *)welfareArr{
    if (_welfareArr == nil) {
        _welfareArr = @[@"五险一金",@"住房补贴",@"双休",@"补充医疗保险",@"采暖补贴",@"带薪休假",@"餐补",@"通讯补贴",@"房补",@"好好学习~~~~"];
    }
    return _welfareArr;
}

+(instancetype)setUpPostDetailHeaderView{
    return [[self alloc] initWithHeaderView];
}


-(instancetype)initWithHeaderView{
    if (self = [super init]) {
         self.height = 500;
        [self setUpSubViews];
        
        
        
    }
    return self;
}



-(void)setUpSubViews{
    // 职位名称
    _postNameLab = [[UILabel alloc] init];
    _postNameLab.text = @"前端设计/iOS开发";
    [self addSubview:_postNameLab];
    //日期
    _dateLab = [[UILabel alloc] init];
    _dateLab.text = @"2016.03.03";
    _dateLab.textColor = deatilMainColor;
     [self addSubview:_dateLab];
    //灰线
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = Color(170, 170, 170);
     [self addSubview:_lineView];
    //位置图标
    _locationImageView = [[UIImageView alloc] init];
    _locationImageView.image =[UIImage imageNamed:@"details_place"];
     [self addSubview:_locationImageView];
    //位置Lab
    _locationLab = [[UILabel alloc] init];
    _locationLab.text = @"河南/郑州/中原区";
    _locationLab.textColor = deatilMainColor;
     [self addSubview:_locationLab];
    //薪资
    _payLab = [[UILabel alloc] init];
    _payLab.text = @"6K-8K";
    _payLab.textColor = [UIColor redColor];
     [self addSubview:_payLab];
    //工作性质
    _kindLab = [[UILabel alloc] init];
    _kindLab.text = @"全职";
    _kindLab.textColor = deatilMainColor;
     [self addSubview:_kindLab];
    // 所属行业
    _industryLab = [[UILabel alloc] init];
    _industryLab.text = @"计算机软件";
    _industryLab.textColor = deatilMainColor;
     [self addSubview:_industryLab];
    // 学历
    _educationLab = [[UILabel alloc] init];
    _educationLab.text = @"本科|10-15年|35人";
    _educationLab.textColor = deatilMainColor;
     [self addSubview:_educationLab];
    // 公司详情--大按钮
    _companyBtn = [[UIButton alloc] init];
    [_companyBtn setImage:[UIImage imageNamed:@"btnBg"] forState:UIControlStateNormal];
    [_companyBtn addTarget:self action:@selector(bigButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_companyBtn];
     //公司图标
    _companyImageView = [[UIImageView alloc] init];
    _companyImageView.image = [UIImage imageNamed:@"details_mr"];
    [_companyBtn addSubview:_companyImageView];
     //公司名称
    _companyNameLab = [[UILabel alloc] init];
    _companyNameLab.text = @"河南润升信息技术";
    [_companyBtn addSubview:_companyNameLab];
    //公司网址
    _URLLab = [[UILabel alloc] init];
    _URLLab.text = @"软件/服务/http://www.baidu.com";
    _URLLab.textColor = deatilMainColor;
    [_companyBtn addSubview:_URLLab];
    //集团名称
    _bigCompanyNameLab = [[UILabel alloc] init];
    _bigCompanyNameLab.text = @"河南润升信息技术";
    _bigCompanyNameLab.textColor = deatilMainColor;
    [_companyBtn addSubview:_bigCompanyNameLab];
    
    // 箭头
    _arrow = [[UIImageView alloc] init];
    _arrow.image = [UIImage imageNamed:@"zwxq_go"];
    [_companyBtn addSubview:_arrow];
    
    // 福利标签
    _welfView = [[UIView alloc] init];
    _welfView.backgroundColor = [UIColor clearColor];
    [self addSubview:_welfView];
    // 任职要求背景图
    _postRequireImageView = [[UIImageView alloc] init];
    _postRequireImageView.image = [UIImage imageNamed:@"btnBg"];
    [self addSubview:_postRequireImageView];
    // 任职要求标题
    _postRequireTitleLab = [[UILabel alloc] init];
    _postRequireTitleLab.text = @"任职要求";
    [_postRequireImageView addSubview:_postRequireTitleLab];
    
    //分享btn
}



-(void)layoutSubviews{
    // 职位名称
    _postNameLab.x = edgeMargin;
    _postNameLab.font = titleFont;
    [_postNameLab sizeToFit];
    _postNameLab.y = 38 - _postNameLab.height;
    //日期
    _dateLab.font = littleFont;
    [_dateLab sizeToFit];
    _dateLab.x = screenW - edgeMargin - _dateLab.width;
    _dateLab.y = 38 - _dateLab.height;
    //白线
    _lineView.x = _postNameLab.x;
    _lineView.y = CGRectGetMaxY(_postNameLab.frame)+ 5;
    _lineView.width = CGRectGetMaxX(_dateLab.frame) - edgeMargin;
    _lineView.height  =1;
    //位置图标
    _locationImageView.x = _postNameLab.x;
    [_locationImageView sizeToFit];
    _locationImageView.y = CGRectGetMaxY(_lineView.frame) + edgeMargin;
    //位置Lab
    _locationLab.x = CGRectGetMaxX(_locationImageView.frame) + 6;
    _locationLab.font = normalFont;
    [_locationLab sizeToFit];
    _locationLab.y = _locationImageView.y;
    // 薪资
    [_payLab sizeToFit];
    _payLab.x = screenW - edgeMargin - _payLab.width;
    _payLab.y = CGRectGetMaxY(_lineView.frame) + edgeMargin;
    // 工作性质
    _kindLab.font = normalFont;
    [_kindLab sizeToFit];
    _kindLab.x = _locationLab.x;
    _kindLab.y = CGRectGetMaxY(_locationLab.frame) + edgeMargin;
    // 所属行业
    _industryLab.font = normalFont;
    [_industryLab sizeToFit];
    _industryLab.x = CGRectGetMaxX(_kindLab.frame) + edgeMargin;
    _industryLab.y = _kindLab.y;
    // 学历
    _educationLab.font = normalFont;
    [_educationLab sizeToFit];
    _educationLab.x = CGRectGetMaxX(_industryLab.frame) + edgeMargin;
    _educationLab.y = _kindLab.y;
    // 公司详情--大按钮
    _companyBtn.x = edgeMargin;
    _companyBtn.y = CGRectGetMaxY(_kindLab.frame) + 15;
    _companyBtn.height = 78;
    _companyBtn.width = CGRectGetMaxX(_payLab.frame) - edgeMargin;
   
       // 公司图标
    _companyImageView.x = edgeMargin;
    _companyImageView.y = edgeMargin;
    _companyImageView.width = 56;
    _companyImageView.height = 56;
      // 公司名称
    _companyNameLab.x = CGRectGetMaxX(_companyImageView.frame) + edgeMargin;
    _companyNameLab.y = _companyImageView.y;
    _companyNameLab.font = titleFont;
    [_companyNameLab sizeToFit];
     // 公司网址
    _URLLab.x = _companyNameLab.x;
    _URLLab.y = CGRectGetMaxY(_companyNameLab.frame) + edgeMargin/2;
    _URLLab.font = normalFont;
    [_URLLab sizeToFit];
    // 集团名称
    _bigCompanyNameLab.x = _URLLab.x;
    _bigCompanyNameLab.font = normalFont;
    [_bigCompanyNameLab sizeToFit];
    _bigCompanyNameLab.y = CGRectGetMaxY(_companyImageView.frame) - _bigCompanyNameLab.height;
    // 箭头
    [_arrow sizeToFit];
    _arrow.x = _companyBtn.width - edgeMargin - _arrow.width;
    _arrow.y = 2 * edgeMargin;
    
    //福利承载视图
    _welfView.y = CGRectGetMaxY(_companyBtn.frame)+edgeMargin;
    _welfView.x = 0;
    _welfView.height = 100;
    _welfView.width = screenW;
    [self setUpWelfView];
    // 任职要求背景
    _postRequireImageView.y = CGRectGetMaxY(_welfView.frame);
    _postRequireImageView.x = edgeMargin;
    _postRequireImageView.width = _companyBtn.width;
    _postRequireImageView.height = 200;
    _postRequireImageView.userInteractionEnabled = YES;
    //任职要求标题
    _postRequireTitleLab.x = edgeMargin;
    _postRequireTitleLab.y = edgeMargin;
    _postRequireTitleLab.font = [UIFont systemFontOfSize:13];
    [_postRequireTitleLab sizeToFit];
    
    // 设置投诉/收藏/分享btn
    
    
    
}


-(void)bigButtonClick{
    if ([_companyDelegate respondsToSelector:@selector(clickBigButtonToCompany:)]) {
        [_companyDelegate clickBigButtonToCompany:_companyBtn];
    }
}



//排布职业
- (void)setUpWelfView{
    
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 0;//用来控制button距离父视图的高
    for (int i = 0; i < self.welfareArr.count; i++) {
        UILabel  *lab = [[UILabel alloc]init];
        lab.layer.cornerRadius = 10.0;
        lab.backgroundColor = zyMainColor;
        lab.font = normalFont;
        lab.clipsToBounds = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        //设置边框宽度
       // [lab.layer setBorderWidth:1.0];
        //设置边框颜色
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.5 });
//        [lab.layer setBorderColor:colorref];
        
        lab.textColor = [UIColor whiteColor];
        
      //  lab.lineBreakMode = NSLineBreakByTruncatingTail;
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10]};
        CGFloat length = [self.welfareArr[i] boundingRectWithSize:CGSizeMake(screenW, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width + 30;
        //为button赋值
        lab.text = self.welfareArr[i];
        
        //设置button的frame
        lab.frame = CGRectMake(10 + w, h, length  , 25);
        //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
        if(10 + w + length + 6 > screenW){
            w = 0; //换行时将w置为0
            h = h + lab.frame.size.height + 6;//距离父视图也变化
            lab.frame = CGRectMake(10 + w, h, length , 25);//重设button的frame
        }
        w = lab.frame.size.width + lab.frame.origin.x;
        [_welfView addSubview:lab];
    }
}

// 投诉/收藏/分享按钮
-(UIButton *)setUpButtonsImage:(UIImage *)image title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.x= 0;
    btn.y = 0;
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.image = image;
    [iconView sizeToFit];
    iconView.x = 0;
    iconView.y = 0;
    
    
    
    UILabel *titleLab =[[UILabel alloc] init];
    titleLab.text = title;
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textColor = zyMainColor;
    [titleLab sizeToFit];
    titleLab.x = CGRectGetMaxX(iconView.frame)+6;
    titleLab.y = iconView.y;
    
    btn.width = CGRectGetMaxX(titleLab.frame);
    btn.height = titleLab.height;
    
    [btn addSubview:iconView];
    [btn addSubview:titleLab];
    
    return btn;
}




@end
