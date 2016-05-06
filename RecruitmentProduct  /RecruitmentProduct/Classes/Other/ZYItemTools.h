//
//  ZYItemTools.h
//  zyzp
//
//  Created by runsheng on 16/3/28.
//  Copyright © 2016年 henanrunshengkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYItemTools : NSObject
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)myAction image:(NSString *)image highlightedImage:(NSString *)highlightedImage;

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action Title:(NSString *)title;
@end
