//
//  LCMcompanyTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/23.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMcompanyTableViewCell.h"
#import "ZPFLableOperation.h"
#import "Common.h"
#import "UIView+ZYFrame.h"
#define TITLE_FONT 17.0
#define MESSAGE_FONT 15
#define SEX_FONT 13
@interface LCMcompanyTableViewCell ()<UITextViewDelegate> {

//    UILabel *_titlesLabel;
//    UIImageView *_indicatorsImageV;
//    UILabel *_titlePlaceholder;
    
//    UILabel *_companyName;//公司名称
//    UILabel *_companyEmail;//公司邮箱
//
//    UILabel *_companyGuiMo;
//    UILabel *_companySuoZaiDi;
//    UILabel *_companyAddress;
//    UILabel *_companyGoJi;
//    UILabel *_companyZhPiEmail;
//    UILabel *_person;//联系人
//    UILabel *_personTel;//联系人电话
////    UILabel *_rePersonTel;//招聘联系人电话
//    UILabel *_companyIndr;

    UILabel *_titleLab;
    UILabel *_messageLab;
    UIImageView *_indicatorsImageV;
    UIButton *_ladyBt;
    UILabel *_ladyLab;
    UIButton *_manBt;
    UILabel *_manLab;
   UITextView *_textView;
    
    NSString *_titleStr;
    NSString *_messageStr;
    
    
}
@end


@implementation LCMcompanyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customs];
    }
    return self;
}

- (void)customs {
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.font = [UIFont systemFontOfSize:TITLE_FONT];
    _titleLab.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_titleLab];
    
    _indicatorsImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:_indicatorsImageV];
    
    _messageLab = [[UILabel alloc] init];
    _messageLab.font = [UIFont systemFontOfSize:MESSAGE_FONT];
    _messageLab.textColor = Color(110, 110, 110);
    [self.contentView addSubview:_messageLab];

}




-(void)setModel:(NSString *)modelString withStandbyString:(NSString *)standby withTitleString:(NSString *)title {
    
    _titleLab.text = title;
    _titleStr = title;
  
    if (modelString) {
        _messageLab.text = modelString;
        _messageStr = modelString;
    
    } else {
        _messageLab.text = standby;
        _messageStr = standby;
    }
    _indicatorsImageV.image = [UIImage imageNamed:@"gogo"];

    
    if ([standby isEqualToString:@""]) {
        [_messageLab removeFromSuperview];
        [_indicatorsImageV removeFromSuperview];
        if ([title isEqualToString:@"联系人性别"]) {
            [self creatSexButton:modelString];
        }
    
    }
    
    if([title isEqualToString:@""]){
        [_titleLab removeFromSuperview];
        [_messageLab removeFromSuperview];
        [_indicatorsImageV removeFromSuperview];
        [self createTextView:modelString withStandbyString:standby];
    }

}

