//
//  UIBarButtonItem+Extension.m
//  MikeProgramer
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIImage+Extension.h"


@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
  UIButton *button = [[UIButton alloc] init];
  [button setBackgroundImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
  [button setBackgroundImage:[UIImage imageWithName:highImageName] forState:UIControlStateHighlighted];
  
  // 设置按钮的尺寸为背景图片的尺寸
//  button.size = button.currentBackgroundImage.size;
  
  CGRect frame = button.frame;
  frame.size = button.currentBackgroundImage.size;
  button.frame = frame;
  
  
  // 监听按钮点击
  [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
  return [UIBarButtonItem itemWithImageName:imageName highImageName:nil target:target action:action];
}

@end
