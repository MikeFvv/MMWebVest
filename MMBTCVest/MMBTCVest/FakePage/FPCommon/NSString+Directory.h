//
//  NSString+Directory.h
//  WheelTime
//
//  Created by Mike on 16/6/16.
//  Copyright © 2016年 微微. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Directory) {
    DirectoryDocuments     = 0,
    DirectoryLibrary      = 1,
    DirectoryTemp         = 2,
};

@interface NSString (Directory)

//打印相关
+ (NSString *)lr_stringDate;


///  获取文件路径， 没有则创建文件夹
///
///  @param name     枚举 选择在哪个文件下面
///  @param pathName 拼接文件夹名称  自带/    如 /Image/uuuuuuu
///
///  @return string全路径
+ (NSString *)stringWithDirectory:(Directory)name appendPathName:(NSString *)pathName;


@end
