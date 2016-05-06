//
//  CompanyNameViewController.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/19.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyNameViewController;

@protocol PassingValueDelegate <NSObject>

@optional

-(void)viewController:(CompanyNameViewController *)viewController didPassingValueWithInfo:(id)info;

@end

@interface CompanyNameViewController : UIViewController
@property(nonatomic, assign) id<PassingValueDelegate>delegate;
@end
