//
//  detailSearchBar.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/7.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>


@class detailSearchBar;
@protocol detailSearchBarDelegate <NSObject>

@optional
-(void)detailSearchBarButtonCilck:(UIButton *)button;

@end


@interface detailSearchBar : UITextField
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) NSString *buttonTitle;
@property (nonatomic,weak) id<detailSearchBarDelegate> myDelegate;
+(instancetype)searchBarWithFrame:(CGRect)frame;



@end
