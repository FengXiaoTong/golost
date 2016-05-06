//
//  LCMoperationModel.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/27.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <JSONModel/JSONModel.h>



@interface LCMoperationModel : JSONModel

@property (nonatomic, copy) NSString *user;

@property (nonatomic, copy) NSString *occurContent;

@property (nonatomic, copy) NSString *operationId;

@property (nonatomic, copy) NSString *occurDate;

@property (nonatomic, copy) NSString *occurIp;

@property (nonatomic, copy) NSString *pageName;

@end

