//
//  homeViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/3/29.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "homeViewController.h"
#import "Common.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import "zyzpSearchBar.h"
#import "searchController.h"
#import "homeTableHeaderView.h"
#import "homeTableViewCell.h"
#import "UIView+ZYFrame.h"
#import "findEnterpController.h"
#import "secondViewController.h"
#import "detailResultController.h"
#import "postDetailController.h"
#import "zyzpNavigationController.h"
#import "zyNavigationItemTool.h"
#import "EnterpriseLonginViewController.h"
#import "Account.h"
#import "zyzpEnterprTabBarController.h"
#import "zyzpTabBarController.h"
#import "homeEnterpriseCell.h"





@interface homeViewController ()<UIScrollViewDelegate>

@property (nonatomic) BOOL isHide;

@property (nonatomic, strong) UITextField *searchBar;
@property (nonatomic, strong) homeTableHeaderView *homeTabelHView;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //        [self setUpHomeVCNav];
    
    [self setUpTableViewAndFillScrollViewDate];

    
    //    if ([self.tabBarController isKindOfClass:[zyzpTabBarController class]]) {
    //        [self setUpHomeVCNav];
    //
    //        [self setUpTableViewAndFillScrollViewDate];
    //    }else{
    //        [self setUpHomeVCNav];
    //        [self setUpTableViewAndFillScrollViewDate];
    //    }
    
    
}
// 创建tableView  给轮播图填数据
-(void)setUpTableViewAndFillScrollViewDate{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style: UITableViewStyleGrouped];
    self.tableView = tableView;
    NSArray *arr = @[@"home-banner",@"home-banner",@"home-banner"];
    homeTableHeaderView *homeTabelHView = [homeTableHeaderView scrollViewImagesName:arr];
    self.tableView.tableHeaderView = homeTabelHView;
    homeTabelHView.scrollView.delegate = self;
    _homeTabelHView = homeTabelHView;
    self.tableView.rowHeight = 89;
    
    // 收键盘
    // [self clickTableViewHideKyeboard];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self setUpHomeVCNav];
    [self.tableView reloadData];
}

-(void)setUpHomeVCNav{
    //首页搜索栏

    
    UIView *zyTitleView = [zyNavigationItemTool setUpTitleBtnWithTarget:self action:@selector(titleBtnClick) smallIamge:[UIImage imageNamed:@"nav_search_icon"] backgroundImage:[UIImage imageNamed:@"nav_search_bg"] Title:@"搜索职位/公司"];
    self.navigationItem.titleView = zyTitleView;
    

    // 位置
    UIButton *leftBtn = [zyNavigationItemTool setUpLeftBtnWithTarget:self action:@selector(leftBtnClick) iamge:[UIImage imageNamed:@"1"] Title:@"郑州"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];


    
    // 首页个人/企业切换按钮
    if ([[Account currentAccount] isLogin]) {
        
        if ([[Account currentAccount] isCompany]) {
            UIButton *rightBtn = [zyNavigationItemTool setUpRightBtnWithTarget:self action:@selector(rightBtnClick) iamge:[UIImage imageNamed:@"go"]  Title:@"个人版"];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        }else{
            UIButton *rightBtn = [zyNavigationItemTool setUpRightBtnWithTarget:self action:@selector(rightBtnClick) iamge:[UIImage imageNamed:@"go"]  Title:@"企业版"];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        }
        
    }else{
        UIButton *rightBtn = [zyNavigationItemTool setUpRightBtnWithTarget:self action:@selector(rightBtnClick) iamge:[UIImage imageNamed:@"go"]  Title:@"登录"];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    }
}
// 透明button
-(void)setUpClearBtnOnSearch{
    UIButton *btn = [[UIButton alloc] initWithFrame:_searchBar.frame];
    [_searchBar addSubview:btn];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)titleBtnClick{
    [self.navigationController pushViewController:[searchController new] animated:YES];
}

-(void)leftBtnClick{
    MYLog(@"弹出位置选择框");
    
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}


