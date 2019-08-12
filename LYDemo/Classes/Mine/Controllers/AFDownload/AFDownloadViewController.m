//
//  AFDownloadViewController.m
//  text
//
//  Created by Kosien on 17/1/17.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "AFDownloadViewController.h"

//下载的视频文件9M http://120.25.226.186:32812/resources/videos/minion_01.mp4
//下载文件all.zip http://imgcache.qq.com/club/item/avatar/zip/7/i87/all.zip
//下载QQ安装包30M  http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg
//下载简书apk15.3M https://downloads.jianshu.io/apps/haruki/JianShu-2.1.0.apk
//廊坊通录音文件12K http://api.langfangtong.cn/upload/audio/20161217/1481962612123.amr

#define PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/minion_01.mp4"]

@interface AFDownloadViewController ()

@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;

@end

@implementation AFDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"下载";
    
    //下载按钮
    self.button1 = [UIButton buttonWithFrame:CGRectMake(50, 20, kSCREEN_WIDTH-100, 50) backgroundColor:[UIColor redColor] title:@"下载" addTarget:self action:@selector(downloadClick)];
    [self.view addSubview:self.button1];
    
    //删除按钮
    self.button2 = [UIButton buttonWithFrame:CGRectMake(50, kSCREEN_HEIGHT-100, kSCREEN_WIDTH-100, 50) backgroundColor:[UIColor redColor] title:@"删除" addTarget:self action:@selector(deleteClick)];
    [self.view addSubview:self.button2];
    self.button2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.button2.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:50].active = YES;
    [self.button2.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-50].active = YES;
    [self.button2.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-50].active = YES;
    [self.button2.heightAnchor constraintEqualToConstant:50].active = YES;
    
    //检查有没有
    self.button3 = [UIButton buttonWithFrame:CGRectMake(50, self.button1.ly_bottom + 20, kSCREEN_WIDTH-100, 50) backgroundColor:[UIColor redColor] title:@"检查有没有" addTarget:self action:@selector(checkClick)];
    [self.view addSubview:self.button3];
    
    //进度条
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.mode = MBProgressHUDModeAnnularDeterminate;//设置圆形
    self.HUD.label.text = @"下载中...";
}

//下载按钮
- (void)downloadClick {
    if ([LYFileManager fileExistsAtPath:PATH]) {
        [self showAlertControllerWithTitle:@"已存在" message:nil];
        return;
    }
    [self.HUD showAnimated:YES];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"]];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        NSLog(@"下载进度 == %f", downloadProgress.fractionCompleted);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.HUD.progress = downloadProgress.fractionCompleted;
        }];
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //存放路径
        NSString *component = [NSString stringWithFormat:@"Library/Caches/%@", response.suggestedFilename];
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:component];
        MSLog(@"下载存放的路径 == %@", path);
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //下载完成
        NSLog(@"下载完成 == %@", filePath);
        [self.HUD hideAnimated:YES];
    }];
    [task resume];
}

//删除按钮
- (void)deleteClick {
    if ([LYFileManager fileExistsAtPath:PATH]) {
        [LYFileManager removeItemAtPath:PATH error:nil];
    }
}

//检查有没有
- (void)checkClick {
    if ([LYFileManager fileExistsAtPath:PATH]) {
        float size = [Tools fileSizeAtPath:PATH];
        [self.button3 setTitle:[NSString stringWithFormat:@"存在(%.1fM)", size] forState:UIControlStateNormal];
    } else {
        [self.button3 setTitle:@"不存在" forState:UIControlStateNormal];
    }
}

@end
