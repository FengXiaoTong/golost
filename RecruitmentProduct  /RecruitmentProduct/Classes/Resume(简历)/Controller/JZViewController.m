//
//  JZViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/12.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "JZViewController.h"
#import "CZcity.h"
#import "Common.h"

@interface JZViewController()<UIPickerViewDelegate, UIPickerViewDataSource>

/**
 *  存放数据的数组
 */
@property (nonatomic,strong)NSArray *citiesArray;
/**
 *  pickerview
 */
@property (strong, nonatomic)  UIPickerView *pickerView;
/**
 *  省文本
 */
@property (strong, nonatomic) UILabel *proLabel;
/**
 *  城市文本
 */
@property (strong, nonatomic)  UILabel *cityLabel;
/**
 *  省模型
 */
@property (nonatomic,strong)CZcity * selecletPro;


@end

@implementation JZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRightItem];
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, screenW, screenH-364)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
    [self pickerView: _pickerView didSelectRow:0 inComponent:0 ];
}

#pragma mark -- 添加导航栏rightItem
-(void)addRightItem
{
    self.navigationItem.title = @"当前居住地";
    UIBarButtonItem * next = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickKeep)];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName]= [UIColor blackColor];
    [next setTitleTextAttributes:att forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = next;
}

#pragma mark -- 点击保存/完成
-(void)clickKeep
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 懒加载数据
-(NSArray *)citiesArray
{
    if (_citiesArray == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"02cities" ofType:@"plist"]];
        NSMutableArray *nmArray = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            [nmArray addObject:[CZcity citiesWithDic:dic]];
        }
        _citiesArray = nmArray;
    }
    return _citiesArray;
    
}

#pragma mark --uipickerviewdatasource中的方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return _citiesArray.count;
    }else{
        
        // 2.如果是第1组，城市 城市的行数就要看当前正在显示的是哪个省
        //获取省的索引
        NSInteger seleProIndx = [pickerView selectedRowInComponent:0];
        //获取当前省的数据
        CZcity * selePro = self.citiesArray[seleProIndx];
        //保存当前省的数据
        _selecletPro = selePro;
        //返回省的城市的个数
        return selePro.cities.count;
        
    }
}

#pragma mark -- UIPickerViewDelegate方法
//返回每一行
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        
        //返回省的名字
        CZcity * city = _citiesArray[row];
        return city.name;
    }else{
        //        //返回城市的名字
        //        //获取省的索引
        //        NSInteger seleProIndx = [pickerView selectedRowInComponent:0];
        //        //获取当前省的数据
        //        CZcity * selePro = self.citiesArray[seleProIndx];
        //        //返回省的城市的名字
        //        return selePro.cities[row];
        //返回保存的省里面的内容
        return _selecletPro.cities[row];
    }
    
}
//当用户选中某一行是刷新
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        [pickerView reloadComponent:1];
    }
    
    //设置label的内容
    //选择了第几组的行
    NSInteger selePro = [pickerView selectedRowInComponent:0];
    NSInteger seleCity = [pickerView selectedRowInComponent:1];
    
    //获取内容
    CZcity * pro = self.citiesArray[selePro];
    //    NSString * city = pro.cities[seleCity];
    //获取保存的省里面的城市
    NSString * city = self.selecletPro.cities[seleCity];
    //赋值
    _proLabel.text = pro.name;
    _cityLabel.text = city;
}


#pragma mark -- 隐藏状态栏
//隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
