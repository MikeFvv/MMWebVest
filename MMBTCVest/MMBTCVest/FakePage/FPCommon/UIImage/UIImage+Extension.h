//
//  UIImage+Extension.h
//  MInfoQuery
//
//  Created by dodreamteam on 2017/4/25.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIImage (Extension)

+ (UIImage *)gxz_imageWithColor:(UIColor *)color;

+ (UIImage *)videoFramerateWithPath:(NSString *)videoPath;

// 压缩图片
+ (UIImage *)simpleImage:(UIImage *)originImg;

+ (UIImage *)makeArrowImageWithSize:(CGSize)imageSize
                              image:(UIImage *)image
                           isSender:(BOOL)isSender;

+ (UIImage *)addImage2:(UIImage *)firstImg
               toImage:(UIImage *)secondImg;

+ (UIImage *)addImage:(UIImage *)firstImg
              toImage:(UIImage *)secondImg;


/// 执行图片下载
//+(UIImage *)getImageFromURL:(NSString *)fileURL;

+ (UIImage*) imageWithName:(NSString *) imageName;
+ (UIImage*) resizableImageWithName:(NSString *)imageName;
- (UIImage*) scaleImageWithSize:(CGSize)size;

@end
