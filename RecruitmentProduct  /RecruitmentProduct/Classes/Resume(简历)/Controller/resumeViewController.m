//
//  resumeViewController.m
//  RecruitmentProduct
//  {  请求下来的数据
//updateDate = 2016-04-20 17:20:00;
//makeDate = ;
//uCreatDate = ;
//personName = 测试姓名;
//degree = ;
//personId = 21B1EA5006A411E6AA50E17C081BBBE2;
//nowAddress = 52;
//politicsStatus = ;
//personCount = 0;
//resumeId = ;
//integrity = ;
//marriageState = ;
//agentType = ;
//agentProvinceId = ;
//nowCountryName = ;
//resumeTotal = 0;
//createDate = 2016-04-20 11:20:00;
//inviterType = ;
//personSex = 01;
//agentCityName = ;
//blockedMoney = ;
//letterCount = 0;
//birthdayStr = ;
//workDate = 0;
//isTrade = ;
//pageStart = 0;
//userName = ;
//fileId = ;
//pageEnd = 0;
//beginYear = ;
//isAbroad = ;
//sendCount = 0;
//checkLinkType = ;
//endYear = ;
//jobBeginStr = ;
//zyMoney = 3;
//cardNO = ;
//relationshipId = ;
//inviterId = ;
//fileState = ;
//provinceId = ;
//storeCount = 0;
//tradeNum = 0;
//workDateStr = ;
//oneDay = ;
//inviterState = 02;
//emailStatus = 02;
//birthday = 1998-01-01 00:01:00;
//abroadYears = ;
//jobBeginYear = 2013-04-11 00:11:00;
//blackListCount = 0;
//email = 15537109518@qq.com;
//countyName = ;
//invitePersonName = ;
//fileOldName = ;
//inviterUserId = ;
//inviteLinkResumeId = ;
//personTel = 15537109518;
//personTelStatus = 01;
//resumeOpen = 0;
//updatePerson = Android;
//showSystemPaper = ;
//systemPaperScore = ;
//fileFileName = (
//);
//nationality = 中国;
//password = ;
//buyMeCount = 1;
//linkResumeId = ;
//provinceCode = ;
//image = http://192.168.100.2/person/images/21B1EA5006A411E6AA50E17C081BBBE2/2016/04/8102E25006A111E6A2509717ECDD403B.png;
//filePath = ;
//fileNewName = ;
//queryDate = ;
//fileSize = ;
//age = 0;
//fileContentType = (
//);
//storeCompanyCount = 0;
//agentArea = ;
//createPerson = 15537109518;
//status = ;
//refreshDate = ;
//systemPaperType = ;
//htmlImg = ;
//isShow = ;
//beginAge = ;
//endAge = ;
//household = 36;
//cityCode = ;
//cityId = ;
//isHavaResume = 01;
//userType = ;
//agentAreaId = ;
//businessType = ;
//file = (
//);
//mouth = ;
//nowAddressCountry = 500;
//personViewedCount = 0;
//zyzpShowResumeDetailsURL = ;
//cityName = ;
//cardType = ;
//}
//  Created by runsheng on 16/3/29.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//   默认简历 （主页面）

#import "resumeViewController.h"
#import "Common.h"
#import "AssessViewController.h"
#import "PreViewController.h"
#import "RefreshViewController.h"
#import "IntentionViewController.h"
#import "WorkExperienceViewController.h"
#import "EducationViewController.h"
#import "ProjectViewController.h"
#import "SkillViewController.h"
#import "TrainViewController.h"
#import "SelfDesViewController.h"
#import "DTKDropdownMenuView.h"
#import "PersonalViewController.h"
#import "NewTableViewCell.h"
#import "ReSetTableViewController.h"
#import "zyzpHttpTool.h"
#import "Account.h"
#import "EmilaTableViewController.h"


@interface resumeViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic, strong)NSArray * datas;     //简历页面数据
@property(nonatomic, strong)UITableView * menuView; //菜单视图
@property(nonatomic, strong)NSMutableArray * menuDatas; //菜单页面数据
@property(nonatomic, strong)UIView * headView; //组头视图
@property(nonatomic, strong)UIView * footView;   //组尾视图
@property(nonatomic, strong)UILabel * frontLabel;  //前标题
@property(nonatomic, strong)UILabel * resumeNameLabel; //简历名称
@property(nonatomic, strong)UIImageView * arrow; //箭头图片
@property(nonatomic, strong)UILabel * integrityLabel;   //完整度

@property(nonatomic, strong)UIView * clearView;//创建一个透明的视图
@property(nonatomic)BOOL isOpened;//判断菜单是否处于打开状态

