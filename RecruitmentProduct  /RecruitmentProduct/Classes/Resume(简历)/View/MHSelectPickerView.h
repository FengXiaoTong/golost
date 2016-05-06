//
//  MHSelectPickerView.h
//  MHDatePicker
//
//

#import <UIKit/UIKit.h>

@interface MHSelectPickerView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;

@end
