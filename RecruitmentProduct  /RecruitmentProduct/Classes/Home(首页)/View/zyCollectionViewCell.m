//
//  zyCollectionViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/8.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "zyCollectionViewCell.h"

@implementation zyCollectionViewCell

-(void)setNewTitle:(NSString *)title{
    
    _title = title;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:self.bounds];
    lable.text = title;
    lable.numberOfLines = 0;
    lable.font = [UIFont systemFontOfSize:15];
    lable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lable];
    
}

@end
