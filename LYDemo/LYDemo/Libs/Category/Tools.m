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

// 通过文件路径加载图片，该方法加载图片优势：不会将图片加到内存缓存中（适用类型：较大图片的处理）图片名需加.png/.jpg
+ (UIImage *)imageWithName:(NSString *)imgName
{
    if (imgName) {
        NSString * path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
        UIImage * image = [UIImage imageWithContentsOfFile:path];
        return image;
    }
    return nil;
}

// 根据UIColor生成一个图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    return image;
}


// 创建一个UIView（一般用来创建一条线）
+ (UIView *)lineWithFrame:(CGRect)frame {
    return [self lineWithFrame:frame color:LineColor];
}
+ (UIView *)lineWithFrame:(CGRect)frame color:(UIColor *)color {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    return line;
}


// 创建一个图片
+ (UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image mode:(UIViewContentMode)mode
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    imageView.contentMode = mode;
    return imageView;
}


// 创建Button
+ (UIButton *)createButtonWithFrame:(CGRect)frame backgroundImage:(UIImage *)image title:(NSString *)title addTarget:(id)target action:(SEL)action {
    UIButton *button = [self createButtonWithFrame:frame backgroundColor:nil image:nil backgroundImage:image title:title titleColor:nil titleFont:nil addTarget:target action:action];
    return button;
}
+ (UIButton *)createButtonWithFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title addTarget:(id)target action:(SEL)action {
    UIButton *button = [self createButtonWithFrame:frame backgroundColor:nil image:image backgroundImage:nil title:title titleColor:nil titleFont:nil addTarget:target action:action];
    return button;
}
+ (UIButton *)createButtonWithFrame:(CGRect)frame backgroundColor:(UIColor *)color title:(NSString *)title addTarget:(id)target action:(SEL)action {
    UIButton *button = [self createButtonWithFrame:frame backgroundColor:color image:nil backgroundImage:nil title:title titleColor:nil titleFont:nil addTarget:target action:action];
    return button;
}
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                    backgroundColor:(UIColor *)backgroundColor
                              image:(UIImage *)image
                    backgroundImage:(UIImage *)backgroundImage
                              title:(NSString *)title
                         titleColor:(UIColor *)titleColor
                          titleFont:(UIFont *)font
                          addTarget:(id)target
                             action:(SEL)action
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    if (backgroundColor) { btn.backgroundColor = backgroundColor; }
    if (image) { [btn setNormalAndHighlightedImage:image]; }
    if (backgroundImage) { [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal]; }
    if (title) { [btn setTitle:title forState:UIControlStateNormal]; }
    if (titleColor) { [btn setTitleColor:titleColor forState:UIControlStateNormal]; }
    if (font) { btn.titleLabel.font = font; }
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


// 创建Label
+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text font:(CGFloat)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)align
{
    UILabel * label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = text;
    label.font = UIFont(font);
    if (color == nil) {
        label.textColor = [UIColor darkTextColor];
    } else {
        label.textColor = color;
    }
    label.textAlignment = align;
    return label;
}


// 自适应高度（无限制）（字体有比例）
+ (CGFloat)getMyHeightWithString:(NSString *)string width:(CGFloat)width font:(CGFloat)fontSize {
    return [self getMyHeightWithString:string size:CGSizeMake(width, MAXFLOAT) font:fontSize];
}
// 自适应高度（无限制）（字体无比例）
+ (CGFloat)getMyHeightWithString:(NSString *)string width:(CGFloat)width rFont:(CGFloat)fontSize {
    return [self getMyHeightWithString:string size:CGSizeMake(width, MAXFLOAT) rFont:fontSize];
}

// 自适应高度（有限制）（字体有比例）
+ (CGFloat)getMyHeightWithString:(NSString *)string size:(CGSize)size font:(CGFloat)fontSize {
    CGSize mySize = [self getMySizeWithString:string size:size font:fontSize];
    return mySize.height;
}
// 自适应高度（有限制）（字体无比例）
+ (CGFloat)getMyHeightWithString:(NSString *)string size:(CGSize)size rFont:(CGFloat)fontSize {
    CGSize mySize = [self getMySizeWithString:string size:size rFont:fontSize];
    return mySize.height;
}

