//
//  SecondViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/3.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<CLLocationManagerDelegate>
{
    NSMutableArray *_angleArray;
}
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIProgressView *progress;

@end

@implementation SecondViewController

- (void)viewWillDisappear:(BOOL)animated {
    [self.locationManager stopUpdatingHeading];
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

- (CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (void)begin
{
    if (![CLLocationManager headingAvailable]) {
        [Tools showAlertViewOfSystemWithTitle:@"提示" andMessage:@"您的设备不支持磁力计"];
        return;
    }
    
    [_angleArray addObjectsFromArray:@[@210, @180, @220, @200, @230]];
    _progress.progress = 0.0;
    _button.enabled = NO;
    [self.locationManager startUpdatingHeading];
}




#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    //角度
    CGFloat angle = newHeading.magneticHeading;
    [_button setTitle:[NSString stringWithFormat:@"%.0f", angle] forState:UIControlStateNormal];
    
    if (_angleArray.count == 0) {
        _button.enabled = YES;
        [_button setTitle:@"开始" forState:UIControlStateNormal];
        _label.text = @"恭喜你！找到啦";
        [self.locationManager stopUpdatingHeading];
        return;
    }
    float targetAngle = [[_angleArray firstObject] floatValue];
    
    if (targetAngle < 180) {
        if (angle > targetAngle && angle < targetAngle + 180) {
            _label.text = @"<---";
        } else {
            _label.text = @"--->";
        }
        
    } else {
        if (angle < targetAngle && angle > targetAngle - 180) {
            _label.text = @"--->";
        } else {
            _label.text = @"<---";
        }
    }
    if (fabs(targetAngle - angle) < 1.0) {
        [_angleArray removeObjectAtIndex:0];
        [_progress setProgress:(5-_angleArray.count)/5.0 animated:YES];
    }
}


@end
