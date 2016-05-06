//
//  ZPFinformatioBaseViewController.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/4.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMbaseViewController.h"

#define VIEW_HEIGHT screenH - 108

@interface ZPFinformatioBaseViewController : LCMbaseViewController

@property (nonatomic, strong)UIScrollView *scrollView;


- (void)buttonAction:(UIButton *)button;

@end
