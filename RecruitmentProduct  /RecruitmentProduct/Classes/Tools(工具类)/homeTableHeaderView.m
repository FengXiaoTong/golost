//
//  homeTableHeaderView.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/5.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "homeTableHeaderView.h"
#import "Common.h"
#import "UIView+ZYFrame.h"

#define scrollViewH 122
@implementation homeTableHeaderView


//  ------------封装轮播---------------

+(instancetype)scrollViewImagesName:(NSArray *)imageNames{
    return [[self alloc] initWithScrollViewImages:imageNames];
}

-(instancetype)initWithScrollViewImages:(NSArray *)imageNameArr{
    if (self = [super init]) {
        self.height = scrollViewH;
        self.width = screenW;
        [self setUpScrollViewToHome:imageNameArr];
    }
    return self;
}

-(void)setUpScrollViewToHome:(NSArray *)iamgeNameAr{
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.height = scrollViewH;
    scrollView.width = screenW;
    scrollView.x = 0;
    scrollView.y = 0;
    scrollView.contentSize = CGSizeMake(screenW * iamgeNameAr.count, scrollViewH);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self addSubview:scrollView];
    
    for (int i = 0; i < iamgeNameAr.count; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(screenW * i, 0, screenW, scrollView.height)];
        imageview.image = [UIImage imageNamed:@"home_banner"];
        [scrollView addSubview:imageview];
        
        
    }
    
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    //pageControl.numberOfPages = self.imageArr.count;
    pageControl.numberOfPages = iamgeNameAr.count;
    pageControl.width = 100;
    pageControl.height = 30;
    pageControl.x = screenW/2;
    pageControl.y =  scrollView.height * 5/7;
    pageControl.userInteractionEnabled = YES;
    pageControl.currentPageIndicatorTintColor = zyMainColor;
    pageControl.pageIndicatorTintColor = Color(195, 209, 235);
    
    [self addSubview:pageControl];
    [self bringSubviewToFront:pageControl];
    _pageControl = pageControl;
    _scrollView = scrollView;
}

@end