// 自适应宽度（字体有比例）
+ (CGFloat)getMyWidthWithString:(NSString *)string size:(CGSize)size font:(CGFloat)fontSize {
    CGSize mySize = [self getMySizeWithString:string size:size font:fontSize];
    return mySize.width;
}
// 自适应宽度（字体无比例）
+ (CGFloat)getMyWidthWithString:(NSString *)string size:(CGSize)size rFont:(CGFloat)fontSize {
    CGSize mySize = [self getMySizeWithString:string size:size rFont:fontSize];
    return mySize.width;
}

// 自适应size（字体有比例）
+ (CGSize)getMySizeWithString:(NSString *)string size:(CGSize)size font:(CGFloat)fontSize {
    CGRect frame = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFont(fontSize)} context:nil];
    return frame.size;
}
// 自适应size（字体无比例）
+ (CGSize)getMySizeWithString:(NSString *)string size:(CGSize)size rFont:(CGFloat)fontSize {
    CGRect frame = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return frame.size;
}




//展示LYAlertView
+ (void)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message {
    [self showAlertViewWithTitle:title message:message buttonTitle:@"确定"];
}
//展示LYAlertView
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle
{
//    LYAlertCustom *alert = [[LYAlertCustom alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil confirmButtonTitle:buttonTitle];
//    [alert show];
}
//展示系统的alert
+ (void)showAlertViewOfSystemWithTitle:(NSString *)title andMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


//设置某个文字的颜色
+ (NSMutableAttributedString *)attributString:(NSString *)string range:(NSRange)range color:(UIColor *)color font:(CGFloat)font
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    if (color) {
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    if (font) {
        [attributedStr addAttribute:NSFontAttributeName value:UIFont(font) range:range];
    }
    return attributedStr;
}



//计算该路径的大小（单位：M）
+ (float)fileSizeAtPath:(NSString *)path
{
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
+ (float)diskOfAllSizeMBytes
{
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *number = [dic objectForKey:NSFileSystemSize];
    return [number floatValue]/1000/1000;
}
//磁盘可用空间（单位：M）
+ (float)diskOfFreeSizeMBytes
{
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
    return [number floatValue]/1000/1000;
}



//把秒转化成时分秒（数字格式）
+ (NSString *)changeTimeWithSecond:(NSInteger)seconds
{
    NSUInteger hour   = seconds/3600;       //时
    NSUInteger minute = (seconds%3600)/60;  //分
    NSUInteger second = seconds%60;         //秒
    NSString *time = [NSString stringWithFormat:@"%.2lu:%.2lu:%.2lu", (unsigned long)hour, (unsigned long)minute, (unsigned long)second];
    return time;
}
//把秒转化成分秒
+ (NSString *)changeTimeMSWithSecond:(NSInteger)seconds
{
    NSUInteger minute = (seconds%3600)/60;  //分
    NSUInteger second = seconds%60;         //秒
    NSString *time = [NSString stringWithFormat:@"%.2lu:%.2lu", (unsigned long)minute, (unsigned long)second];
    return time;
}
//把秒转化成时分秒（文字格式）
+ (NSString *)changeTimeStringWithSecond:(NSInteger)seconds
{
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
+ (NSString *)getMD5_32Bit_string:(NSString *)srcString
{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[16];
    CC_MD5(cStr, (int)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:16 * 2];
    for (int i = 0; i < 16; i++)
        [result appendFormat:@"%02x",digest[i]];
    return result;
}



// URL编码（不包含特殊符号）
+ (NSString *)URLEncodedString:(NSString *)string
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));  //不需要进行编码的字符集合
    return result;
}
// URL编码（包含特殊符号）
+ (NSString *)URLEncodedStringIncludeCharacter:(NSString *)string
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR("!*();+$,%#[] "), kCFStringEncodingUTF8));   //需要进行编码的字符集合
    return result;
}
// URL解码
+ (NSString*)URLDecodedString:(NSString *)string
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)string, CFSTR(""), kCFStringEncodingUTF8));
    return result;
}


// 字典转JSON字符串
+ (NSString *)convertToJsonStringFrom:(NSDictionary *)dict
{
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
+ (NSDictionary *)convertToDictFromJsonString:(NSString *)string
{
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
+ (NSString *)getAppCurrentVersion
{
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
+ (void)openSettingURL
{
    NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:URL];
        }
    }
}

// 获取手机型号
+ (NSString *)getSystemModel
{
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
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage
{
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
+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize
{
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




@implementation UIButton (Attribute)

- (void)setNormalAndHighlightedImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateHighlighted];
}

- (void)setNormalAndHighlightedTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}

- (void)setNormalAndHighlightedTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
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
