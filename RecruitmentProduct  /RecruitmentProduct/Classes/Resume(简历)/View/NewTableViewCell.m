//
//  NewTableViewCell.m
//  RecruitmentProduct
//

#import "NewTableViewCell.h"

@implementation NewTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label1 = [[UILabel alloc]initWithFrame:CGRectMake(24, 14, 150, 15)];
        [self.contentView addSubview:_label1];
    
        _label2 = [[UILabel alloc]initWithFrame:CGRectMake(180, 15, 150, 15)];
        _label2.textAlignment = NSTextAlignmentLeft;
         [self.contentView addSubview:_label2];
        

    }
    return self;
}


-(void)setLabel1Text:(NSString *)text1 label2Text:(NSString *)text2
{
    _label1.text = text1;
    _label2.text = text2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
