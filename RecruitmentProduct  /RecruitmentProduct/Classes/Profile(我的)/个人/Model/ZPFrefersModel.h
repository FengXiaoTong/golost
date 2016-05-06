//
//  ZPFrefersModel.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/21.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface ZPFrefersModel : JSONModel

@property (nonatomic, copy) NSString *userID;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *payType;

@property (nonatomic, assign) NSInteger turnOver;

@property (nonatomic, copy) NSString *Date;

@property (nonatomic, copy) NSString *payDate;

@property (nonatomic, copy) NSString *streamID;

@property (nonatomic, copy) NSString *createPerson;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *userType;

@end




