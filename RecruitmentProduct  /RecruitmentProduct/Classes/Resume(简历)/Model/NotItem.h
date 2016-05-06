//
//  NotItem.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/6.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NotItem : NSObject

@property (strong, nonatomic) NSString * title;/**< 标题 */

+ (instancetype)itemWithtitle:(NSString *)title;/**< 设置标题值 类方法 */

@end
