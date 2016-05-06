//
//  zyNavigationItemTool.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/14.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//  导航栏设置BarButtonItems

#import "zyNavigationItemTool.h"
#import "Common.h"
#import "UIView+ZYFrame.h"

#define selfHeight 44
#define titleMargin 10

@implementation zyNavigationItemTool

/**
 *  设置导航栏外观
 *
 *  @param target   时间响应者
 *  @param myAction 点击事件
 *  @param image    图标
 *  @param title    标题
 *
 *  @return
 */


+(UIButton *)setUpRightBtnWithTarget:(id)target  action:(SEL)myAction iamge:(UIImage *)image Title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 30);
    UIImageView *imv = [[UIImageView alloc] init];
    imv.image = image;
    [imv sizeToFit];
    imv.x = btn.width - imv.width;
    imv.y = (btn.height -imv.height)/2;
    [btn addSubview:imv];
    

    UILabel *lab = [[UILabel alloc] init];
    lab.font= [UIFont systemFontOfSize:15];
    lab.text = title;
    
    lab.textAlignment = NSTextAlignmentRight;
    lab.textColor = [UIColor whiteColor];
    [lab sizeToFit];
    lab.x = imv.x - 6 -lab.width;;
    lab.y = imv.y;
    
    [btn addSubview:lab];
    [btn addTarget:target action:myAction forControlEvents:UIControlEventTouchUpInside];
    return btn;
}



+(UIButton *)setUpLeftBtnWithTarget:(id)target action:(SEL)myAction iamge:(UIImage *)image Title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 30);
    UIImageView *imv = [[UIImageView alloc] init];
    imv.x = 0;
    imv.image = image;
    [imv sizeToFit];
    imv.y = (btn.height - imv.height)/2;
    
    
    [btn addSubview:imv];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.x = CGRectGetMaxX(imv.frame)+6;
    lab.y = imv.y;
    lab.font= [UIFont systemFontOfSize:15];
    lab.text = title;
    [lab sizeToFit];
     lab.textColor = [UIColor whiteColor];
    [btn addSubview:lab];
    [btn addTarget:target action:myAction forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

/**
 *  设置导航栏titlView外观
 *
 *  @param target          时间监听
 *  @param myAction        点击事件
 *  @param smallIamge      小图标
 *  @param backgroundImage 背景图片
 *  @param title           标题
 *
 *  @return 
 */
+(UIView *)setUpTitleBtnWithTarget:(id)target action:(SEL)myAction smallIamge:(UIImage *)smallIamge  backgroundImage:(UIImage *)backgroundImage Title:(NSString *)title{
    
   // UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIView *footView = [[UIView alloc] init];
    
    UITextField *textF = [[UITextField alloc] init];
    textF.font= [UIFont systemFontOfSize:15];
    textF.placeholder = title;
    textF.textAlignment = NSTextAlignmentRight;
    textF.textColor = [UIColor whiteColor];
    [textF sizeToFit];
    textF.x = 0;
    textF.y = (selfHeight-textF.height)/2-5;
    
    UIImageView *imv = [[UIImageView alloc] init];
    imv.image = smallIamge;
    [imv sizeToFit];
    imv.x = CGRectGetMaxX(textF.frame) + titleMargin;
    imv.y = textF.y;
    
    
    [footView sizeToFit];
    footView.width = CGRectGetMaxX(imv.frame);
    footView.height = 30;
    footView.x = (screenW - footView.width)/2;
    footView.y = (selfHeight -footView.height)/2;
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.width = footView.width + titleMargin;
    bgImageView.height = footView.height;
    bgImageView.x = -5;
    bgImageView.y= 0;
    bgImageView.image = backgroundImage;
    bgImageView.userInteractionEnabled = YES;
    [footView addSubview:bgImageView];
     [footView addSubview:imv];
    [footView addSubview:textF];
    UIView *view = [[UIView alloc] init];
    view.frame = bgImageView.frame;
    view.backgroundColor = [UIColor clearColor];
    [footView addSubview:view];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:target action:myAction];
    [view addGestureRecognizer:tapGR];
    //[btn addTarget:target action:myAction forControlEvents:UIControlEventTouchUpInside];
    
    
    return footView;
}



@end
