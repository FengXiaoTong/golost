//
//  guideWorkViewController.m
//  RecruitmentProduct
//
//  Created by zy on 16/4/6.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import "guideWorkViewController.h"
#import "Common.h"
#import "AppDelegate.h"
#import "zyzpTabBarController.h"
#import <CoreLocation/CoreLocation.h>
#import "CityViewController.h"

@interface guideWorkViewController ()<CLLocationManagerDelegate>
@property (nonatomic, strong) NSArray *info;
@property (weak, nonatomic) IBOutlet UITextField *searchView;
@property (nonatomic)CGFloat tg;

@property (weak, nonatomic) IBOutlet UIButton *locateBtnT;
@property (nonatomic, strong) NSString *cityString;
@property(strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation guideWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _cityString = @"dfghj";
    _locateBtnT.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;  //结尾部分的内容以……方式省略，显示头的文字内容。
    
    _info = @[@"会尽快片放到是大法官",@"dvddgvkasv",@"vevrvv",@"无知",@"风云变幻",@"施耐庵",@"西门吹雪",@"呵呵哒",@"快看看",@"窿窿急急急啦啦",@"一杆禽兽狙",@"合欢花",@"暴走大事件",@"非诚勿扰",@"呵呵呵"];

    [self text];
    [self clickTableViewHideKyeboard];
    [self locate];
    // Do any additional setup after loading the view from its nib.
}


//选择职业
- (void)handleClick:(UIButton *)btn{
    NSLog(@"%ld",(long)btn.tag);
    
    if (btn.tag == _tg) {
        _searchView.text = @"";
        _searchView.placeholder = @"请输入你想要的吧...如:销售经理";
        _tg = 0;
    }else{
        _searchView.text = btn.titleLabel.text;
        _tg = btn.tag;
    }
    
}
//点击自选位置
- (IBAction)locateClick:(UIButton *)sender {
    CityViewController *controller = [[CityViewController alloc] init];
    controller.currentCityString = _cityString;
    controller.selectString = ^(NSString *string){
//        self.cityLabel.text = string;
        [_locateBtnT setTitle:string forState:UIControlStateNormal];
    };
    [self presentViewController:controller animated:YES completion:nil];
}


//快去看看
- (IBAction)searchClick:(UIButton *)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    window.rootViewController = [[zyzpTabBarController alloc] init];
    
    
}
//随便逛逛
- (IBAction)withoutClick:(UIButton *)sender {
    
}


//排布职业
- (void)text{
    
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 150;//用来控制button距离父视图的高
    for (int i = 0; i < _info.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.layer.cornerRadius = 10.0;
        button.backgroundColor = nil;
        //设置边框宽度
        [button.layer setBorderWidth:1.0];
        //设置边框颜色
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.5 });
        [button.layer setBorderColor:colorref];
        
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGFloat length = [_info[i] boundingRectWithSize:CGSizeMake(screenW, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width + 35;
        //为button赋值
        [button setTitle:_info[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 20 , 30);
        //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
        if(10 + w + length + 20 > screenW){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 20, 30);//重设button的frame
        }
        w = button.frame.size.width + button.frame.origin.x;
        [self.view addSubview:button];
    }
}
//定位
- (void)locate{
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        //定位初始化
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=10;
        if ((NSInteger)[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] >= 8) {
            [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
        //        [_locationManager startUpdatingLocation];//开启定位
    }else {
        //提示用户无法进行定位操作
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    // 开始定位
    [_locationManager startUpdatingLocation];
}

#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //NSLog(@%@,placemark.name);//具体位置
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             [_locateBtnT setTitle:city forState:UIControlStateNormal];

             _cityString = city;

//             NSLog(@"定位完成:%@",_cityName);
             //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
             [manager stopUpdatingLocation];
         }else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
}



// 收searchBar键盘
-(void)clickTableViewHideKyeboard{
    
    UITapGestureRecognizer *gestureR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeboard)];
    
    [self.view addGestureRecognizer:gestureR];
    
    gestureR.cancelsTouchesInView = NO;
}

-(void)hideKeboard{
    [_searchView resignFirstResponder];
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
