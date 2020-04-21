//
//  MineViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/3.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSArray *nameArray;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Hulk";
    
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.text       = self.nameArray[indexPath.row];
    cell.detailTextLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class class = NSClassFromString(self.dataArray[indexPath.row]);
    UIViewController *VC = [[class alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - Getters and Setters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] initWithObjects:
                      @"FontNameViewController",            //各种字体
                      @"BezierViewController",              //画图
                      @"AFDownloadViewController",          //下载数据
                      @"LocalNotiViewController",           //发送本地通知
                      @"OpenURLViewController",             //应用跳转
                      @"FileManagerViewController",         //文件操作&沙盒路径
                      @"AudioViewController",               //音频播放 http://www.cnblogs.com/kenshincui/p/4186022.html
                      @"AMapLocationViewController",        //高德单次定位
                      @"MKMapViewController",               //地图导航
                      @"NaviBarHiddenViewController",       //导航栏属性
                      @"ReachAbilityViewController",        //监测网络状态
                      @"ReceiveDataViewController",         //Block
                      @"GCDViewController",                 //多线程GCD
                      @"NSOperationQueueViewController",    //多线程NSOperationQueue
                      @"MasonryViewController",             //Masonry布局
                      @"NSTimerViewController",             //定时器
                      @"MessageCenterViewController",       //Delegate&Protocol
                      @"BubbleSequenceViewController",      //冒泡排序
                      @"PaoMaViewController",               //跑马灯
                      @"UUIDViewController",                //获取设备唯一标识符
                      @"CopyViewController",                //浅复制与深复制
                      @"HealthViewController",              //健康数据
                      @"CountDownViewController",           //倒计时动画
                      @"QRCodeViewController",              //二维码扫描
                      @"ReactiveObjcViewController",        //ReactiveObjc
                      @"LoginViewController",               //登录
                      nil];
    }
    return _dataArray;
}

- (NSArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [[NSArray alloc] initWithObjects:
                      @"各种字体",
                      @"画图",
                      @"下载数据",
                      @"发送本地通知",
                      @"应用跳转",
                      @"文件操作&沙盒路径",
                      @"音频播放---",
                      @"高德单次定位---",
                      @"地图导航---",
                      @"导航栏属性---",
                      @"监测网络状态---",
                      @"Block",
                      @"多线程GCD",
                      @"多线程NSOperationQueue---",
                      @"Masonry布局---",
                      @"定时器",
                      @"Delegate&Protocol",
                      @"冒泡排序---",
                      @"跑马灯",
                      @"获取设备唯一标识符",
                      @"浅复制与深复制",
                      @"健康数据",
                      @"倒计时动画",
                      @"二维码扫描",
                      @"ReactiveObjc",
                      @"登录",
                      nil];
    }
    return _nameArray;
}

@end
