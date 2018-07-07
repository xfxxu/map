//
//  ViewController.m
//  map
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "MainViewController.h"
@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;//定位服务
@property (nonatomic, strong) NSString *province;    //省份
@property (nonatomic, strong) NSString *currentcity; //当前城市
@property (nonatomic, strong) NSString *strlatitude; //经度
@property (nonatomic, strong) NSString *strlongitude;//纬度

@property (nonatomic, strong) UITextField *strlatitudeTextField;
@property (nonatomic, strong) UITextField *strlongitudeTextField;
@property (nonatomic, strong) UITextField *locationTextField;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"定位";
    [self initView];
}

//懒加载
- (CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        //实例化位置管理者
        _locationManager = [[CLLocationManager alloc] init];
        //指定代理，代理中获取位置数据
        _locationManager.delegate = self;
        _currentcity = [[NSString alloc] init];
        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100;
    }
    return _locationManager;
}

- (void)viewWillAppear:(BOOL)animated{
    if([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [_locationManager requestAlwaysAuthorization]; // 永久授权
        [_locationManager requestWhenInUseAuthorization]; //使用中授权
    }
//    _locationTextField.text = @"";
    _locationTextField.text = _strName;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //停止定位
    [_locationManager stopUpdatingLocation];
}

- (void)initView{
    
    UITextField *textfield1 = [[UITextField alloc] init];
    UITextField *textfield2 = [[UITextField alloc] init];
    UITextField *textfield3 = [[UITextField alloc] init];
    textfield1.frame = CGRectMake(10, 100, self.view.frame.size.width-20, 40);
    textfield2.frame = CGRectMake(10, 160, self.view.frame.size.width-20, 40);
    textfield3.frame = CGRectMake(10, 220, self.view.frame.size.width-20, 40);

    textfield1.layer.borderWidth = 0.5;
    textfield2.layer.borderWidth = 0.5;
    textfield3.layer.borderWidth = 0.5;

    textfield1.layer.borderColor = [UIColor grayColor].CGColor;
    textfield2.layer.borderColor = [UIColor grayColor].CGColor;
    textfield3.layer.borderColor = [UIColor grayColor].CGColor;

    textfield1.placeholder = @"经度";
    textfield2.placeholder = @"纬度";
    textfield3.placeholder = @"具体位置";

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 300, self.view.frame.size.width-20, 40);
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 4;
    [button setTitle:@"开始定位" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickToLocate) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(10, 360, self.view.frame.size.width-20, 40);
    button1.backgroundColor = [UIColor redColor];
    button1.layer.cornerRadius = 4;
    [button1 setTitle:@"停止定位" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clickToStop) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(10, 420, self.view.frame.size.width-20, 40);
    button2.backgroundColor = [UIColor redColor];
    button2.layer.cornerRadius = 4;
    [button2 setTitle:@"下一页" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(clickToNextPage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:textfield1];
    [self.view addSubview:textfield2];
    [self.view addSubview:textfield3];
    [self.view addSubview:button];
    [self.view addSubview:button1];
    [self.view addSubview:button2];

    _strlatitudeTextField = textfield1;
    _strlongitudeTextField = textfield2;
    _locationTextField = textfield3;

}
- (void)clickToLocate{
    //开启位置更新
    [self.locationManager startUpdatingLocation];

}
- (void)clickToStop{
    //停止位置更新
    [self.locationManager stopUpdatingLocation];
    _strlatitudeTextField.text = @"";
    _strlongitudeTextField.text = @"";
    _locationTextField.text = @"";
}

//跳转下一页
- (void)clickToNextPage{
//    LocationViewController *lvc = [[LocationViewController alloc] init];
//    [self.navigationController pushViewController:lvc animated:YES];
    MainViewController *mvc = [[MainViewController alloc] init];
    [self.navigationController pushViewController:mvc animated:YES];
}

//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(CLLocation *)newLocation
//           fromLocation:(CLLocation *)oldLocation
//{
//
//    //将经度显示到label上
//    _strlatitudeTextField.text = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
//    //将纬度现实到label上
//    _strlongitudeTextField.text = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
//
//    // 获取当前所在的城市名
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    //根据经纬度反向地理编译出地址信息
//    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error)
//     {
//         if (array.count > 0)
//         {
//             CLPlacemark *placemark = [array objectAtIndex:0];
//
//             //将获得的所有信息显示到label上
//             self.locationTextField.text = placemark.name;
//             //获取城市
//             NSString *city = placemark.locality;
//             if (!city) {
//                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
//                 city = placemark.administrativeArea;
//             }
//             NSLog(@"%@", city);
//             NSLog(@"%@",placemark.administrativeArea);
//         }
//         else if (error == nil && [array count] == 0)
//         {
//             NSLog(@"No results were returned.");
//         }
//         else if (error != nil)
//         {
//             NSLog(@"An error occurred = %@", error);
//         }
//     }];
//
//    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
//    [manager stopUpdatingLocation];
//}

//#pragma mark --------CoreLocation delegate(定位服务，定位成功后执行此代理)--------------
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //旧值
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];

    //当前经纬度
    NSLog(@"经度为：%f,纬度为：%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);

    _strlatitudeTextField.text = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    _strlongitudeTextField.text = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    //地理反编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSLog(@"%lu",placemarks.count);

//        for (CLPlacemark *placeMark in placemarks)
//        {
//
//
//            NSDictionary *addressDic=placeMark.addressDictionary;//地址的所有信息
//
//            NSString *state=[addressDic objectForKey:@"State"];//省。直辖市  江西省
//            NSString *city=[addressDic objectForKey:@"City"];//市  丰城市
//            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];//区
////            NSString *street=[addressDic objectForKey:@"Street"];//街道
//            NSLog(@"%@%@%@",state,city,subLocality);
////            self.locationTextField.text =[NSString stringWithFormat:@"%@%@%@",state,city,subLocality];
//            self.locationTextField.text = placeMark.name;
//        }

        if (placemarks.count>0) {
            CLPlacemark *placeMark = placemarks[0];
            self.currentcity = placeMark.locality;
            if (!self.currentcity) {
                self.currentcity = @"无法定位当前城市";
            }
            NSLog(@"%@",placeMark.country);//
            NSLog(@"%@",placeMark.administrativeArea);//省份
            NSLog(@"%@",self.currentcity); //当前城市
            NSLog(@"%@",placeMark.subLocality);//区
            NSLog(@"%@",placeMark.thoroughfare);//街道
            NSLog(@"%@",placeMark.name);
            ;
            self.locationTextField.text = [NSString stringWithFormat:@"%@%@%@%@%@", placeMark.administrativeArea, self.currentcity ,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
        }
        else if (error == nil && placemarks.count == 0){
            NSLog(@"no location");
        }
        else if (error){
            NSLog(@"%@",error);
        }
    }];

}

// 代理方法中监听授权的改变,被拒绝有两种情况,一是真正被拒绝,二是服务关闭了
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户未决定");
            break;
        }
            // 系统预留字段,暂时还没用到
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"受限制");
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 被拒绝有两种情况 1.设备不支持定位服务 2.定位服务被关闭
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"真正被拒绝");
                // 跳转到设置界面
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
            else {
                NSLog(@"没有开启此功能");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"前后台定位授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"前台定位授权");
            break;
        }
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
