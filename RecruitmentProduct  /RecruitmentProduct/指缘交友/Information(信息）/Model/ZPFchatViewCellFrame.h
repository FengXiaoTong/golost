//
//  ZPFchatViewCellFrame.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/5.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZPFsingleChatViewModel.h"


#define TEXT_FONT [UIFont systemFontOfSize:12] 

@interface ZPFchatViewCellFrame : NSObject

/**
 *  聊天时间的 Frame
 */
@property (nonatomic, assign) CGRect chatTimeFrame;
/**
 *  聊天头像 Frame
 */
@property (nonatomic, assign) CGRect iconImageFrame;

/**
 *  聊天内容 Frame
 */
@property (nonatomic, assign) CGRect chatTextFrame;
/**
 *  cell的高度
 */
@property (nonatomic, assign) CGFloat chatCellHeight;

/**
 *  聊天模型 Model
 */
@property (nonatomic, strong) ZPFsingleChatViewModel *model;




@end
