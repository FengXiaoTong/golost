//
//  companyTableViewCell.m
//  RecruitmentProduct
//
//  Created by andorid on 16/4/13.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "companyTableViewCell.h"

@implementation companyTableViewCell


//   这是行业名企的自定义cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
    }
    return self;
}

// 添加子视图
- (void)addSubViews
{
    // 添加企业图片
    self.qyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    _qyImageView.backgroundColor = [UIColor greenColor];
    _qyImageView.image = [UIImage imageNamed:@"profile_icon"];
    [self.contentView addSubview:_qyImageView];
    
    // 添加企业名称
    self.QYnameLable = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 120, 20)];
    _QYnameLable.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:_QYnameLable];
    
    // 添加位置lable
    self.addressLable = [[UILabel alloc] initWithFrame:CGRectMake(320, 10, 50, 20)];
    _addressLable.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:_addressLable];
    
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
