//
//  ZPFsingleChatViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/5.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ZPFsingleChatViewCell.h"





@implementation ZPFsingleChatViewCell {
    /**
     *  聊天时间
     */
    
    UILabel *_chatTimeView;
    /**
     *  聊天头像
     */
    UIImageView *_iconImageView;
    /**
     *  聊天内容
     */
    UIButton *_chatTextView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self customViews];
    }
    return self;
}
//
- (void)customViews {
    /**
     *  初始化聊天控件
     */
    _chatTimeView = [UILabel new];
    _chatTimeView.textAlignment = NSTextAlignmentCenter;
    _chatTimeView.font = [UIFont systemFontOfSize:12];
    _chatTimeView.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_chatTimeView];
    
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    
    _chatTextView = [UIButton buttonWithType:UIButtonTypeCustom];
    _chatTextView.titleLabel.font = TEXT_FONT;
    _chatTextView.titleLabel.numberOfLines = 0;
    [_chatTextView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _chatTextView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    [self.contentView addSubview:_chatTextView];
    
}

- (void)setCellFrame:(ZPFchatViewCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    
    _chatTimeView.text = _cellFrame.model.sendTime;
    _chatTimeView.frame = _cellFrame.chatTimeFrame;
    
//    NSString *_iconName = _cellFrame.messageModel.type == ChatMessageTypeOther?@"other":@"me";
    
//    _iconImageView.image = [UIImage imageNamed:_iconName];
    _iconImageView.frame = _cellFrame.iconImageFrame;
    
    [_chatTextView setTitle:_cellFrame.model.contents forState:UIControlStateNormal];
    _chatTextView.frame = _cellFrame.chatTextFrame;
    
    //设置聊天背景
//    NSString *backImageName = _cellFrame.messageModel.type == ChatMessageTypeOther?@"chat_recive_nor":@"chat_send_nor";
    /**
     *  stretchableImageWithLeftCapWidth 拉伸图片不变形
     */

//    UIImage *backImage = [UIImage imageNamed:backImageName];
//    [_chatTextView setBackgroundImage:[backImage stretchableImageWithLeftCapWidth:backImage.size.width*0.5 topCapHeight:backImage.size.height*0.5] forState:UIControlStateNormal];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
