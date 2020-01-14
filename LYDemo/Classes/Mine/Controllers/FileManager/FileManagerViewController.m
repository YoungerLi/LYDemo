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
        UIButton *button = [UIButton buttonWithFrame:CGRectMake(50, 20+i*40, kSCREEN_WIDTH-100, 30) backgroundColor:[UIColor redColor] title:nameArray[i] addTarget:self action:@selector(click:)];
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
            NSArray *array1 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:PATH error:&error];
            if (error) {
                NSLog(@"error == %@",error);
            } else {
                NSLog(@"array1 == %@",array1);
            }
        }
            break;
        case 2:{
            //文件的深度遍历
            NSArray *array2 = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:PATH error:nil];
            NSArray *array3 = [[NSFileManager defaultManager] subpathsAtPath:PATH];
            NSLog(@"array2 == %@", array2);
            NSLog(@"array3 == %@", array3);
        }
            break;
        case 3:{
            //创建文件夹(NO表示不创建中间文件夹，YES表示创建中间文件夹)
            BOOL ret = [[NSFileManager defaultManager] createDirectoryAtPath:[PATH stringByAppendingPathComponent:@"liyang1"] withIntermediateDirectories:YES attributes:nil error:nil];
            if (ret) {
                NSLog(@"创建成功");
            } else {
                NSLog(@"创建失败");
            }
        }
            break;
        case 4:{
            //创建文件
            NSString *str = @"我喜欢写笔记";
            NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
            BOOL ret = [[NSFileManager defaultManager] createFileAtPath:[PATH stringByAppendingPathComponent:@"file.txt"] contents:data attributes:nil];
            if (ret) {
                NSLog(@"创建成功");
            } else {
                NSLog(@"创建失败");
            }
        }
            break;
        case 5:{
            //删除文件或文件夹(路径是文件就删除文件，路径是文件夹就删除文件夹)
            BOOL ret = [[NSFileManager defaultManager] removeItemAtPath:[PATH stringByAppendingPathComponent:@"gou"] error:nil];
            if (ret) {
                NSLog(@"删除成功");
            } else {
                NSLog(@"删除失败");
            }
        }
            break;
        case 6:{
            //判断路径是否存在
            BOOL ret1 = [[NSFileManager defaultManager] fileExistsAtPath:[PATH stringByAppendingPathComponent:@"gou"]];
            if (ret1) {
                NSLog(@"存在");
            } else {
                NSLog(@"不存在");
            }
            //判断路径是否存在并且是否是文件夹
            BOOL isDirectory;
            BOOL ret2 = [[NSFileManager defaultManager] fileExistsAtPath:[PATH stringByAppendingPathComponent:@"gou"] isDirectory:&isDirectory];
            NSLog(@"是否存在=%d, 是否是文件夹=%d", ret2, isDirectory);
        }
            break;
        case 7:{
            //文件/目录的移动
            BOOL ret = [[NSFileManager defaultManager] moveItemAtPath:[PATH stringByAppendingPathComponent:@"file.txt"] toPath:[PATH stringByAppendingPathComponent:@"gou/dog.txt"] error:nil];
            if (ret) {
                NSLog(@"移动成功");
            } else {
                NSLog(@"移动失败");
            }
        }
            break;
        case 8:{
            //文件/目录的拷贝
            BOOL ret = [[NSFileManager defaultManager] copyItemAtPath:[PATH stringByAppendingPathComponent:@"file.txt"] toPath:[PATH stringByAppendingPathComponent:@"liyang1/file1.txt"] error:nil];
            if (ret) {
                NSLog(@"拷贝成功");
            } else {
                NSLog(@"拷贝失败");
            }
        }
            break;
        case 9:{
            //获取文件的属性
            NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:[PATH stringByAppendingPathComponent:@"liyang1"] error:nil];
            NSLog(@"文件的属性 == %@", dict);
        }
            break;
        case 10:{
            //计算该路径的大小
            float size = [LYTools fileSizeAtPath:[PATH stringByAppendingPathComponent:@"liyang1"]];
            NSLog(@"该路径的大小 = %.2fM", size);
        }
            break;
        case 11:{
            //数据写入文件
            NSData *data = [NSData dataWithContentsOfFile:@"/Users/jinwenzhuo/Desktop/first.mp3"];
            BOOL ret = [data writeToFile:[PATH stringByAppendingPathComponent:@"liyang1/123.mp3"] atomically:YES];
            if (ret) {
                NSLog(@"写入成功");
            } else {
                NSLog(@"写入失败");
            }
        }
            break;
        default:
            break;
    }
}




@end