@end

@implementation resumeViewController


#pragma mark - Table view data source

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [self getSearchResult];
    [self addTableView];
//    [self addMainTitle];
    [self addTitleMenu];

    [self addSetBar];
}


#pragma mark -- 懒加载数据
-(NSArray *)datas
{
    if (_datas == nil)
    {
        _datas = @[@"简历名称：",@"个人信息：",@"求职意向：",@"工作经验：",@"项目经验：",@"教育背景：",@"自我评价：",@"专业技能：",@"培训经历：",@"证书：",@"语言能力：",@"在校学习情况：",@"在校实践经验：",@"其他信息："];
    }
    return _datas;

}

#pragma mark -- 获取后台数据库数据
-(void)getSearchResult{
    
    NSString *URlStr = [baseUrl stringByAppendingString:@"selectPersonForPhone.htm"];
    NSLog(@"%@",URlStr);
    NSMutableDictionary *parameters = [[Account currentAccount] requestParams];

    [zyzpHttpTool GET:URlStr parameters:parameters progress:^{
        
    } success:^(id responseObject) {
        
        MYLog(@">>>>>>>%@",responseObject);
    } failure:^(NSError *error) {
        MYLog(@".......................%@",error);
    }];
}

#pragma mark --添加自定义的tableView

-(void)addTableView
{
    self.tableView = [[UITableView alloc]initWithFrame: [UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;    //不显示右侧滑块
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;    //分割线
}

#pragma mark -- 添加简历标题
//-(void)addMainTitle
//{
//    UIButton *titleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
//    [titleButton setTitle:@"简历" forState:UIControlStateNormal];
//    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [titleButton addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.titleView  = titleButton;
//}

- (void)addTitleMenu
{
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"iOS开发" callBack:^(NSUInteger index, id info) {
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"安卓开发" callBack:^(NSUInteger index, id info) {
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"网站SEO优化" callBack:^(NSUInteger index, id info) {
    }];
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"Web前端" callBack:^(NSUInteger index, id info) {
    }];
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewForNavbarTitleViewWithFrame:CGRectMake(0, 0, 200.f, 44.f) dropdownItems:@[item0,item1,item2,item3]];
    menuView.currentNav = self.navigationController;
    menuView.dropWidth = screenH / 2 + 64;
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor =  ColorWithRGB(102.f, 102.f, 102.f);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    
    menuView.cellSeparatorColor = [UIColor orangeColor];
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    
    menuView.animationDuration = 0.3f;
    menuView.selectedIndex = 0;
    self.navigationItem.titleView = menuView;
    
}


#pragma mark -- 添加设置按钮图片
//添加RightItem 设置
-(void)addSetBar
{
    UIBarButtonItem *set = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_setup"] style:UIBarButtonItemStylePlain target:self action:@selector(clickSetButton)];
    self.navigationItem.rightBarButtonItem = set;
}


#pragma mark -- 点击设置按钮
-(void)clickSetButton
{
     ReSetTableViewController * set = [[ ReSetTableViewController alloc]init];
    [self.navigationController pushViewController:set  animated:YES];
}

#pragma mark -- 添加section头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建一个headView
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 213)];//导航栏高度44. 状态栏高度20
    _headView.backgroundColor = [UIColor whiteColor] ;
    [tableView addSubview: _headView];
    
    //  2.添加icon（头像）
    UIImageView * icon = [[UIImageView alloc]initWithFrame:CGRectMake((screenW-121)/2, 13, 121, 121)];
    icon.image = [UIImage imageNamed:@"details_mr"];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 60.5;    //把图片裁剪成圆形
//    icon.layer.borderWidth = 0.5f;    //给头像加一个圆形边框
//    icon.layer.borderColor = [UIColor blueColor].CGColor;
    icon.userInteractionEnabled = YES;     // 允许用户交互
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickEdit)];
    [icon  addGestureRecognizer:singleTap];    //创建并添加手势：单击
    [_headView addSubview:icon];
    
    //  3.1添加label（显示姓名）
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake((screenW - 119)/2, 147, 50, 16)];
    name.text = @"李美美";
    name.tintColor = [UIColor blackColor];
    [name setFont:[UIFont systemFontOfSize:16.0]];
    [_headView addSubview:name];
    
    // 3.2添加隔断条
    UIView * black = [[UIView alloc]initWithFrame:CGRectMake((screenW - 1)/2, 147, 1, 16)];
    black.backgroundColor = [UIColor blackColor];
    [_headView addSubview:black];
    
    // 3.3添加工作年限
    UILabel * years = [[UILabel alloc]initWithFrame:CGRectMake(screenW/2+10, 147, 70, 16)];
    years.text = @"3年经验";
    years.tintColor = [UIColor blackColor];
    [_headView addSubview:years];
    
