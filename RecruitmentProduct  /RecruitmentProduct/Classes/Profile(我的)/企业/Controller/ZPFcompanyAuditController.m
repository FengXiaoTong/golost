//
//  LCMcompanyMYViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/23.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ZPFcompanyAuditController.h"
#import <UIImageView+WebCache.h>
#import "UIView+ZYFrame.h"
#import "Common.h"
#import "LCMcompayModel.h"
#import "zyzpHttpTool.h"
#import "Account.h"
#import "zyzpNavigationController.h"
#import "LoginViewController.h"
#import "ZPFLableOperation.h"


#define FONT 17

#define URLSTRING @"updateCompanyInfo.htm"
#define SELECTINFO @"selectCompanyInfo.htm"


@interface ZPFcompanyAuditController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *stateLable;

@property (nonatomic,strong) LCMcompayModel *model;

@property (nonatomic, strong) UIScrollView *scroll;

@end

@implementation ZPFcompanyAuditController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = Color(230, 230, 230);
    self.title = @"企业审核";
    [self loadDataFromNet];

    
    _scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scroll.userInteractionEnabled = YES;
    _scroll.bounces = NO;
    
    self.view = _scroll;
    
    
    [self thePageLayout];
}

//页面布局
- (void)thePageLayout {

    CGFloat top = 25;
    CGFloat viewHeight = 40;

    CGFloat title_left = 20;
    CGFloat title_top = 10;
    CGFloat state_right = 20;
    
    
    
    
    
    //创建第一个View
    
    UIView *stateView = [[UIView alloc] initWithFrame:CGRectMake(0, top, screenW, viewHeight)];
    stateView.backgroundColor = [UIColor whiteColor];
    [_scroll addSubview:stateView];

    CGFloat lab_width = [self width:@"审核状态"];
    UILabel *stateTitle = [[UILabel alloc] initWithFrame:CGRectMake(title_left, title_top, lab_width, FONT)];
    stateTitle.text = @"审核状态";
    [stateView addSubview:stateTitle];
    
    
    NSString *checkState;
    if (_model.checkState) {
        checkState = _model.checkState;
    }else {
        checkState = @"正在加载";
    }
    lab_width = [self width:checkState];
    _stateLable = [[UILabel alloc] initWithFrame:CGRectMake(screenW - lab_width - state_right, title_top, lab_width, FONT)];
    _stateLable.text = checkState;
    _stateLable.textColor = [UIColor blueColor];
    [stateView addSubview:_stateLable];
    stateView.layer.borderWidth = 1;
    stateView.layer.borderColor =  Color(130, 130, 130).CGColor;//  [UIColor blackColor].CGColor;
    
    UITapGestureRecognizer *stateRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateViewAction)];
    stateRecognizer.numberOfTapsRequired = 1; // 单击
    [stateView addGestureRecognizer:stateRecognizer];
    
    

    
    //创建第二个view
    UIView *replaceView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(stateView.frame)-1, screenW, viewHeight)];
    replaceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:replaceView];

    lab_width = [self width:@"更换营业执照"];
    UILabel *replaceTitle = [[UILabel alloc] initWithFrame:CGRectMake(title_left, title_top, lab_width, FONT)];
    replaceTitle.text = @"更换营业执照";
    [replaceView addSubview:replaceTitle];

    CGSize image_size = CGSizeMake(8, 14);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gogo"]];
    imageView.frame = CGRectMake(screenW - image_size.width - state_right, title_top, image_size.width, image_size.height);
    [replaceView addSubview:imageView];
    
    replaceView.layer.borderWidth = 1;
    replaceView.layer.borderColor = Color(130, 130, 130).CGColor;
    
    UITapGestureRecognizer *replaceRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(replaceViewAction)];
    replaceRecognizer.numberOfTapsRequired = 1; // 单击
    [stateView addGestureRecognizer:replaceRecognizer];

    CGFloat logo_top = 80;
    CGFloat logo_width = screenW/3;
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenW/3, CGRectGetMaxY(replaceView.frame) + logo_top, logo_width, logo_width)];
    _logoImageView.backgroundColor = [UIColor whiteColor];
    _logoImageView.image = [UIImage imageNamed:@"jiahao"];
    [_scroll addSubview:_logoImageView];
    
    UITapGestureRecognizer *logoRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoViewAction)];
    logoRecognizer.numberOfTapsRequired = 1; // 单击
    [_logoImageView addGestureRecognizer:logoRecognizer];
    
    
    
    
    //温馨提示
    CGFloat prompt_top = 80;
    UILabel *prompt = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_logoImageView.frame) + prompt_top, screenW, FONT)];
    prompt.textColor = Color(150, 150, 150);
    prompt.font = [UIFont systemFontOfSize:13];
    prompt.text = @"温馨提示：请上传有最新年检的营业执照";
    prompt.textAlignment = NSTextAlignmentCenter;
    [_scroll addSubview:prompt];
    
    
    

    //最下面的button
    CGFloat bt_top = 80;
    CGFloat bt_left = 20;
    CGFloat bt_height = 40;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    button.frame = CGRectMake(bt_left, CGRectGetMaxY(prompt.frame) + bt_top, screenW - bt_left*2, bt_height);
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    [_scroll addSubview:button];
    
    _scroll.contentSize = CGSizeMake(screenW, CGRectGetMaxY(button.frame) + 40);
    


}


- (void)buttonAction {
    MYLog(@"提交");

}

- (void)stateViewAction {
    MYLog(@"查看状态");

}

- (void)replaceViewAction:(UITapGestureRecognizer *)tgr {
    MYLog(@"diao");
    
}

- (void)logoRecognizer{
    MYLog(@"zhen");
    [self iconBtnClick];
}



//计算label宽度
- (CGFloat)width:(NSString *)string {

    return [ZPFLableOperation sizeWithText:string maxSize:CGSizeMake(CGFLOAT_MAX, FONT) font:[UIFont systemFontOfSize:FONT]].width;
}




- (void)loadDataFromNet {
    NSString *URLString = [baseUrl stringByAppendingString:SELECTINFO];
    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
    
    
    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        _model = [[LCMcompayModel alloc] init];
        [_model setValuesForKeysWithDictionary:dict];
        
        if (_stateLable) {
            _stateLable.text = _model.checkState;
        }
        if (_logoImageView) {
            [_logoImageView sd_setImageWithURL:[NSURL URLWithString:_model.companyUrl]placeholderImage:[UIImage imageNamed:@"jiahao"]];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
}







- (void)iconBtnClick {
    
    UIAlertController * alert = [ UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
        pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerVC.allowsEditing = YES;
        pickerVC.delegate = self;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
        pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerVC.allowsEditing = YES;
        pickerVC.delegate = self;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}


/**
 *  选取或拍照
 */
-(void)alterHeadPortraits:(UITapGestureRecognizer *)gesture {
    UIAlertController * alert = [ UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
        pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerVC.allowsEditing = YES;
        pickerVC.delegate = self;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
        pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerVC.allowsEditing = YES;
        pickerVC.delegate = self;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
