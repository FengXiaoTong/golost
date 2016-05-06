//
//  LCMbaseViewController.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/2.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import <Masonry.h>
#import "UIView+ZYFrame.h"

#define UIColorFromRGB(rgbValue, pellucidity) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:pellucidity]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self


@interface LCMbaseViewController : UIViewController

@end