//    UIButton *edit = [[UIButton alloc]initWithFrame:CGRectMake(280, 185, 46, 20)];
//    [edit setTitle:@"编辑" forState:UIControlStateNormal];
//    [edit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    edit.backgroundColor = [UIColor purpleColor];
//    edit.titleLabel.font = [UIFont systemFontOfSize:13.0];
//    [edit addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
//    [headView addSubview: edit];
    
    //  4.添加button（查看评价）
    CGFloat ReButtonWidth = 80;
    CGFloat ReButtonHeight = 30;
    CGFloat ReSpace = 24;  //居左
    CGFloat ReBlank  = ([UIScreen mainScreen].bounds.size.width  - 3 *ReButtonWidth - 2* ReSpace)/2;   //间隔
    UIButton * check = [[UIButton alloc]initWithFrame:CGRectMake(ReSpace, 182, ReButtonWidth, ReButtonHeight)];
    check.backgroundColor = zyMainColor;

    [check setTitle:@"查看评价" forState:UIControlStateNormal];
    [check setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    check.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [check addTarget:self action:@selector(clickSeeButton) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:check];
    
    //  5.添加预览、刷新
    UIButton * watch = [[UIButton alloc]initWithFrame:CGRectMake(( ReSpace+ReButtonWidth+ReBlank), 182, ReButtonWidth, ReButtonHeight)];
    watch.backgroundColor = zyMainColor;
    [watch setTitle:@"预览简历" forState:UIControlStateNormal];
    [watch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    watch.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [watch addTarget:self action:@selector(clickPreViewButton) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:watch];
    
    UIButton * refresh = [[UIButton alloc]initWithFrame:CGRectMake((screenW-ReSpace -ReButtonWidth), 182,ReButtonWidth, ReButtonHeight)];
    refresh.backgroundColor = zyMainColor;

    [refresh setTitle:@"刷新简历" forState:UIControlStateNormal];
    [refresh setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    refresh.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [refresh addTarget:self action:@selector(clickRefreshButton) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:refresh];
    

    //  6.1 添加简历完整度
    UILabel * percentage = [[UILabel alloc]initWithFrame:CGRectMake(24, 234, 140, 15)];
    percentage.text = @"简历完整度：90%";
    percentage.tintColor = [UIColor blueColor];
    percentage.font = [UIFont fontWithName:@"MicrosoftYaHei" size:15];
    [_headView addSubview:percentage];
    
    // 6.2添加简历刷新时间
    UILabel * ndate = [[UILabel alloc]initWithFrame:CGRectMake(screenW - 114, 237, 104, 11)];
    ndate.text = @"2016/03/22";
    ndate.textAlignment = NSTextAlignmentRight;
    ndate.tintColor = [UIColor lightGrayColor];
    ndate.font = [UIFont fontWithName:@"MicrosoftYaHei" size:11];
    [_headView addSubview:ndate];
    return _headView;
}

//设置组头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  255;
}

#pragma mark -- 添加Section尾视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 50)];
    UIButton *setUPbutton = [[UIButton alloc]initWithFrame:CGRectMake(30, 10, screenW-60, 30)];
    [setUPbutton setTitle:@"创建微简历" forState:UIControlStateNormal ];
    [setUPbutton.layer setCornerRadius:10];
    setUPbutton.tintColor = [UIColor whiteColor];
    setUPbutton.backgroundColor = zyMainColor;

    [setUPbutton addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:setUPbutton];
    return _footView;
}

//设置组尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

#pragma  mark --点击预览简历
-(void)clickPreViewButton
{
        PreViewController *resume = [[PreViewController alloc]init];
//      [self presentViewController:resume animated:YES completion:nil];
        [self.navigationController pushViewController:resume animated:YES];
}


#pragma mark -- 点击查看评价
-(void)clickSeeButton
{
    AssessViewController * valution = [[AssessViewController alloc]init];
    [self.navigationController pushViewController:valution animated:YES];
}

#pragma mark -- 点击刷新简历按钮
-(void)clickRefreshButton
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"简历刷新完成" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:alert
                                    repeats:YES];
    [alert show];
}

//alert消失的方法
- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *alert = (UIAlertView*)[theTimer userInfo];
    [alert dismissWithClickedButtonIndex:0 animated:NO];
   alert =NULL;
}

