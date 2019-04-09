//
//  SecondViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/3.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "SecondViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

@interface SecondViewController ()<CLLocationManagerDelegate>
{
    NSMutableArray *_angleArray;
}
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIProgressView *progress;

@property (nonatomic, assign) float horizontalAngle;    //水平角度（0~360）
@property (nonatomic, assign) float verticalAngle;      //垂直角度（-1~1）

@end

@implementation SecondViewController

- (void)viewWillDisappear:(BOOL)animated {
    [self.locationManager stopUpdatingHeading];
    [self.motionManager stopDeviceMotionUpdates];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Iron Man";
    _angleArray = [[NSMutableArray alloc] init];
    
    _button = [Tools createButtonWithFrame:CGRectMake(100, 100, 100, 50) backgroundColor:[UIColor redColor] title:@"开始" addTarget:self action:@selector(begin)];
    [self.view addSubview:_button];
    
    _label = [Tools createLabelWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 50) text:nil textColor:[UIColor magentaColor] textAlignment:1];
    _label.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:_label];
    
    _progress = [[UIProgressView alloc] initWithFrame:CGRectMake(20, NAVBAR_HEIGHT+10, SCREEN_WIDTH-40, 10)];
    [self.view addSubview:_progress];
}


- (void)begin
{
    [_angleArray addObjectsFromArray:@[@210, @0.5, @220, @-0.9, @230]];
    _progress.progress = 0.0;
    _button.enabled = NO;
    [self startHeading];
    [self startMotion];
}


- (void)startHeading
{
    if ([CLLocationManager headingAvailable]) {
        [self.locationManager startUpdatingHeading];
    } else {
        [Tools showAlertViewOfSystemWithTitle:@"提示" andMessage:@"您的设备不支持磁力计"];
    }
}


- (void)startMotion
{
    if (![self.motionManager isDeviceMotionActive] && [self.motionManager isDeviceMotionAvailable]) {
        
        [self.motionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            
            //该属性返回只是地球重力对该设备施加的重力加速度
            CMAcceleration gravity = motion.gravity;
            _verticalAngle = gravity.z;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updatePoint];
            });
        }];
    }
}

- (void)updatePoint
{
    NSLog(@"水平方向 = %.0f, 垂直方向 = %f", _horizontalAngle, _verticalAngle);
    
    if (_angleArray.count == 0) {
        _button.enabled = YES;
        [_button setTitle:@"开始" forState:UIControlStateNormal];
        _label.text = @"恭喜你！找到啦";
        [self.locationManager stopUpdatingHeading];
        [self.motionManager stopDeviceMotionUpdates];
        return;
    }
    
    float targetAngle = [[_angleArray firstObject] floatValue];
    if (targetAngle > -1.0 && targetAngle < 1.0) {
        //上下移动
        if (_verticalAngle < targetAngle) {
            _label.text = @"↑";
        } else {
            _label.text = @"↓";
        }
        
        if (fabs(targetAngle - _verticalAngle) < 0.01) {
            [_angleArray removeObjectAtIndex:0];
            [_progress setProgress:(5-_angleArray.count)/5.0 animated:YES];
        }
        
    } else {
        //左右移动
        if (targetAngle < 180.0) {
            if (_horizontalAngle > targetAngle && _horizontalAngle < targetAngle + 180.0) {
                _label.text = @"←";
            } else {
                _label.text = @"→";
            }
            
        } else {
            if (_horizontalAngle < targetAngle && _horizontalAngle > targetAngle - 180.0) {
                _label.text = @"→";
            } else {
                _label.text = @"←";
            }
        }
        
        if (fabs(targetAngle - _horizontalAngle) < 1.0) {
            [_angleArray removeObjectAtIndex:0];
            [_progress setProgress:(5-_angleArray.count)/5.0 animated:YES];
        }
    }
    
}




#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    //水平角度
    _horizontalAngle = newHeading.magneticHeading;
    [_button setTitle:[NSString stringWithFormat:@"%.0f", _horizontalAngle] forState:UIControlStateNormal];
}




#pragma mark - 懒加载

- (CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (CMMotionManager *)motionManager
{
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 0.1;   //更新频率，以秒为单位
    }
    return _motionManager;
}

@end