//跳转企业版/个人版
-(void)rightBtnClick{
    
    //跳转企业
    //未登录状态下   跳转登录页面
    if ([[Account currentAccount] isLogin]) {
        if ([[Account currentAccount] isCompany]) {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            zyzpNavigationController *nav = [[zyzpNavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
        }else{
            EnterpriseLonginViewController *loginVC = [[EnterpriseLonginViewController alloc] init];
            zyzpNavigationController *nav = [[zyzpNavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        zyzpNavigationController *nav = [[zyzpNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }

}

#pragma mark - 切换switchVersion
-(void)rightBtnClickSwitchVersion{
    
}
//-(void)clickTableViewHideKyeboard{
//
//
//    UITapGestureRecognizer *gestureR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeboard)];
//    
//    [self.tableView addGestureRecognizer:gestureR];
//
//    gestureR.cancelsTouchesInView = NO;
//}
//
//-(void)hideKeboard{
//    [_searchBar resignFirstResponder];
//
//}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double page = scrollView.contentOffset.x/screenW;
    
    _homeTabelHView.pageControl.currentPage = (int)(page + 0.5);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([[Account currentAccount] isLogin]) {
        if ([[Account currentAccount] isCompany]) {
            homeEnterpriseCell *homeEnterpTVCell =[homeEnterpriseCell cellWithTableView:tableView];
            
            return homeEnterpTVCell;
        }else{
            homeTableViewCell *homeTVCell =[homeTableViewCell cellWithTableView:tableView];
            
            return homeTVCell;
        }
    }else{
        homeTableViewCell *homeTVCell =[homeTableViewCell cellWithTableView:tableView];
        
        return homeTVCell;
    }
}

#pragma mark - tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[postDetailController new] animated:YES];
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"";
//}
#pragma mark - 组头 四个按钮 + 职位推荐
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenW, fourBtnHight + 40)];
    _sectionView = sectionView;
    if ([[Account currentAccount] isLogin]) {
        if ([[Account currentAccount] isCompany]) {
            sectionView.height = 100;
        }else{
            sectionView.backgroundColor = zyMainColor;
            // 四个按钮
            
            // 热门职位
            UIButton *hotBtn  = [self setUpButtonsTitle:@"找名企"];
            [self setUpButtonsImage:[UIImage imageNamed:@"home_bigbtn_1"] title:@"找名企"];
            [hotBtn addTarget:self action:@selector(clickHotButton) forControlEvents:UIControlEventTouchUpInside];
            // 精品推荐
            UIButton *boutiqueBtn =[self setUpButtonsTitle:@"找高薪"];
            [self setUpButtonsImage:[UIImage imageNamed:@"home_bigbtn_2"] title:@"找高薪"];
            [boutiqueBtn addTarget:self action:@selector(clickBoutiqueBtnButton) forControlEvents:UIControlEventTouchUpInside];
            // 高薪职位
            UIButton *heightBtn =[self setUpButtonsTitle:@"找兼职"];
            [self setUpButtonsImage:[UIImage imageNamed:@"home_bigbtn_3"] title:@"找兼职"];
            [heightBtn addTarget:self action:@selector(clickHeightBtnButton) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *fastBtn = [self setUpButtonsTitle:@"招聘会"];
            [self setUpButtonsImage:[UIImage imageNamed:@"home_bigbtn_4"] title:@"招聘会"];
            [fastBtn addTarget:self action:@selector(clickFastButton) forControlEvents:UIControlEventTouchUpInside];
            
            // “职位推荐”
            [self setUpHeaderTitleView:@"职位推荐"];
            return sectionView;
        }
    }else{
        sectionView.backgroundColor = zyMainColor;
        // 四个按钮
        
        // 热门职位
        UIButton *hotBtn  = [self setUpButtonsTitle:@"找名企"];
        [self setUpButtonsImage:[UIImage imageNamed:@"home_bigbtn_1"] title:@"找名企"];
        [hotBtn addTarget:self action:@selector(clickHotButton) forControlEvents:UIControlEventTouchUpInside];
        // 精品推荐
        UIButton *boutiqueBtn =[self setUpButtonsTitle:@"找高薪"];
        [self setUpButtonsImage:[UIImage imageNamed:@"home_bigbtn_2"] title:@"找高薪"];
        [boutiqueBtn addTarget:self action:@selector(clickBoutiqueBtnButton) forControlEvents:UIControlEventTouchUpInside];
        // 高薪职位
        UIButton *heightBtn =[self setUpButtonsTitle:@"找兼职"];
        [self setUpButtonsImage:[UIImage imageNamed:@"home_bigbtn_3"] title:@"找兼职"];
        [heightBtn addTarget:self action:@selector(clickHeightBtnButton) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *fastBtn = [self setUpButtonsTitle:@"招聘会"];
        [self setUpButtonsImage:[UIImage imageNamed:@"home_bigbtn_4"] title:@"招聘会"];
        [fastBtn addTarget:self action:@selector(clickFastButton) forControlEvents:UIControlEventTouchUpInside];
        
        // “职位推荐”
        [self setUpHeaderTitleView:@"职位推荐"];
        return sectionView;

    }
    UIButton *publishingBtn =[self getEnterpriseHomeHeaderBtns:@"150" unitName:@"个" downTitle:@"发布中的职位"];
    [publishingBtn addTarget:self action:@selector(clickPublishingBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self getEnterpriseHomeHeaderBtns:@"4567" unitName:@"份" downTitle:@"最近一周简历"];
    [self getEnterpriseHomeHeaderBtns:@"152" unitName:@"份" downTitle:@"共收到简历"];
    [self getEnterpriseHomeHeaderBtns:@"4568" unitName:@"枚" downTitle:@"指慧豆"];
    
    [self setUpHeaderTitleView:@"人才推荐"];
    return _sectionView;
}

-(void)setUpHeaderTitleView:(NSString *)title{
    UILabel *lab = [[UILabel alloc] init];
    UIView *downView = [[UIView alloc] init];
    downView.x = 0;
    downView.y = CGRectGetMaxY(_sectionView.frame) - 30;
    downView.width = screenW;
    downView.height = 30;
    downView.backgroundColor = Color(54, 103, 201);
    [_sectionView addSubview:downView];
    
    lab.text = title;
    lab.textColor = [UIColor whiteColor];
    [lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    lab.backgroundColor = Color(54, 103, 201);
    [lab sizeToFit];
    lab.x = (screenW - lab.width)/2;
    lab.y = (downView.height - lab.height)/2;
    
    UIImageView *lineImageV1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_tuijian_line"]];
    lineImageV1.height = 1;
    lineImageV1.y = (downView.height - lineImageV1.height)/2;
    lineImageV1.width = 80;
    lineImageV1.x = lab.x - 20 - lineImageV1.width;
    [downView addSubview:lineImageV1];
    
    UIImageView *lineImageV2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_tuijian_line"]];
    lineImageV2.height = lineImageV1.height;
    lineImageV2.width = lineImageV1.width;
    lineImageV2.x = CGRectGetMaxX(lab.frame) + 20;
    lineImageV2.y = (downView.height - lineImageV1.height)/2;
    [downView addSubview:lineImageV2];
    [downView addSubview:lab];
}

#pragma mark - 企业版四个按钮
static int a = 0;
-(UIButton *)getEnterpriseHomeHeaderBtns:(NSString *)numberStr unitName:(NSString *)unitName downTitle:(NSString *)downTitle{
    UIButton *enterpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    int margin = 10;
    enterpBtn.width = (screenW - 2*margin)/4;
    enterpBtn.x = a * enterpBtn.width + margin;
    enterpBtn.y = 16;
    enterpBtn.height = 46;
    //  enterpBtn.layer.
    // 设置边框宽度
    [enterpBtn.layer setBorderWidth:0.5];
    // 设置边框颜色
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.3 });
    [enterpBtn.layer setBorderColor:colorref];
    
    UILabel *downLab = [[UILabel alloc] init];
    downLab.text = downTitle;
    downLab.font = [UIFont systemFontOfSize:12];
    [downLab sizeToFit];
    downLab.x = 0;
    downLab.y = enterpBtn.height - 4 - downLab.height;
    downLab.width = enterpBtn.width;
    downLab.textAlignment = NSTextAlignmentCenter;
    downLab.textColor = zyMainColor;
    [enterpBtn addSubview:downLab];
    
    // 红色字
    UILabel *numberLab = [[UILabel alloc] init];
    numberLab.textColor = [UIColor redColor];
    numberLab.text = numberStr;
    numberLab.font = [UIFont systemFontOfSize:15];
    [numberLab sizeToFit];
    numberLab.x = 0;
    numberLab.y = 0;
    // 单位
    UILabel *unitLab = [[UILabel alloc] init];
    unitLab.text = unitName;
    unitLab.font = [UIFont systemFontOfSize:10];
    [unitLab sizeToFit];
    unitLab.x = CGRectGetMaxX(numberLab.frame);
    unitLab.y = CGRectGetMaxY(numberLab.frame) - unitLab.height;
    
    UIView *upView = [[UIView alloc] init];
    upView.width = numberLab.width + unitLab.width;
    upView.height = numberLab.height;
    upView.x = (enterpBtn.width - upView.width)/2;
    upView.y = 8;
    [upView addSubview:numberLab];
    [upView addSubview:unitLab];
    
    [enterpBtn addSubview:upView];
    [_sectionView addSubview:enterpBtn];


    a ++;
    if (a == 4) {
        a= 0;
    }
    
    
    
    return enterpBtn;
}
#pragma mark - 企业版四个按钮点击
-(void)clickPublishingBtn{
    MYLog(@"点击了 发布中的职位");
}

#pragma mark - 个人版 四个按钮
static int t = 0;
-(void)setUpButtonsImage:(UIImage *)image title:(NSString *)title{
    
    float margin = 24;
    float bigMargin = (screenW - 2*margin - 4*60)/3;
    //图片
    UIImageView *imaView = [[UIImageView alloc] initWithImage:image];
    imaView.width = 60;
    imaView.height = 60;
    imaView.x = margin + t*(imaView.width + bigMargin);
    imaView.y = 10;
    //文字
    UILabel *lab = [[UILabel alloc] init];
    lab.text = title;
    lab.textColor = [UIColor whiteColor];
    lab.x = imaView.x;
    lab.y = CGRectGetMaxY(imaView.frame) + 9;
    lab.width = 60;
    lab.textAlignment = NSTextAlignmentCenter;
    [lab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [lab sizeToFit];
    
    [_sectionView addSubview:imaView];
    [_sectionView addSubview:lab];
    t ++;
    if (t == 4) {
        t = 0;
    }
}


static int i = 0;

-(UIButton *)setUpButtonsTitle:(NSString *)title{
    int total = 4;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.width = screenW/total;
    btn.height = fourBtnHight;
    btn.x = i* btn.width;
    btn.y = 0;
    
    i ++;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [btn setTitleColor:zyMainColor forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    [_sectionView addSubview:btn];
    if (i == 4) {
        i = 0;
    }
    
    return btn;
}
#pragma mark - 个人四个按钮 点击事件
-(void)clickHotButton{
    MYLog(@"找名企");
    [self.navigationController pushViewController:[findEnterpController new] animated:YES];
}
-(void)clickBoutiqueBtnButton{
    MYLog(@"找高薪");
}

-(void)clickHeightBtnButton{
    MYLog(@"找兼职");
}
-(void)clickFastButton{
    MYLog(@"招聘会");
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([[Account currentAccount] isLogin]) {
        if ([[Account currentAccount] isCompany]) {
            return 100;
        }else{
            return fourBtnHight + 30;
        }
    }else{
        return fourBtnHight + 30;
    }
}




@end
