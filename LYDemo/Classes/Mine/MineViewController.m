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
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *nameArray;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Hulk";
    
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVBAR_HEIGHT-TABBAR_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
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
                      @"WebViewController",                 //网页
                      @"WebViewController1",                //网页1
                      @"WebViewController2",                //网页2
                      @"WebViewController3",                //网页3
                      @"WebViewController4",                //网页4
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
                      @"网页-17326923630",
                      @"网页-18500070368",
                      @"网页-17333679562",
                      @"网页-13311175462",
                      @"网页-17301259715",
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
                      nil];
    }
    return _nameArray;
}

@end
