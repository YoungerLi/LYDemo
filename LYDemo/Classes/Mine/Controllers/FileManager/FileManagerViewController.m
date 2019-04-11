//
//  FileManagerViewController.m
//  text
//
//  Created by Kosien on 17/1/21.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "FileManagerViewController.h"

#define PATH @"/Users/jinwenzhuo/Desktop/liyang"

@interface FileManagerViewController ()

@end

@implementation FileManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"文件操作";
    
    //获取沙盒路径
    NSLog(@"Home      = %@", NSHomeDirectory());
    
    //1.获取Documents目录
    //NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"Documents = %@", array[0]);
    
    //2.获取Library目录
    //NSString *LibraryPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSArray *array1 = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSLog(@"Library   = %@", array1[0]);
    
    //3.获取Caches目录
    //NSString *CachesPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    NSArray *array2 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSLog(@"Caches    = %@", array2[0]);
    
    //4.获取tmp目录
    //NSString *tmpPath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    NSLog(@"tmp       = %@", NSTemporaryDirectory());
    
    //1、Documents：苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录。
    //2、Library：存储程序的默认设置或其它状态信息;(Library下的Caches文件夹：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除）
    //3、tmp：提供一个即时创建临时文件的地方。
    
    
    //
    NSArray *nameArray = @[@"1、浅度遍历",
                           @"2、深度遍历",
                           @"3、创建文件夹",
                           @"4、创建文件",
                           @"5、删除文件或文件夹",
                           @"6、判断路径是否存在",
                           @"7、文件/目录的移动",
                           @"8、文件/目录的拷贝",
                           @"9、获取文件的属性",
                           @"10、计算该路径的大小",
                           @"11、数据写入文件"];
    for (int i = 0; i < nameArray.count; i++) {
        UIButton *button = [Tools createButtonWithFrame:CGRectMake(50, 70+i*40, SCREEN_WIDTH-100, 30) backgroundColor:[UIColor redColor] title:nameArray[i] addTarget:self action:@selector(click:)];
        button.tag = 1 + i;
        [self.view addSubview:button];
    }
}

- (void)click:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:{
            //文件的浅度遍历
            NSError *error = nil;
            NSArray *array1 = [LYFileManager contentsOfDirectoryAtPath:PATH error:&error];
            if (error) {
                MSLog(@"error == %@",error);
            } else {
                MSLog(@"array1 == %@",array1);
            }
        }
            break;
        case 2:{
            //文件的深度遍历
            NSArray *array2 = [LYFileManager subpathsOfDirectoryAtPath:PATH error:nil];
            NSArray *array3 = [LYFileManager subpathsAtPath:PATH];
            MSLog(@"array2 == %@", array2);
            MSLog(@"array3 == %@", array3);
        }
            break;
        case 3:{
            //创建文件夹(NO表示不创建中间文件夹，YES表示创建中间文件夹)
            BOOL ret = [LYFileManager createDirectoryAtPath:[PATH stringByAppendingPathComponent:@"liyang1"] withIntermediateDirectories:YES attributes:nil error:nil];
            if (ret) {
                MSLog(@"创建成功");
            } else {
                MSLog(@"创建失败");
            }
        }
            break;
        case 4:{
            //创建文件
            NSString *str = @"我喜欢写笔记";
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            BOOL ret = [LYFileManager createFileAtPath:[PATH stringByAppendingPathComponent:@"file.txt"] contents:data attributes:nil];
            if (ret) {
                MSLog(@"创建成功");
            } else {
                MSLog(@"创建失败");
            }
        }
            break;
        case 5:{
            //删除文件或文件夹(路径是文件就删除文件，路径是文件夹就删除文件夹)
            BOOL ret = [LYFileManager removeItemAtPath:[PATH stringByAppendingPathComponent:@"gou"] error:nil];
            if (ret) {
                MSLog(@"删除成功");
            } else {
                MSLog(@"删除失败");
            }
        }
            break;
        case 6:{
            //判断路径是否存在
            BOOL ret1 = [LYFileManager fileExistsAtPath:[PATH stringByAppendingPathComponent:@"gou"]];
            if (ret1) {
                MSLog(@"存在");
            } else {
                MSLog(@"不存在");
            }
            //判断路径是否存在并且是否是文件夹
            BOOL isDirectory;
            BOOL ret2 = [LYFileManager fileExistsAtPath:[PATH stringByAppendingPathComponent:@"gou"] isDirectory:&isDirectory];
            MSLog(@"是否存在=%d, 是否是文件夹=%d", ret2, isDirectory);
        }
            break;
        case 7:{
            //文件/目录的移动
            BOOL ret = [LYFileManager moveItemAtPath:[PATH stringByAppendingPathComponent:@"file.txt"] toPath:[PATH stringByAppendingPathComponent:@"gou/dog.txt"] error:nil];
            if (ret) {
                MSLog(@"移动成功");
            } else {
                MSLog(@"移动失败");
            }
        }
            break;
        case 8:{
            //文件/目录的拷贝
            BOOL ret = [LYFileManager copyItemAtPath:[PATH stringByAppendingPathComponent:@"file.txt"] toPath:[PATH stringByAppendingPathComponent:@"liyang1/file1.txt"] error:nil];
            if (ret) {
                MSLog(@"拷贝成功");
            } else {
                MSLog(@"拷贝失败");
            }
        }
            break;
        case 9:{
            //获取文件的属性
            NSDictionary *dict = [LYFileManager attributesOfItemAtPath:[PATH stringByAppendingPathComponent:@"liyang1"] error:nil];
            MSLog(@"文件的属性 == %@", dict);
        }
            break;
        case 10:{
            //计算该路径的大小
            float size = [Tools fileSizeAtPath:[PATH stringByAppendingPathComponent:@"liyang1"]];
            MSLog(@"该路径的大小 = %.2fM", size);
        }
            break;
        case 11:{
            //数据写入文件
            NSData *data = [NSData dataWithContentsOfFile:@"/Users/jinwenzhuo/Desktop/first.mp3"];
            BOOL ret = [data writeToFile:[PATH stringByAppendingPathComponent:@"liyang1/123.mp3"] atomically:YES];
            if (ret) {
                MSLog(@"写入成功");
            } else {
                MSLog(@"写入失败");
            }
        }
            break;
        default:
            break;
    }
}




@end
