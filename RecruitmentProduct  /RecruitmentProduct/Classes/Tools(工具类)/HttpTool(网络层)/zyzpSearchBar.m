//
//  zyzpSearchBar.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/1.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "zyzpSearchBar.h"

@implementation zyzpSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.background = [UIImage imageNamed:@"search-icon"];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, 30, 30);
        //imageView.image = [UIImage imageNamed:@"search-icon-1"];
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype)searchBarWithFrame:(CGRect)frame{
    return [[self alloc]initWithFrame:frame];
}
@end
