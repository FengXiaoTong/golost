//
//  ZPFHrLetterModel.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/20.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ZPFHrLetterModel : JSONModel


@property (nonatomic, copy) NSString *resumeId;

@property (nonatomic, copy) NSString *sendPersonID;

@property (nonatomic, copy) NSString *lettersId;

@property (nonatomic, copy) NSString *replyTime;

@property (nonatomic, copy) NSString *sendTime;

@property (nonatomic, copy) NSString *lettersType;

@property (nonatomic, copy) NSString *receiveTime;

@property (nonatomic, copy) NSString *lettersTemplateId;

@property (nonatomic, copy) NSString *lettersTitle;

@property (nonatomic, copy) NSString *pageJump;

@property (nonatomic, copy) NSString *replyState;

@property (nonatomic, copy) NSString *lettersState;

@property (nonatomic, copy) NSString *sendPerson;

@property (nonatomic, copy) NSString *handleState;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *lettersContent;

@property (nonatomic, copy) NSString *receivePerson;

@property (nonatomic, copy) NSString *personReplyTime;

@property (nonatomic, copy) NSString *replyContent;

@property (nonatomic, assign) NSInteger pageEnd;

@property (nonatomic, copy) NSString *typeId;

@property (nonatomic, copy) NSString *view;

@property (nonatomic, copy) NSString *receivePersonId;

@property (nonatomic, copy) NSString *jobId;

@property (nonatomic, assign) NSInteger pageStart;



@end

