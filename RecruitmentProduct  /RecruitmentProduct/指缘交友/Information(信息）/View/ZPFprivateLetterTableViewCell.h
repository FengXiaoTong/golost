//
//  ZPFprivateLetterTableViewCell.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/5/4.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPFprivateLetterModel.h"
@interface ZPFprivateLetterTableViewCell : UITableViewCell

@property (nonatomic, strong) ZPFprivateLetterModel *model;

- (void)privateLetterSetModel:(ZPFprivateLetterModel *)model;




@end
