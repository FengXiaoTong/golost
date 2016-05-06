//
//  ZPFrecordModel.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/21.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface ZPFrecordModel : JSONModel

@property (nonatomic, copy) NSString *jobArea;

@property (nonatomic, copy) NSString *viewState;

@property (nonatomic, copy) NSString *resumeId;

@property (nonatomic, copy) NSString *salary;

@property (nonatomic, copy) NSString *sendDate;

@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *jobName;

@property (nonatomic, copy) NSString *sendId;

@property (nonatomic, copy) NSString *sendState;

@property (nonatomic, copy) NSString *jobId;

@property (nonatomic, copy) NSString *companyId;

@property (nonatomic, copy) NSString *updateTime;

@end


