//
//  homeTableHeaderView.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/5.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeTableHeaderView : UIView
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

+(instancetype)scrollViewImagesName:(NSArray *)imageNames;

-(instancetype)initWithScrollViewImages:(NSArray *)imageNameArr;

@end
