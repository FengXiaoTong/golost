//
//  zyzpNavigationController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/3/29.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "zyzpNavigationController.h"
#import "ZYItemTools.h"
#import "Common.h"
#import "zyzpTabBarController.h"
#import "homeViewController.h"



@interface zyzpNavigationController ()
@property (nonatomic, strong) UIViewController *controller;
@end

@implementation zyzpNavigationController

+(void)initialize{

    // 统一设置标题颜色

     [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

   self.navigationBar.barTintColor = zyMainColor;

    self.navigationBar.translucent = YES;
    UIView *staBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, screenW, 20)];
    staBarView.backgroundColor = [UIColor whiteColor];
    [self.navigationBar addSubview:staBarView];
    
}



// 重写Navigation push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];

    if (self.viewControllers.count < 2) {
        return;
    }
    else if (self.viewControllers.count == 2) {
        // 设置非主页面navigation返回按钮
        viewController.navigationItem.leftBarButtonItem = [ZYItemTools itemWithTarget:self action:@selector(leftClick) image:@"nav_back" highlightedImage:@"nav_back"];
        viewController.tabBarController.tabBar.hidden = YES;
        _controller = viewController;
    }
    else{
        viewController.navigationItem.leftBarButtonItem = [ZYItemTools itemWithTarget:self action:@selector(leftClickOther) image:@"nav_back" highlightedImage:@"nav_back"];
        viewController.tabBarController.tabBar.hidden = YES;
        _controller = viewController;

    }
}

-(void)leftClick{
    [self popViewControllerAnimated:YES];
    _controller.tabBarController.tabBar.hidden = NO;
}

-(void)leftClickOther{
    [self popViewControllerAnimated:YES];

}

@end
