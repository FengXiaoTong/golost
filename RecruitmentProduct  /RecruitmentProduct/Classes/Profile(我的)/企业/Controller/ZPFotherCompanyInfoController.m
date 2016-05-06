//
//  ZPFotherCompanyInfoController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/28.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "ZPFotherCompanyInfoController.h"
#import <MJRefresh/MJRefresh.h>
#import "LCMcompayModel.h"
#import "Common.h"
#import "zyzpHttpTool.h"
#import "Account.h"
#import "LCMcompanyTableViewCell.h"
#import "ZPFcompanyAuditController.h"
#import "UIView+ZYFrame.h"
#import "ZPFfillInformationController.h"
//#import "ZPFpickerView.h"

#define URLSTRING @"updateCompanyInfo.htm"
#define SELECTINFO @"selectCompanyInfo.htm"

@interface ZPFotherCompanyInfoController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UITableView *otherTableView;

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *promptArr;
@property (nonatomic, strong) NSMutableArray *textArr;
@property (nonatomic, strong) LCMcompayModel *model;
//pickerView
@property (nonatomic, strong) NSMutableArray *pickerArray;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, copy) NSString *upDataStr;
@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation ZPFotherCompanyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"其他企业信息";
    [self createDataSource];
    [self createTableView];
    _otherTableView.tableFooterView = [self tableViewFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    MYLog(@"哥哥，内存泄漏了%s",__func__);
    // Dispose of any resources that can be recreated.
}

- (void)createTableView {
    
    _otherTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenH - 44)];
    _otherTableView.delegate =self;
    _otherTableView.dataSource = self;
    [self.view addSubview: _otherTableView];
    [self refreshData];
}

- (void)refreshData {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
    }];
    _otherTableView.mj_header = header;
    
    [_otherTableView.mj_header beginRefreshing];
    
    
    
}

