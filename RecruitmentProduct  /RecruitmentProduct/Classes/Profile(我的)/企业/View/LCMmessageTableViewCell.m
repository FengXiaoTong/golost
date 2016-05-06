//
//  LCMmessageTableViewCell.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/27.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMmessageTableViewCell.h"
#import "ZPFLableOperation.h"
#import <UIImageView+WebCache.h>
#import "Common.h"

#define TITLE_FONT 16

#define NAME_FONT 13


@interface LCMmessageTableViewCell ()

@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *systemMessageLabel;
@property (nonatomic, strong) UILabel *timeMessageLabel;
//@property (nonatomic, strong) NSString *messageString;
@property (nonatomic, copy) NSMutableString *string;
@property (nonatomic) NSRange range;

@end

@implementation LCMmessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addCustom];
    }
    return self;
}
- (void)addCustom {
    
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.font = [UIFont systemFontOfSize:TITLE_FONT];
    _messageLabel.numberOfLines = 0;
    _messageLabel.textColor = Color(80, 80, 80);
    [self.contentView addSubview:_messageLabel];
    
    _systemMessageLabel = [[UILabel alloc] init];
    _systemMessageLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _systemMessageLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_systemMessageLabel];
    
    _timeMessageLabel = [[UILabel alloc] init];
    _timeMessageLabel.font = [UIFont systemFontOfSize:NAME_FONT];
    _timeMessageLabel.textColor = Color(100, 100, 100);
    [self.contentView addSubview:_timeMessageLabel];
    
    
}

- (void)setModel:(LCMmessageModel *)model {
    
    _model = model;
    
    
    _string = [NSMutableString stringWithString:_model.messageContent];
    _messageLabel.text = [self  stingss];
    
    _systemMessageLabel.text = _model.messageType;
    
    _timeMessageLabel.text = _model.occurDate;
    
}

- (NSString *)stingss {
    
    
    for (int i = 0; i < _string.length; i++) {
        
        char c = [_string characterAtIndex:i];
        if (c == '<') {
            _range.location = i;
        }
        if (c == '>') {
            _range.length = i-_range.location+1;
            [_string deleteCharactersInRange:_range];
            
            [self stingss];
        }
        
    }
    
    return _string;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat title_top = 16.0;
    CGFloat title_left = 23.0;
    CGFloat gap = 10.0;
    CGFloat gaps = 20.0;
    
    CGSize message_size = [ZPFLableOperation sizeWithText:_string maxSize:CGSizeMake(screenW-title_left, TITLE_FONT*3) font:[UIFont systemFontOfSize:TITLE_FONT]];
    _messageLabel.frame = CGRectMake(title_left, title_top, message_size.width-10, message_size.height);
    
    CGSize system_size = [ZPFLableOperation sizeWithText:_model.messageType maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _systemMessageLabel.frame = CGRectMake(title_left, CGRectGetMaxY(_messageLabel.frame) + gap, system_size.width, system_size.height);
    
    CGSize timeMessage_size = [ZPFLableOperation sizeWithText:_model.occurDate maxSize:CGSizeMake(CGFLOAT_MAX, NAME_FONT) font:[UIFont systemFontOfSize:NAME_FONT]];
    _timeMessageLabel.frame = CGRectMake(CGRectGetMaxX(_systemMessageLabel.frame) + gaps, CGRectGetMaxY(_messageLabel.frame) + gap, timeMessage_size.width, timeMessage_size.height);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
/**
 *
 */
@end
