//
//  LCMmessageModel.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/27.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LCMmessageModel : JSONModel

@property (nonatomic, copy) NSString *messageId;

@property (nonatomic, copy) NSString *messageUrl;

@property (nonatomic, copy) NSString *occurDate;

@property (nonatomic, copy) NSString *messageState;

@property (nonatomic, copy) NSString *receiveId;

@property (nonatomic, copy) NSString *messageContent;

@property (nonatomic, copy) NSString *messageType;

@property (nonatomic, copy) NSString *receiveType;

@end

