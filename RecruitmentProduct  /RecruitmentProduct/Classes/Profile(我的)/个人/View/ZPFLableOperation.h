//
//  ZPFLableOperation.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/20.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZPFLableOperation : NSObject

+ (NSMutableAttributedString *)positionNumber:(NSString *)string withSize:(CGFloat)size;
//label自适应高度
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;
//调整行间距
+ (NSMutableAttributedString *)setLineSpace:(CGFloat)space withString:(NSString *)labelText;

@end
