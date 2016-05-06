//
//  LCMbeanModel.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/28.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <JSONModel/JSONModel.h>

//@class Rechargelist;
@interface LCMbeanModel : JSONModel

//@property (nonatomic, copy) NSString *status;
//
//@property (nonatomic, copy) NSString *message;
//
//@property (nonatomic, strong) NSArray<Rechargelist *> *rechargeList;
//
//@property (nonatomic, copy) NSString *zyMoney;
//
//@property (nonatomic, copy) NSString *orderNo;
//
//@property (nonatomic, copy) NSString *companyName;
//
//@end
//@interface Rechargelist : NSObject

@property (nonatomic, copy) NSString *payMoney;

@property (nonatomic, copy) NSString *createPerson;

@property (nonatomic, assign) NSInteger rscount;

@property (nonatomic, copy) NSString *payId;

@property (nonatomic, copy) NSString *payDate;

@property (nonatomic, copy) NSString *payType;

@property (nonatomic, copy) NSString *payState;

@property (nonatomic, copy) NSString *payNo;

@property (nonatomic, copy) NSString *day;

@property (nonatomic, copy) NSString *year;

@property (nonatomic, assign) NSInteger currentpage;

@property (nonatomic, copy) NSString *orderNo;

@property (nonatomic, assign) NSInteger dateType;

@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *months;

@property (nonatomic, copy) NSString *payAccount;

@property (nonatomic, assign) NSInteger pageEnd;

@property (nonatomic, copy) NSString *zyMoney;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSInteger pageStart;

@end

