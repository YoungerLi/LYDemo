//
//  QRCodeViewController.m
//  App
//
//  Created by KosienYFB on 16/7/9.
//  Copyright © 2016年 kosien. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    UIImageView                 *_backView;     //最大的背景（透明）
    AVCaptureSession            *_session;      //捕捉会话
    AVCaptureVideoPreviewLayer  *_previewLayer; //展示layer
}
@property (nonatomic, strong) UILabel *showLabel;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"扫一扫"];
    
    _backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backView.image = [UIImage imageNamed:@"saomiao1"];
    [self.view addSubview:_backView];
    
    _showLabel = [Tools createLabelWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50) text:nil textColor:WHITECOLOR textAlignment:1];
    _showLabel.numberOfLines = 0;
    [self.view addSubview:_showLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self startReading];//开始扫描
}


#pragma mark - 开始扫描

- (void)startReading
{
    NSError *error;
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        MSLog(@"error == %@", [error localizedDescription]);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未获得授权使用摄像头" message:@"请在“设置”-“隐私”-“相机”中打开" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    //4.实例化捕捉会话
    _session = [[AVCaptureSession alloc] init];
    if ([_session canAddInput:input]) {
        [_session addInput:input];
    }
    if ([_session canAddOutput:output]) {
        [_session addOutput:output];
    }
    //5.1.设置代理
    [output setMetadataObjectsDelegate:self queue:dispatch_queue_create("myQueue", NULL)];
    //5.2.设置输出媒体数据类型为QRCode
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    //6.实例化预览图层
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    //7.设置预览图层填充方式
    [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //8.设置图层的frame
    [_previewLayer setFrame:_backView.layer.bounds];
    //9.将图层添加到预览view的图层上
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    //10.设置扫描范围
    output.rectOfInterest = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //11.开始扫描
    [_session startRunning];
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate
//扫描完成
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        NSString *stringValue = [metadataObject stringValue];
        MSLog(@"扫描结果 == %@", stringValue);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.showLabel.text = stringValue;
        });
    }
}


#pragma mark - 停止扫描

- (void)viewWillDisappear:(BOOL)animated {
    [_session stopRunning];
    _session = nil;
    [_previewLayer removeFromSuperlayer];
    [super viewWillDisappear:YES];
}

@end
