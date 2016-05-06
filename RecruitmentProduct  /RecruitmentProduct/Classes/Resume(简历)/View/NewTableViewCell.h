//
//  NewTableViewCell.h
//  RecruitmentProduct
//

#import <UIKit/UIKit.h>

@interface NewTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel * label1;

@property(nonatomic, strong)UILabel* label2;

-(void)setLabel1Text:(NSString *)text1 label2Text:(NSString *)text2;

@end
