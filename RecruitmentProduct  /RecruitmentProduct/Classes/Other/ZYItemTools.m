//
//  ZYItemTools.m
//  zyzp
//
//  Created by runsheng on 16/3/28.
//  Copyright © 2016年 henanrunshengkeji. All rights reserved.
//

#import "ZYItemTools.h"
#import "Common.h"

@implementation ZYItemTools

// target 指的是点击btn后调用哪个对象的方法
// action 点击btn后调用target的哪个方法
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)myAction image:(NSString *)image highlightedImage:(NSString *)highlightedImage{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:myAction forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action Title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:Color(123, 123, 123) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
