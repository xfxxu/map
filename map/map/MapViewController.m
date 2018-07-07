//
//  MapViewController.m
//  map
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MapViewController.h"

//引入高德地图头文件
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface MapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotation;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    

}

- (void)viewWillDisappear:(BOOL)animated
{

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
