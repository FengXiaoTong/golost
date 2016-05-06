//
//  ZPFLableOperation.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/20.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ZPFLableOperation.h"


@implementation ZPFLableOperation

+ (NSMutableAttributedString *)positionNumber:(NSString *)string withSize:(CGFloat)size {
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@"个"].location);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:redRange];
    return noteStr;
}


+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

+ (NSMutableAttributedString *)setLineSpace:(CGFloat)space withString:(NSString *)labelText {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:space];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    //    label.attributedText = attributedString;
    
    
    return attributedString;
    
}




@end
