//
//  FontNameViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/4.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "FontNameViewController.h"

@interface FontNameViewController ()<UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *fontNameArray;

@end

@implementation FontNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"各种字体";
    [self addPanGesture];
    
    [self.view addSubview:self.tableView];
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fontNameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSString *fontName = self.fontNameArray[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:fontName size:18];
    cell.textLabel.text = [NSString stringWithFormat:@"我是李杨%zd 字体是%@", indexPath.row + 1, fontName];
    
    return cell;
}




#pragma mark - Getters and Setters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVBAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (NSArray *)fontNameArray
{
    if (!_fontNameArray) {
        _fontNameArray = [UIFont familyNames];
    }
    return _fontNameArray;
}

@end
