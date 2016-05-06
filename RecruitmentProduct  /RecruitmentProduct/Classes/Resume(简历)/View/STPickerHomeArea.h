//
//  STPickerArea.h
//  STPickerView
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class STPickerHomeArea;
@protocol  STPickerHomeAreaDelegate<NSObject>

- (void)pickerHomeArea:(STPickerHomeArea *)pickerHomeArea province:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end
@interface STPickerHomeArea : UIButton

@property(nonatomic, weak)id <STPickerHomeAreaDelegate>delegate ;

- (instancetype)initWithDelegate:(nullable id /*<STPickerHomeAreaDelegate>*/)delegate;


- (void)show;
@end
NS_ASSUME_NONNULL_END