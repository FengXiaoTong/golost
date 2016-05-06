//
//  dropDownMenu.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/7.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dropDownMenu : UIView

// 下拉菜单内放ViewController
@property (nonatomic, strong) UIViewController *contentViewController;
// 下拉菜单内放UIView
@property (nonatomic, strong) UIView *content;


+(instancetype)menu;

-(void)showWithFrame:(UIView *)clickView;


@end
