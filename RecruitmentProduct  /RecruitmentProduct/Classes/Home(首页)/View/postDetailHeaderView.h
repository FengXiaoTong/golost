//
//  postDetailHeaderView.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/15.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>
@class postDetailHeaderView;
@protocol postDetailBtnToCompanyDelegate <NSObject>

@optional
-(void)clickBigButtonToCompany:(UIView *)view;

@end


@interface postDetailHeaderView : UITableViewHeaderFooterView
@property (nonatomic, weak) id<postDetailBtnToCompanyDelegate> companyDelegate;
+(instancetype)setUpPostDetailHeaderView;

@end
