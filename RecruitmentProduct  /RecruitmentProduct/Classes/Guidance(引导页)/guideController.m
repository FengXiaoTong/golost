//
//  guideController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/13.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "guideController.h"
#import "UIView+ZYFrame.h"
#import "Common.h"
#import "interestController.h"

@interface guideController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *imageNameArr;
@property (nonatomic, strong) UIButton *btn;
@end

@implementation guideController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpScrollView];
    [self setUpBtn];
    
    
}
-(NSArray *)imageNameArr{
    if (_imageNameArr == nil) {
        _imageNameArr = @[@"launch0",@"launch1",@"launch2",@"launch3"];
    }
    return _imageNameArr;
}

-(void)setUpBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
   [btn sizeToFit];
    btn.width = 200;
    btn.height = 45;
    btn.centerX = self.view.width/2;
    btn.y = self.view.height * 3/4;
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.hidden = YES;
    _btn = btn;
 
}
-(void)btnClick{
    UIWindow *windom = [UIApplication sharedApplication].keyWindow;
    windom.rootViewController = [[interestController alloc] init];
    
}

-(void)setUpScrollView{
   
    _scrollView =[[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.delegate = self;
    // 如果想让某个方向不能滚动，那么这个方向对应的尺寸数传0
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(screenW *self.imageNameArr.count, 0);
    [self.view addSubview:_scrollView];
    for (int i = 0; i<self.imageNameArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenW*i, 0, screenW, screenH)];
        [_scrollView addSubview:imageView];
        imageView.image = [UIImage imageNamed:self.imageNameArr[i]];
        
    }
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = self.imageNameArr.count;
    _pageControl.width = 100;
    _pageControl.height = 30;
    _pageControl.centerX = self.view.width/2;
    _pageControl.y = self.view.height *6/7;
    _pageControl.userInteractionEnabled = YES;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    [self.view addSubview:_pageControl];
    [self.view bringSubviewToFront:_pageControl];
    
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double page = scrollView.contentOffset.x/self.view.width;
    
    //四舍五入 page页数  = (int)(page + 0.5)   只适用于一位小数。。。类似的可加（+5，+0.05.。。。）
    _pageControl.currentPage = (int)(page + 0.5);
    if (_scrollView.contentOffset.x > screenW *2) {
        _btn.hidden = NO;
    }else{
        _btn.hidden = YES;
    }
    
}

@end
