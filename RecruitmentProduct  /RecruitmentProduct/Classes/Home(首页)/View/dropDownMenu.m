//
//  dropDownMenu.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/7.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "dropDownMenu.h"
#import "UIView+ZYFrame.h"

@interface dropDownMenu ()

@property (nonatomic, strong) UIView *containerView;

@end



@implementation dropDownMenu

+(instancetype)menu{
    return [[self alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(UIView *)containerView{
    if (_containerView==nil) {
        UIImageView *containerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popover_background_left"]];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        _containerView = containerView;
    }
    return _containerView;
}
-(void)setContent:(UIView *)content{
    _content = content;
    content.x = 5;
    content.y = 17;
    self.containerView.height = content.height+30;
    self.containerView.width = content.width+10;
    [self.containerView addSubview:content];
}

-(void)setContentViewController:(UIViewController *)contentViewController{
    _contentViewController = contentViewController;
    self.content = contentViewController.view;
}
-(void)showWithFrame:(UIView *)clickView{
    
    //1. 获取最上边的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    
    self.frame = window.bounds;
    
    CGRect newRect = [clickView convertRect:clickView.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newRect);
    self.containerView.y = CGRectGetMaxY(newRect)-clickView.height/5;
}

// 点击屏幕取消蒙版
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
  
}

@end
