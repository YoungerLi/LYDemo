//
//  Tools.m
//  test
//
//  Created by liyang on 15/8/31.
//  Copyright (c) 2015年 liyang. All rights reserved.
//

#import "Tools.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>

@implementation Tools

//设置某个文字的颜色
+ (NSMutableAttributedString *)attributString:(NSString *)string range:(NSRange)range color:(UIColor *)color font:(CGFloat)font {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    if (color) {
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    if (font) {
        [attributedStr addAttribute:NSFontAttributeName value:[UIFont fontOfSize:font] range:range];
    }
    return attributedStr;
}
//为某些个文字添加下划线
+ (NSMutableAttributedString *)attributAddLineString:(NSString *)string range:(NSRange)range {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    return attributedStr;
}




//计算该路径的大小（单位：M）
+ (float)fileSizeAtPath:(NSString *)path {
    //判断路径是否存在并且是否是文件夹
    BOOL isDirectory;
    BOOL ret = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (ret) {
        //路径存在
        if (isDirectory) {
            //是文件夹
            long long size = 0;
            NSArray *childerFiles = [[NSFileManager defaultManager] subpathsAtPath:path];
            for (NSString *fileName in childerFiles) {
                NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
                // 计算单个文件大小
                size += [[NSFileManager defaultManager] attributesOfItemAtPath:absolutePath error:nil].fileSize;
            }
            return size/1000.0/1000.0;
        } else {
            //不是文件夹,是文件
            long long size = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil].fileSize;
            return size/1000.0/1000.0;
        }
    } else {
        //路径不存在
        return 0;
    }
}
//删除该路径
+ (void)clearCache:(NSString *)path {
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}
//磁盘总空间（单位：M）
+ (float)diskOfAllSizeMBytes {
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *number = [dic objectForKey:NSFileSystemSize];
    return [number floatValue]/1000/1000;
}
//磁盘可用空间（单位：M）
+ (float)diskOfFreeSizeMBytes {
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
    return [number floatValue]/1000/1000;
}



//把秒转化成时分秒（数字格式）
+ (NSString *)changeTimeWithSecond:(NSInteger)seconds {
    NSUInteger hour   = seconds/3600;       //时
    NSUInteger minute = (seconds%3600)/60;  //分
    NSUInteger second = seconds%60;         //秒
    NSString *time = [NSString stringWithFormat:@"%.2lu:%.2lu:%.2lu", (unsigned long)hour, (unsigned long)minute, (unsigned long)second];
    return time;
}
//把秒转化成分秒
+ (NSString *)changeTimeMSWithSecond:(NSInteger)seconds {
    NSUInteger minute = (seconds%3600)/60;  //分
    NSUInteger second = seconds%60;         //秒
    NSString *time = [NSString stringWithFormat:@"%.2lu:%.2lu", (unsigned long)minute, (unsigned long)second];
    return time;
}
//把秒转化成时分秒（文字格式）
+ (NSString *)changeTimeStringWithSecond:(NSInteger)seconds {
    if (seconds < 60) {
        return [NSString stringWithFormat:@"%zd秒", seconds];
    } else if (seconds < 3600) {
        return [NSString stringWithFormat:@"%zd分钟", seconds/60];
    } else if (seconds < 86400) {
        return [NSString stringWithFormat:@"%zd小时%zd分钟", seconds/3600, (seconds%3600)/60];
    } else {
        return [NSString stringWithFormat:@"%zd天%zd小时%zd分钟",seconds/86400, (seconds%86400)/3600, (seconds%3600)/60];
    }
}

//获取粘贴板的信息
+ (NSString *)getPasteString {
    return [UIPasteboard generalPasteboard].string;
}

//MD5加密
+ (NSString *)getMD5_32Bit_string:(NSString *)srcString {
    const char *cStr = [srcString UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr, (int)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:16 * 2];
    for (int i = 0; i < 16; i++)
        [result appendFormat:@"%02x",digest[i]];
    return result;
}



// URL编码（特殊符号不会被编码）
+ (NSString *)URLEncodedString:(NSString *)string {
//    NSCharacterSet *characterSet = [NSCharacterSet URLQueryAllowedCharacterSet].invertedSet;
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"!$&'()*+,-./:;=?@_~%#[]"];
    return [string stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}
// URL编码（特殊符号会被编码）
+ (NSString *)URLEncodedStringIncludeCharacter:(NSString *)string {
//    NSCharacterSet *characterSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"!*();+$,%#[] "].invertedSet;
    return [string stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}
// URL解码
+ (NSString *)URLDecodedString:(NSString *)string {
    return [string stringByRemovingPercentEncoding];
}


// 字典转JSON字符串
+ (NSString *)convertToJsonStringFrom:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    if (error) {
        MSLog(@"字典转JSON字符串-Json解析失败 = %@", error);
        return nil;
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    //去掉字符串中的空格
    NSRange range = {0, jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    //去掉字符串中的换行符
    NSRange range2 = {0, mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}

// JSON字符串转字典
+ (NSDictionary *)convertToDictFromJsonString:(NSString *)string {
    if (string == nil) {
        return nil;
    }
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        MSLog(@"JSON字符串转字典-Json解析失败 = %@", error);
        return nil;
    }
    return dict;
}



// 获取当前版本号
+ (NSString *)getAppCurrentVersion {
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurrentVersion = [appInfo objectForKey:@"CFBundleShortVersionString"];
    return appCurrentVersion;
}

// 拨打电话
+ (void)callPhone:(NSString *)number {
    if (![NSString isStringAndLength:number]) {
        NSLog(@"抱歉！暂无提供手机号");
        return;
    }
    NSString *str = [[NSString alloc] initWithFormat:@"tel:%@", number];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

// 跳转到系统设置
+ (void)openSettingURL {
    NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:URL];
        }
    }
}

// 获取手机型号（https://www.theiphonewiki.com/wiki/Models）
+ (NSString *)getSystemModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5";         //(GSM+CDMA)
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";        //(GSM)
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";        //(GSM+CDMA)
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";        //(GSM)
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";        //(GSM+CDMA)
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";         //国行、日版、港行
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";    //国行、港行
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";         //美版、台版
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";    //美版、台版
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2";           //WiFi
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2";           //CDMA
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini";        //WiFi
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini";        //GSM+CDMA
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3";           //WiFi
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3";           //GSM+CDMA
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4";           //WiFi
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4";           //GSM+CDMA
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air";         //WiFi
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air";         //Cellular
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2";      //WiFi
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2";      //Cellular
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4";      //WiFi
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4";      //LTE
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}


// 压缩照片
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    CGFloat maxWidth = 640;
    if (sourceImage.size.width < maxWidth) {
        return sourceImage;
    }
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = maxWidth;
        btWidth = sourceImage.size.width * (maxWidth / sourceImage.size.height);
    } else {
        btWidth = maxWidth;
        btHeight = sourceImage.size.height * (maxWidth / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}
+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) NSLog(@"could not scale image");
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end




@implementation NSArray (Valid)

+ (BOOL)isArrayAndCount:(id)obj
{
    if ([obj isKindOfClass:[NSArray class]] && [obj count] != 0 && obj != nil) {
        return YES;
    } else {
        return NO;
    }
}

@end
