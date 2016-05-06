//
//  LCMcompanyMYViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/23.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "LCMcompanyMYViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "UIView+ZYFrame.h"
#import "Common.h"
#import "LCMcompanyTableViewCell.h"
#import "LCMcompayModel.h"
#import "zyzpHttpTool.h"
#import "Common.h"
#import "Account.h"
#import "zyzpNavigationController.h"
#import "LoginViewController.h"
#import "STPickerArea.h"
#import "ZPFotherCompanyInfoController.h"
#import "ZPFfillInformationController.h"


#define URLSTRING @"updateCompanyInfo.htm"
#define SELECTINFO @"selectCompanyInfo.htm"


@interface LCMcompanyMYViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,STPickerAreaDelegate>     //<UIActionSheetDelegate,UITextFieldDelegate,UIPickerViewDelegate,STPickerAreaDelegate,STPickerHomeAreaDelegate>


@property (nonatomic, strong) UITableView *companyTableView;

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *promptArr;
@property (nonatomic, strong) NSMutableArray *textArr;
@property (nonatomic,strong) LCMcompayModel *model;

@end

@implementation LCMcompanyMYViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"修改公司设置";
    _textArr = [NSMutableArray array];
    [self createDataSource];
    [self createTableView];
    self.companyTableView.tableHeaderView = [self tableviewHeadView];
    self.companyTableView.tableFooterView = [self tableViewFooterView];
    
}

- (void)createDataSource {
    _titleArr = @[@"公司名称",@"公司所在地",@"联系人",@"联系人性别",@"联系电话",@"电子邮箱"];
    _promptArr = @[@"请输入公司名称",@"请选择公司所在地",@"请输入联系人姓名",@"",@"请输入公司联系电话",@"请输入公司邮箱"];
}

- (void)createTableView {

    _companyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH - 44)];
    _companyTableView.delegate =self;
    _companyTableView.dataSource = self;
    [self.view addSubview: _companyTableView];
    [self refreshData];
}

- (void)refreshData {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    _companyTableView.mj_header = header;
    
    [_companyTableView.mj_header beginRefreshing];
    
}



- (void)loadDataFromNet:(BOOL)isMore {
    

    NSString *URLString = [baseUrl stringByAppendingString:SELECTINFO];
    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
    
 
    
    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        
        NSDictionary *dict = responseObject[@"data"];
        _model = [[LCMcompayModel alloc] init];
        [_model setValuesForKeysWithDictionary:dict];
        [_companyTableView reloadData];
        
        isMore?[_companyTableView.mj_footer endRefreshing]:[_companyTableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        isMore?[_companyTableView.mj_footer endRefreshing]:[_companyTableView.mj_header endRefreshing];
    }];
    
    
}


-(void)displayerCompanyLogo {

    [_logoImageView sd_setImageWithURL:[NSURL URLWithString:_model.logoFilePath] placeholderImage:[UIImage imageNamed:@"moren"]];
    _titleLable.text = _model.companyName;

}


- (UIView *)tableviewHeadView {

    /**
     创建头视图
     */
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenW/2)];
    headerView.backgroundColor = [UIColor whiteColor];
    /**
     *  添加可点击上传头像
     */

    _logoImageView = [[UIImageView alloc] init];

    _logoImageView.image = [UIImage imageNamed:@"moren"];
    
    [_logoImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"moren"]];
    _logoImageView.x = screenW/3;
    _logoImageView.y = 15;
    _logoImageView.width = screenW/3;
    _logoImageView.height = screenW/3;
    _logoImageView.layer.cornerRadius = _logoImageView.width/2;
    _logoImageView.clipsToBounds = YES;
    
    _logoImageView.userInteractionEnabled = YES;
    [headerView addSubview:_logoImageView];
    
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconBtnClick)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [_logoImageView addGestureRecognizer:singleRecognizer];
    
    /**
     添加提示文字
     */
    
    _titleLable = [[UILabel alloc] init];
    _titleLable.text = @"上传企业Logo";
    _titleLable.font = [UIFont systemFontOfSize:15];
    [_titleLable sizeToFit];
    _titleLable.x = (screenW - _titleLable.width) / 2;
    _titleLable.y = _logoImageView.height + _logoImageView.y + 10;
    _titleLable.textColor = Color(100, 100, 100);
    [headerView addSubview:_titleLable];
    return headerView;

}

- (UIView *)tableViewFooterView {

    CGFloat top = 100;
    CGFloat height = 40;
    CGFloat left = 50;
    CGFloat width = screenW - 100;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, width, top + height);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"其他企业信息" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(footerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(left, top, width, height);
    [footerView addSubview:button];

    return footerView;
}

- (void)footerButtonAction {
    
    ZPFotherCompanyInfoController *other = [[ZPFotherCompanyInfoController alloc] init];
    [self.navigationController pushViewController:other animated:YES];

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 43;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    LCMcompanyTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
      if (cell == nil) {
        cell = [[LCMcompanyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSString *modelString;
    
    if (indexPath.row == 0) {
        modelString = _model.companyName;
    } else if (indexPath.row == 1) {
        modelString = _model.companyAreaName;
    } if (indexPath.row == 2) {
        modelString = _model.linkman;
    } else if (indexPath.row == 3) {
        modelString = _model.manOrWoman;
    } if (indexPath.row == 4) {
        modelString = _model.jobPhone;
    } else if (indexPath.row == 5) {
        modelString = _model.companyEmail;
    }
    if (modelString == nil) {
        [_textArr addObject:@""];

    }else {
        _textArr[indexPath.row] = modelString;
    }
    
    [cell setModel:modelString withStandbyString:_promptArr[indexPath.row] withTitleString:_titleArr[indexPath.row]];
    
    
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5) {
        

        ZPFfillInformationController *fillInfo = [[ZPFfillInformationController alloc] init];
        
        fillInfo.placeholder = _promptArr[indexPath.row];
        fillInfo.text = _textArr[indexPath.row];
        [self.navigationController pushViewController:fillInfo animated:YES];

    }else if(indexPath.row == 1) {
    
        [[[STPickerArea alloc] initWithDelegate:self] show];

    }
}


- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    
    NSLog(@" ---- %@  ---- %@  -----  %@",province,city,area);
    
}



/*
- (void)loginToRemind{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲爱的用户，您好！" message:@"您还未登录，请确认登录！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self iconBtnsClick];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}
- (void)iconBtnsClick{
    
    //未登录状态下   跳转登录页面
    
    if (![[Account currentAccount] isLogin]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        zyzpNavigationController *nav = [[zyzpNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
 */
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
