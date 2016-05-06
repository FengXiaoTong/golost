//
//  interestController.m
//  RecruitmentProduct
//  Created by runsheng on 16/3/29.
//
//  Created by zy on 16/4/6.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "interestController.h"
#import "guideWorkViewController.h"
#import "zyzpTabBarController.h"
#import "UIView+ZYFrame.h"
#import "Common.h"

@interface interestController ()
@property (weak, nonatomic) IBOutlet UIButton *workBtn;
@property (weak, nonatomic) IBOutlet UIButton *talentsBtn;

@end

@implementation interestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _workBtn.layer.cornerRadius = 10.0;
    _talentsBtn.layer.cornerRadius = 10.0;
    
    // Do any additional setup after loading the view from its nib.
    // Do any additional setup after loading the view from its nib.
    //dsfghjkl;'\

}
- (IBAction)btnClick:(UIButton *)sender {
    
    [self presentViewController:[guideWorkViewController new] animated:YES completion:NULL];

    
    if (sender.tag == 1) {
        
    }else if (sender.tag == 2){
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