#pragma mark --点击编辑
-(void)clickEdit
{
    PersonalViewController * bjVC = [[PersonalViewController alloc ]init];
    [self.navigationController pushViewController:bjVC animated:YES];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.datas.count;
}


#pragma mark -- tableView代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0) {
            static NSString *  identifier = @"cell";
            UITableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
        
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(24, 14, 150, 15)];
                nameLabel.backgroundColor = [UIColor clearColor];
            [nameLabel setTag:100];
            [cell.contentView addSubview:nameLabel];
            
            UILabel *secLabel = [[UILabel alloc]initWithFrame:CGRectMake(175,14,150,15)];
            [secLabel setTag: 102];
            [cell.contentView addSubview: secLabel];
            
            UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(screenW-30, 14, 9, 15)];
            [icon setTag:101];
            [cell.contentView addSubview:icon];
        }
        _frontLabel = (UILabel *)[cell viewWithTag:100];
        _frontLabel.text = [self.datas objectAtIndex: indexPath.row ];
        _arrow = (UIImageView *)[cell viewWithTag:101];
        _arrow.image =  [UIImage imageNamed:@"login_to"];
        _resumeNameLabel = (UILabel *)[cell viewWithTag:102];
        _resumeNameLabel.text = @"iOS开发工程师";

        return cell;
        }else{
            static NSString * cellIdentifier  = @"ResuCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(24, 14, 150, 15)];
                nameLabel.backgroundColor = [UIColor clearColor];
                [nameLabel setTag:100];
                [cell.contentView addSubview:nameLabel];
                
                UILabel *fullLabel  = [[UILabel alloc]initWithFrame:CGRectMake(screenW - 70, 14, 40, 15)];
                fullLabel.backgroundColor = [UIColor clearColor];
                [fullLabel setTag:103];
                [cell.contentView addSubview:fullLabel];
                
                UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(screenW-30, 14, 9, 15)];
                [icon setTag:101];
                [cell.contentView addSubview:icon];
                
            }
            _frontLabel = (UILabel *)[cell viewWithTag:100];
            _frontLabel.text = [self.datas objectAtIndex: indexPath.row ];
            _integrityLabel = (UILabel *)[cell viewWithTag:103];
            _integrityLabel.text = @"完整";
            _arrow = (UIImageView *)[cell viewWithTag:101];
            _arrow.image =  [UIImage imageNamed:@"find_go"];

            return cell;
        }
}

#pragma mark -- 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated:YES];   //点击效果动画消失

        switch (indexPath.row) {
            case 0:{
                //0.简历名称
//                [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
                
                break;
            } case 1:{
                  //1.个人信息
                [self.navigationController pushViewController:[[PersonalViewController alloc]init] animated:YES];
        
                break;
            } case 2:{
                //2.求职意向
                [self.navigationController pushViewController:[[IntentionViewController alloc]init] animated:YES];
                
                break;
            } case 3:{
                 //3.工作经验
                [self.navigationController pushViewController:[[WorkExperienceViewController alloc]init] animated:YES];
                
                break;
            }case 4:{
                 //4.项目经验
                [self.navigationController pushViewController:[[ProjectViewController alloc]init] animated:YES];
                
                break;
            }case 5:{
                 //5.教育背景
                [self.navigationController pushViewController:[[EducationViewController alloc]init] animated:YES];
                
                break;
            }case 6:{
                 //6.自我评价
                [self.navigationController pushViewController:[[SelfDesViewController alloc]init] animated:YES];

                break;
            }case 7:{
                 //7.专业技能
                    [self.navigationController pushViewController:[[SkillViewController alloc]init] animated:YES];
                
                break;
            }case 8:{
                //8.培训经历
                 [self.navigationController pushViewController:[[TrainViewController alloc]init] animated:YES];
                
                break;
            }case 9:{
                //9.证书
                [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
                
                break;
            }case 10:{
                //10.语言能力
                [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
                
                break;
            }//case 11:{
                //11.招聘附件
//                [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
//                EmilaTableViewController *emila = [[EmilaTableViewController alloc]init];
//                [self.navigationController pushViewController:emila animated:YES];
                
//                break;
            //}
            case 11:{
                //12.在校学习情况
                    [self.navigationController pushViewController:[[EducationViewController alloc]init] animated:YES];
                
                break;
            }case 12:{
                //13.在校实践经验
                [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
                
                break;
            }case 13:{
                //14.求职信
//                [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
                
                break;
            }case 14:{
                //15.其他信息
              [self.navigationController pushViewController:[[UIViewController alloc]init] animated:YES];
                
                break;
            }
                
        }
    }


#pragma mark -- 定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43; //系统默认高度为44
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
