//
//  MessageCenterViewController.m
//  LYDemo
//
//  Created by wukongzuche on 2019/4/11.
//  Copyright © 2019 kosien. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "LYAPIBaseManager.h"
#import "LYProtocol.h"

@interface MessageCenterViewController ()<LYAPIManagerParamsSource, LYAPIManagerCallbackDelegate, LYProtocol>

@property (nonatomic, strong) LYAPIBaseManager *apiManager;

@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Protocol";
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.apiManager loadData];
}


#pragma mark - LYAPIManagerParamsSource

- (NSDictionary *)paramsForApi:(LYAPIBaseManager *)manager {
    NSDictionary *dic = @{@"aid":@"1234", @"name":@"liyang"};
    return dic;
}


#pragma mark - LYAPIManagerCallbackDelegate

- (void)managerCallAPIDidSuccess:(LYAPIBaseManager *)manager {
    NSDictionary *data = [manager fetchDataWithReformer:nil];
    NSLog(@"请求成功 = %@", data);
}

- (void)managerCallAPIDidFailed:(LYAPIBaseManager *)manager {
    NSLog(@"请求失败");
}


#pragma mark - Getters

- (LYAPIBaseManager *)apiManager {
    if (!_apiManager) {
        _apiManager = [[LYAPIBaseManager alloc] init];
        _apiManager.paramsSource = self;
        _apiManager.delegate = self;
    }
    return _apiManager;
}

@end
