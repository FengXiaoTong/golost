//
//  ZPFsingleChatViewModel.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/5.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface ZPFsingleChatViewModel : JSONModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *isRead;

@property (nonatomic, copy) NSString *sendTime;

@property (nonatomic, copy) NSString *dialogueId;

@property (nonatomic, copy) NSString *contents;

@property (nonatomic, copy) NSString *memberId;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *ID;

@end

