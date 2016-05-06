//
//  ZPFlookModel.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/20.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ZPFlookModel : JSONModel


@property (nonatomic, assign) NSInteger pageEnd;

@property (nonatomic, copy) NSString *viewedId;

@property (nonatomic, copy) NSString *endSearchDate;

@property (nonatomic, assign) NSInteger currentpage;

@property (nonatomic, copy) NSString *endDateStr;

@property (nonatomic, copy) NSString *resumeId;

@property (nonatomic, copy) NSString *personId;

@property (nonatomic, copy) NSString *beginDateStr;

@property (nonatomic, assign) NSInteger pageStar;

@property (nonatomic, assign) NSInteger rscount;

@property (nonatomic, copy) NSString *betweenDay;

@property (nonatomic, copy) NSString *resumeName;

@property (nonatomic, copy) NSString *viewedDate;

@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *personName;

@property (nonatomic, copy) NSString *companyId;

@property (nonatomic, copy) NSString *jobNum;


@end