- (void)loadDataFromNet:(BOOL)isMore {
    
    
    NSString *URLString = [baseUrl stringByAppendingString:SELECTINFO];
    NSMutableDictionary *requestParams = [[Account currentAccount] requestParams];
    
    
    [zyzpHttpTool GET:URLString parameters:requestParams progress:^{
        
    } success:^(id responseObject) {
        
        NSDictionary *dict = responseObject[@"data"];
        _model = [[LCMcompayModel alloc] init];
        [_model setValuesForKeysWithDictionary:dict];
        
        [_otherTableView reloadData];
        
        isMore?[_otherTableView.mj_footer endRefreshing]:[_otherTableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",[error description]);
        isMore?[_otherTableView.mj_footer endRefreshing]:[_otherTableView.mj_header endRefreshing];
    }];
    
    
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
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(footerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(left, top, width, height);
    [footerView addSubview:button];
    
    return footerView;
}

- (void)footerButtonAction {
    ZPFcompanyAuditController *audit = [[ZPFcompanyAuditController alloc] init];
    [self.navigationController pushViewController:audit animated:YES];
}

- (void)createDataSource {
    _textArr = [NSMutableArray array];
    _titleArr = @[@"公司行业",@"公司性质",@"公司规模",@"公司地址",@"公司介绍",@"",@"参考一下",@"招聘联系人",@"联系方式"];
    _promptArr = @[@"请选择公司行业类别",@"请选择公司性质",@"请选择公司规模",@"请输入公司地址",@"",@"请输入公司介绍",@"0/2000",@"请输入联系人姓名",@"请输入联系方式"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 5) {
        return 100;
    }
    
    return 43;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifier";
    LCMcompanyTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[LCMcompanyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    
    NSString *modelString;
    if (indexPath.row == 0) {
        modelString = [[self argumentParsing:_model.mainIndustry positive:YES type:@"行业"] componentsJoinedByString:@"/"];
    } else if (indexPath.row == 1) {
        modelString = [[self argumentParsing:_model.companyType positive:YES type:@"性质"] componentsJoinedByString:@"/"];
    } if (indexPath.row == 2) {
        modelString = [[self argumentParsing:_model.compnayPersons positive:YES type:@"规模"] componentsJoinedByString:@"/"];
    } else if (indexPath.row == 3) {
        modelString = _model.companyAddress;
    } if (indexPath.row == 5) {
        modelString = _model.companyDesc;
    } else if (indexPath.row == 6) {
        
    }else if (indexPath.row == 7) {
        modelString = _model.jobLinkman;
    }else if (indexPath.row == 8) {
        modelString = _model.jobTelephone;
    }
    
    if (modelString == nil) {
        [_textArr addObject:@""];
        
    }else {
        _textArr[indexPath.row] = modelString;
    }

    [cell setModel:modelString withStandbyString:_promptArr[indexPath.row] withTitleString:_titleArr[indexPath.row]];
    
    return cell;
}

//key 要解析的数据
//isPositive 请求下来的数据显示传入YES 上传数据传入NO
//typeStr 行业类型传入@“行业”  规模传入@“规模”  性质传入@“性质”
- (NSArray *)argumentParsing:(NSString *)key positive:(BOOL)isPositive type:(NSString *)typeStr{
    
    NSString *dicKey;
    NSString *dicValue;
    if (isPositive) {
        dicKey = @"dicKey";
        dicValue = @"dicValue";
    }else {
        dicKey = @"dicValue";
        dicValue = @"dicKey";
    }
    
    NSMutableArray *parsingArr = [NSMutableArray array];
    NSArray *arr = [key componentsSeparatedByString:@","];
    if ([typeStr isEqualToString:@"行业"]) {
        NSDictionary *dict = (NSDictionary *)[self getJsonData:@"行业"];
        NSArray *pIndustry;
        NSArray *cIndustry;
        for (int i = 0; i < arr.count; i++) {
            if ([arr[i] length] == 6) {
                if (!pIndustry) {
                    pIndustry = dict[@"pIndustry"];
                }
                for (NSDictionary *dic in pIndustry) {
                    if ([arr[i] isEqualToString:dic[dicKey]]) {
                        [parsingArr addObject:dic[dicValue]];
                    }
                }
            }else {
                if (!cIndustry) {
                    cIndustry = dict[@"cIndustry"];
                }
                for (NSDictionary *dic in cIndustry) {
                    if ([arr[i] isEqualToString:dic[dicKey]]) {
                        [parsingArr addObject:dic[dicValue]];
                    }
                }
            }
        }
    }else if ([typeStr isEqualToString:@"性质"]) {
        
        NSArray *array = (NSArray *)[self getJsonData:@"性质"];
        for (int i = 0; i < arr.count; i++) {
            for (NSDictionary *dict in array) {
                if ([arr[i] isEqualToString:dict[dicKey]]) {
                    [parsingArr addObject:dict[dicValue]];
                }
            }
        }
    }else if ([typeStr isEqualToString:@"规模"]) {
        NSArray *array = (NSArray *)[self getJsonData:@"规模"];
        for (int i = 0; i < arr.count; i++) {
            for (NSDictionary *dict in array) {
                if ([arr[i] isEqualToString:dict[dicKey]]) {
                    [parsingArr addObject:dict[dicValue]];
                }
            }
        }
    }
    
    if (parsingArr.count == 0) {
        return nil;
    }
    return parsingArr;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 3 || indexPath.row == 7 || indexPath.row == 8) {
        ZPFfillInformationController *fillInfo = [[ZPFfillInformationController alloc] init];
        fillInfo.text = _textArr[indexPath.row];
        fillInfo.placeholder = _promptArr[indexPath.row];
        [self.navigationController pushViewController:fillInfo animated:YES];
    }else if(!_pickerView){
        if (indexPath.row == 0) {
            [self createPickerViewIndustryData];

        }else if (indexPath.row == 1) {
            [self createPickerViewNatureData];

        
        }else if (indexPath.row == 2) {
            [self createPickerViewScaleData];

        }
        [self addPickerView];
        
        
        _upDataStr = _pickerArray[0];
        [_pickerView selectRow:2 inComponent:0 animated:YES];

    }
    
   
}


-(void)createPickerViewIndustryData {
    _pickerArray = [NSMutableArray array];
    NSDictionary *dict = (NSDictionary *)[self getJsonData:@"行业"];
    
    NSArray *pIndustry = dict[@"pIndustry"];
    for (NSDictionary *dic in pIndustry) {
        [_pickerArray addObject:dic[@"dicValue"]];
    }
    NSArray *cIndustry = dict[@"cIndustry"];
    for (NSDictionary *dic in cIndustry) {
        [_pickerArray addObject:dic[@"dicValue"]];
    }
}
- (void)createPickerViewNatureData {
    _pickerArray = [NSMutableArray array];
    NSArray *array = (NSArray *)[self getJsonData:@"性质"];
    for (NSDictionary *dict in array) {
        [_pickerArray addObject:dict[@"dicValue"]];
    }
}
- (void)createPickerViewScaleData {
    _pickerArray = [NSMutableArray array];

    NSArray *array = (NSArray *)[self getJsonData:@"规模"];
    for (NSDictionary *dict in array) {
        [_pickerArray addObject:dict[@"dicValue"]];
    }

}

-(NSJSONSerialization *)getJsonData:(NSString *)string {
    NSString *str = [[NSBundle mainBundle] pathForResource:string ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:str];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

-(void)addPickerView{
    _pickerView = [[UIPickerView alloc]init];
    _pickerView.frame = CGRectMake(0, screenH - 264, screenW, 200);
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *trueBt = [[UIBarButtonItem alloc]
                                   initWithTitle:@"确定" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(trueBtAction)];
    UIBarButtonItem *cancelBt = [[UIBarButtonItem alloc]
                               initWithTitle:@"取消" style:UIBarButtonItemStyleDone
                               target:self action:@selector(cancelBtAction)];
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    _toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     _pickerView.frame.size.height-50, screenW, 50)];
    [_toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             cancelBt,spaceButtonItem,trueBt, nil];
    [_toolBar setItems:toolbarItems];
    
    [self.view addSubview:_toolBar];
    [self.view addSubview:_pickerView];

}

- (void)trueBtAction {
    MYLog(@"确定----%@",_upDataStr);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _pickerView.y = screenH + 50;
        _toolBar.y = screenH;
        
    }completion:^(BOOL finished) {
        [_pickerView removeFromSuperview];
        [_toolBar removeFromSuperview];
        _pickerView = nil;
        _toolBar = nil;
        _pickerArray = nil;
        
    }];
  
    
    
    
}

- (void)cancelBtAction {
    MYLog(@"取消----%@",_upDataStr);
    [UIView animateWithDuration:0.5 animations:^{
        
        _pickerView.y = screenH + 50;
        _toolBar.y = screenH;
        
    }completion:^(BOOL finished) {
        [_pickerView removeFromSuperview];
        [_toolBar removeFromSuperview];
        _pickerView = nil;
        _toolBar = nil;
        _pickerArray = nil;
        
    }];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (_pickerView) {
        [_pickerView removeFromSuperview];
        [_toolBar removeFromSuperview];
        _pickerArray = nil;
    }

}


#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return _pickerArray.count;
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    
    _upDataStr = _pickerArray[row];
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return _pickerArray[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumFontSize = 8;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}



@end
