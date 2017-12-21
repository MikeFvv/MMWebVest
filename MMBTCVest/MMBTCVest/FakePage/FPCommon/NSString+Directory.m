//
//  NSString+Directory.m
//  WheelTime
//
//  Created by Mike on 16/6/16.
//  Copyright © 2016年 微微. All rights reserved.
//

#import "NSString+Directory.h"

@implementation NSString (Directory)


//打印相关
+ (NSString *)lr_stringDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

///  获取文件路径， 没有则创建文件夹
///
///  @param name     枚举 选择在哪个文件下面
///  @param pathName 拼接文件夹名称  自带/    如 /Image/uuuuuuu
///
///  @return string全路径
+ (NSString *)stringWithDirectory:(Directory)name appendPathName:(NSString *)pathName
{
    NSString * directory;
    
    switch (name) {
        case 0: {
            directory = @"Documents";
            break;
        } case 1: {
            directory = @"Library";
            break;
        } case 2: {
            directory = @"tmp";
            break;
        }
        default:
            break;
    }
    NSString *tempPath = [NSHomeDirectory() stringByAppendingPathComponent:directory];
    
    NSString *path;
    if (pathName == nil || [pathName isEqualToString:@""]) {
        
        path = tempPath;
        
    } else {
        
        path = [NSString stringWithFormat:@"%@%@", tempPath, pathName];
    }
    
    
    
    // 判断文件夹是否存在，如果不存在，则创建
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
    
    
    
    // 可以创建
    //    NSFileManager *fileManager = [[NSFileManager alloc] init];
    //    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //    NSString *createPath = [NSString stringWithFormat:@"%@/Image/uuuuuuu", pathDocuments];
    //
    //    // 判断文件夹是否存在，如果不存在，则创建
    //    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
    //        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    //    } else {
    //        NSLog(@"FileDir is exists.");
    //    }
    //
    //    YHLog(@"------%@" ,  createPath);
    
    
}

@end














