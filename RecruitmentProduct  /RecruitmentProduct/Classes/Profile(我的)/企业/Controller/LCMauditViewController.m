//
//  LCMauditViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/30.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMauditViewController.h"
#import "ZPFLableOperation.h"
#import "Common.h"
#import "UIView+ZYFrame.h"


#define EXAMINE_FONT 16
#define PROMPT_FONT 15
#define SELECTED_COLOR [UIColor colorWithRed:70/255.0 green:120/255.0 blue:220/255.0 alpha:1.0]
@interface LCMauditViewController () {
    
    //通过审核
    UILabel *_passLab;
    UIImageView *_passIV;
    //正在审核
    UILabel *_examineLab;
    UIImageView *_examineIV;
    //等待审核
    UILabel *_waitLab;
    UIImageView *_waitIV;
    //未审核
    UILabel *_notLab;
    UIImageView *_notIV;
    
    //火箭
    UIImageView *_rocketIV;

    //竖线
    UIImageView *_verticalIV;

}

@end

@implementation LCMauditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"审核状态";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self pageLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)refreshData:(NSString *)string {
    
    
    if ([string isEqualToString:@"通过审核"]) {
        _passLab.textColor = SELECTED_COLOR;
        _rocketIV.centerY = _passLab.centerY;
       
    }else if ([string isEqualToString:@"正在审核"]){
        _examineLab.textColor = SELECTED_COLOR;
        _rocketIV.centerY = _examineLab.centerY;
    }else if ([string isEqualToString:@"等待审核"]) {
        _waitLab.textColor = SELECTED_COLOR;
        _rocketIV.centerY = _waitLab.centerY;
    }else if ([string isEqualToString:@"未审核"]) {
        _notLab.textColor = SELECTED_COLOR;
        _rocketIV.centerY = _notLab.centerY;
    }
    
}
- (void)pageLayout {

    
    CGFloat top = 49;
    
    CGSize label_size = [ZPFLableOperation sizeWithText:@"正在审核" maxSize:CGSizeMake(CGFLOAT_MAX, EXAMINE_FONT) font:[UIFont systemFontOfSize:EXAMINE_FONT]];

    CGFloat label_X = screenW/2 - label_size.width;
    CGSize image_size = CGSizeMake(8, 8);
    
    CGFloat vertical_height = 220;
    CGFloat vertical_X = screenW/2 + 25;
    
    
    UIImageView *verticalView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shuxian"]];
    verticalView.frame = CGRectMake(vertical_X, top + 2, 1, vertical_height);
    [self.view addSubview:verticalView];
    
    
    _passLab = [[UILabel alloc] init];
    _passLab.text = @"通过审核";
    _passLab.font = [UIFont systemFontOfSize:EXAMINE_FONT];
    _passLab.textColor = Color(117, 117, 117);
    _passLab.frame = CGRectMake(label_X, top, label_size.width, label_size.height);
    [self.view addSubview:_passLab];
    
    _passIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuanquan"]];
    _passIV.size = image_size;
    _passIV.centerX = verticalView.centerX;
    _passIV.centerY = _passLab.centerY;
    [self.view addSubview:_passIV];
    
    
    
    
    _examineLab = [[UILabel alloc] init];
    _examineLab.text = @"正在审核";
    _examineLab.font = [UIFont systemFontOfSize:EXAMINE_FONT];
    _examineLab.textColor = Color(117, 117, 117);
    _examineLab.frame = CGRectMake(label_X,CGRectGetMaxY(_passLab.frame) + top, label_size.width, label_size.height);
    [self.view addSubview:_examineLab];
    
    _examineIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuanquan"]];
    _examineIV.size = image_size;
    _examineIV.centerX = verticalView.centerX;
    _examineIV.centerY = _examineLab.centerY;
    [self.view addSubview:_examineIV];
    
    
    
    _waitLab = [[UILabel alloc] init];
    _waitLab.text = @"等待审核";
    _waitLab.font = [UIFont systemFontOfSize:EXAMINE_FONT];
    _waitLab.textColor = Color(117, 117, 117);
    _waitLab.frame = CGRectMake(label_X, CGRectGetMaxY(_examineLab.frame) + top, label_size.width, label_size.height);
    [self.view addSubview:_waitLab];
    
    _waitIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuanquan"]];
    _waitIV.size = image_size;
    _waitIV.centerX = verticalView.centerX;
    _waitIV.centerY = _waitLab.centerY;
    [self.view addSubview:_waitIV];
    
    
    
    
    _notLab = [[UILabel alloc] init];
    _notLab.text = @"未审核";
    _notLab.font = [UIFont systemFontOfSize:EXAMINE_FONT];
    _notLab.textColor = Color(70, 120, 220);
    _notLab.textAlignment = NSTextAlignmentRight;
    _notLab.frame = CGRectMake(label_X, CGRectGetMaxY(_waitLab.frame) + top, label_size.width, label_size.height);
    [self.view addSubview:_notLab];
    
    _notIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuanquan"]];
    _notIV.size = image_size;
    _notIV.centerX = verticalView.centerX;
    _notIV.centerY = _notLab.centerY;
    [self.view addSubview:_notIV];
    


    CGFloat rocket_X = CGRectGetMaxX(verticalView.frame) + 12;
    CGSize rocket_size = CGSizeMake(25, 43);
    _rocketIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feiji"]];
    _rocketIV.size = rocket_size;
    _rocketIV.x = rocket_X;
    _rocketIV.centerY = _notIV.centerY;
    [self.view addSubview:_rocketIV];
    
    
    CGFloat prompt_top = 79;
    UILabel *prompt = [[UILabel alloc] init];
    prompt.text = @"提示：审核通过后，可点击发布职位";
    prompt.font = [UIFont systemFontOfSize:PROMPT_FONT];
    prompt.textColor = Color(154, 154, 154);
    prompt.textAlignment = NSTextAlignmentCenter;
    prompt.frame = CGRectMake(0, CGRectGetMaxY(_notLab.frame) + prompt_top, screenW, PROMPT_FONT);
    [self.view addSubview:prompt];

    CGFloat bt_top = 24;
    CGFloat bt_left = 22;
    CGFloat bt_height = 45;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = Color(70, 120, 220);
    [button setTitle:@"发布职位" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(bt_left, CGRectGetMaxY(prompt.frame) + bt_top, screenW - bt_left*2, bt_height);
    [self.view addSubview:button];
    
    
}

-(void)buttonAction {

    MYLog(@"如果通过跳转，否则return");

}

@end
