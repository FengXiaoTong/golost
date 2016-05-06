//
//  BaiDuMapViewController.m
//  RecruitmentProduct
//
//  Created by runsheng on 16/4/25.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "BaiDuMapViewController.h"
#import "Common.h"
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKGeocodeSearchOption.h>
#import <BaiduMapKit/BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapKit/BaiduMapAPI_Map/BMKPinAnnotationView.h>
@interface BaiDuMapViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate>{

    BMKMapView *_mapView;
    BMKGeoCodeSearch *_geoCode;       // 地理编码
    BMKPointAnnotation *_annotation;
}

@end

@implementation BaiDuMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.mapType = BMKMapTypeStandard;
    self.view = _mapView;
   
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 0, 50, 50);
//    button.backgroundColor = [UIColor redColor];
//    [button addTarget:self action:@selector(outputLocation) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _mapView.delegate = self;
    [_mapView setShowsUserLocation:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    _address = @"郑州市高新区长春路与梧桐路交叉口国家大学科技园F1D3楼1004/1005";

    [self outputLocation];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _mapView.delegate = nil;
    if (_annotation != nil) {
        [_mapView removeAnnotation:_annotation];
    }
}

#pragma mark geoCode的Get方法，实现延时加载
- (BMKGeoCodeSearch *)geoCode {
    if (!_geoCode) {
        _geoCode = [[BMKGeoCodeSearch alloc] init];
        _geoCode.delegate = self;
    }
    return _geoCode;
}

#pragma mark 获取经纬度按钮事件
- (void)outputLocation {
    // 初始化地址编码选项（数据模型）
    BMKGeoCodeSearchOption *option = [[BMKGeoCodeSearchOption alloc] init];
    // 将TextField中的数据传到地址编码模型
    option.address = _address;
    NSLog(@"%@", option.address);
    // 调用地址编码方法，让其在代理方法中输出
    [self.geoCode geoCode:option];
}
#pragma mark 代理方法返回地理编码结果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (result) {
        NSLog(@"%@",[NSString stringWithFormat:@"经度为：%.6f   纬度为：%.6f", result.location.longitude, result.location.latitude]);

        
        _annotation = [[BMKPointAnnotation alloc] init];
        CLLocationCoordinate2D coor;
        coor.latitude = result.location.latitude;
        coor.longitude = result.location.longitude;
        _annotation.coordinate = coor;
//        _annotation.title = @"这里是北京";
        [_mapView addAnnotation:_annotation];
        BMKCoordinateRegion region ;//表示范围的结构体
        region.center = CLLocationCoordinate2DMake(result.location.latitude, result.location.longitude);//中心点
        region.span.latitudeDelta = 0.1;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
        region.span.longitudeDelta = 0.1;//纬度范围
        [_mapView setRegion:region animated:YES];
        
    }else{
        MYLog(@"找不到相对应的位置");
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
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
