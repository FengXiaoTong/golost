//
//  ZPFfocusModel.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/20.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface ZPFfocusModel : JSONModel

@property (nonatomic, assign) NSInteger jobNum;

@property (nonatomic, copy) NSString *storeCompanyId;

@property (nonatomic, copy) NSString *companyAddress;

@property (nonatomic, copy) NSString *companyId;

@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *storeDate;


@end




