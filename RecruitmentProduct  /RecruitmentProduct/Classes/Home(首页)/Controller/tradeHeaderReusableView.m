//
//  tradeHeaderReusableView.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/8.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//   详情行业类别组头

#import "tradeHeaderReusableView.h"
#import "UIView+ZYFrame.h"

@implementation tradeHeaderReusableView

-(void)setHeaderTitle:(NSString *)headerTitle{
    _headerTitle = headerTitle;
    UILabel *lab = [[UILabel alloc] init];
    lab.x = 10;
    lab.y = 0;
    lab.width = self.width - lab.x;
    lab.height = self.height;
    lab.text = headerTitle;
    
    [self addSubview:lab];
}

@end
