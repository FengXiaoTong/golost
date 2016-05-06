//
//  detailSearchBar.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/7.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "detailSearchBar.h"
#import "UIView+ZYFrame.h"


@interface detailSearchBar ()


@end

@implementation detailSearchBar

+(instancetype)searchBarWithFrame:(CGRect)frame{
    return [[self alloc]initWithFrame:frame];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpDetailSearchBar];
        
    }
    return self;
}

-(void)setUpDetailSearchBar{
    
    
    
    
    self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
    // 右端按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_buttonTitle==nil) {
         [btn setTitle:@"全部" forState:UIControlStateNormal];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [btn setTitle:_buttonTitle forState:UIControlStateNormal];
        });
    }
    
   
    btn.titleLabel.font =[UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.x = 0;
    btn.y = 0;
    btn.height = CGRectGetHeight(self.frame);
    btn.width = self.width/4;
    btn.contentMode = UIViewContentModeCenter;
    self.leftView = btn;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _button = btn;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnClick{
    if ([_myDelegate respondsToSelector:@selector(detailSearchBarButtonCilck:)]) {
        [_myDelegate detailSearchBarButtonCilck:_button];
    }
}

@end
