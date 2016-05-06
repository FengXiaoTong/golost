//
//  DataItem.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/6.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataItem : NSObject

/** 头部标题 */
@property (strong, nonatomic) NSString * headerTitle;
/** 尾部标题 */
@property (strong, nonatomic) NSString * footerTitle;

/** 组中的行数组 */
@property (strong, nonatomic) NSArray * items;

@end
