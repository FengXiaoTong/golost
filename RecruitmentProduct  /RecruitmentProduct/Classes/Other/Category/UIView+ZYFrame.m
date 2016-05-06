//
//  UIView+ZYFrame.m
//  zyzp
//
//  Created by runsheng on 16/3/28.
//  Copyright © 2016年 henanrunshengkeji. All rights reserved.
//  该UIView的类别是为了更方便快捷的写UIView及其子类的frame

#import "UIView+ZYFrame.h"

@implementation UIView (ZYFrame)
@dynamic centerY;
-(void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
    
}

-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setSize:(CGSize)size{
    CGRect rect = self.frame;
    rect.size =size;
    self.frame = rect;
}

-(CGSize)size{
    return self.frame.size;
}


-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}
-(CGFloat)centerX{
    return self.center.x;
}

-(void)setCneterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
-(CGFloat)centerY{
    return self.center.y;
}

@end
