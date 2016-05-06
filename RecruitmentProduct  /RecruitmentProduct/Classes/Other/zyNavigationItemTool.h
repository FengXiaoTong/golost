//
//  zyNavigationItemTool.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/14.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface zyNavigationItemTool : NSObject

@property (nonatomic, copy) NSString *rightTitle;


// 设置导航栏 左
+(UIButton *)setUpLeftBtnWithTarget:(id)target action:(SEL)myAction iamge:(UIImage *)image Title:(NSString *)title;

// 设置导航栏 右
+(UIButton *)setUpRightBtnWithTarget:(id)target action:(SEL)myAction iamge:(UIImage *)image Title:(NSString *)title;
// title
+(UIButton *)setUpTitleBtnWithTarget:(id)target action:(SEL)myAction smallIamge:(UIImage *)smallIamge  backgroundImage:(UIImage *)backgroundImage Title:(NSString *)title;
@end