- (void)createTextView:(NSString *)modelString withStandbyString:(NSString *)standby{
    CGFloat top = 10;
    CGFloat left = 10;
    CGFloat right = 15;
    
    
    

    
    _textView = [[UITextView alloc] init];
    _textView.delegate = self;
    if (modelString) {
        _textView.text = modelString;
    }else {
        _textView.text = standby;
    }
    
    _textView.frame = CGRectMake(left, top, screenW - left - right, self.height - top);
    [self.contentView addSubview:_textView];


    //定义一个toolBar
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, screenW, 40)];
    //设置style
    [topView setBarStyle:UIBarStyleDefault];
    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    //定义完成按钮
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"确认修改" style:UIBarButtonItemStyleDone  target:self action:@selector(resignKeyboard)];
    [doneButton setTitleTextAttributes:@{NSBackgroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    //在toolBar上加上这些按钮
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    
    [_textView setInputAccessoryView:topView];

    
}

- (void)resignKeyboard {

    [_textView resignFirstResponder];

    MYLog(@"%@",_textView.text);

}



- (void)creatSexButton:(NSString *)modelString {
    CGFloat top = 10;
    CGFloat lab_right = 30;
    CGFloat bt_right = 5;
    
    _ladyLab = [[UILabel alloc] init];
    _ladyLab.text = @"女";
    _ladyLab.textColor = Color(100, 100, 100);
    _ladyLab.font = [UIFont systemFontOfSize:SEX_FONT];
    _ladyLab.frame = CGRectMake(screenW - 50 - SEX_FONT, top, SEX_FONT, SEX_FONT);
    [self.contentView addSubview:_ladyLab];
    
    _ladyBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _ladyBt.tag = 100;
    [_ladyBt setBackgroundImage:[[UIImage imageNamed:@"yuanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_ladyBt setBackgroundImage:[[UIImage imageNamed:@"yuanquan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_ladyBt addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _ladyBt.frame = CGRectMake(CGRectGetMinX(_ladyLab.frame) - bt_right - SEX_FONT, top, SEX_FONT, SEX_FONT);
    [self.contentView addSubview:_ladyBt];
    
    
    _manLab = [[UILabel alloc] init];
    _manLab.text = @"男";
    _manLab.textColor = Color(100, 100, 100);
    _manLab.font = [UIFont systemFontOfSize:SEX_FONT];
    _manLab.frame = CGRectMake(CGRectGetMinX(_ladyBt.frame) - lab_right - SEX_FONT, top, SEX_FONT, SEX_FONT);
    [self.contentView addSubview:_manLab];
    
    
    
    _manBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _manBt.tag = 101;
    [_manBt setBackgroundImage:[[UIImage imageNamed:@"yuanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_manBt setBackgroundImage:[[UIImage imageNamed:@"yuanquan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_manBt addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _manBt.frame = CGRectMake(CGRectGetMinX(_manLab.frame) - bt_right - SEX_FONT, top, SEX_FONT, SEX_FONT);
    [self.contentView addSubview:_manBt];
    
    NSLog(@"-------%@",modelString);
    
    if ([modelString isEqualToString:@"01"]) {
        _manBt.selected = YES;
    }else if ([modelString isEqualToString:@"00"]) {
        _ladyBt.selected = YES;
    }

}
- (void)buttonAction:(UIButton *)button {
    
    if (button.tag == 100) {
        if (button.isSelected == YES) {
            return;
        }
        
        
        _ladyBt.selected = YES;
        _manBt.selected = NO;
    }else if (button.tag == 101) {
        if (button.isSelected == YES) {
            return;
        }
        
        _ladyBt.selected = NO;
        _manBt.selected = YES;
    }
}


-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    CGFloat title_top = 10.0;
    CGFloat title_left = 22.0;
    CGSize title_size = [ZPFLableOperation sizeWithText:_titleStr maxSize:CGSizeMake(CGFLOAT_MAX, TITLE_FONT) font:[UIFont systemFontOfSize:TITLE_FONT]];
     _titleLab.frame = CGRectMake(title_left, title_top, title_size.width, title_size.height);
   
    CGFloat indicators_top = 10.0;
    CGFloat indicators_right = 28.0;
    CGSize indicators_size = CGSizeMake(9, 15);
    CGFloat indicators_X = screenW - indicators_right - indicators_size.width;
    _indicatorsImageV.frame = CGRectMake(indicators_X, indicators_top, indicators_size.width, indicators_size.height);
    
    
    CGFloat message_top = 10;
    CGFloat message_right = 10;
    CGFloat message_width_MAX = indicators_X - message_right - CGRectGetMaxX(_titleLab.frame) - 15;
    CGSize message_size = [ZPFLableOperation sizeWithText:_messageStr maxSize:CGSizeMake(message_width_MAX, MESSAGE_FONT) font:[UIFont systemFontOfSize:MESSAGE_FONT]];
    CGFloat message_X = indicators_X - message_right - message_size.width;
    _messageLab.frame = CGRectMake(message_X, message_top, message_size.width, message_size.height);
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
