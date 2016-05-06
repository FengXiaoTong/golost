//
//  ZPFchatViewCellFrame.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/5.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ZPFchatViewCellFrame.h"
#import "Common.h"
#import "ZPFLableOperation.h"

@implementation ZPFchatViewCellFrame


- (void)setModel:(ZPFsingleChatViewModel *)model {
    _model = model;

    if (_model.sendTime) {
        _chatTimeFrame = CGRectMake(0, 0, screenW, 20);
    }
    CGFloat chatPadding = 10;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    CGFloat iconY = CGRectGetMaxY(_chatTimeFrame);
    if ([_model.type isEqualToString:@"02"]) {
        _iconImageFrame = CGRectMake(screenW - iconW - chatPadding, iconY, iconW, iconH);
    }else {
        _iconImageFrame = CGRectMake(chatPadding, iconY, iconW, iconH);
    }
/*
    CGFloat chatTextW = screenW - ;
    CGFloat chatTextX;
    CGFloat chatTextY = iconY;
    CGSize chatSize = [ZPFLableOperation sizeWithText:_model.contents maxSize:CGSizeMake(chatTextW, MAXFLOAT) font:TEXT_FONT];
//    CGSize chatSize = [_model.contents sizeWithFont:WFTEXYFONT maxSize:CGSizeMake(chatTextW, MAXFLOAT)];
    if (_messageModel.type == ChatMessageTypeOther) {
        chatTextX = CGRectGetMaxX(_iconImageFrame) + chatPadding;
    }else {
        chatTextX = screenWidth() - iconW - chatPadding - chatSize.width - chatPadding - 2*20;
    }
    _chatTextFrame = CGRectMake(chatTextX, chatTextY, chatSize.width+2*20, chatSize.height+2*20);
    /
     *  cell 的高度要综合考虑情况(要考虑只有一行的情况)
     *
     *  @param _iconImageFrame
     *
     *  @return
     /
    _chatCellHeight = MAX(CGRectGetMaxY(_iconImageFrame) + chatPadding, CGRectGetMaxY(_chatTextFrame)+ chatPadding);
    
    
  */


}




@end
