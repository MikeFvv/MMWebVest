/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)


- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;



///  提示框
///
///  @param hint 提示内容   延时时间 2 秒
- (void)showHint:(NSString *)hint;

///  @param hint 提示内容   延时时间 2 秒 不隐藏前面的弹窗
- (void)showHintWithoutHide:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

- (void)showHint:(NSString *)hint fontSize:(float)size;



/*****************************************/

- (void)showMessage:(NSString *)message delay:(NSTimeInterval)delay;


// 显示加载状态
- (void)showLoadingView;
// 显示加载状态 带文字
- (void)showLoadingViewWithText:(NSString *)str;
// 隐藏加载状态界面
- (void)hidenLoadingView;


/// 跳转 WiFi 界面
- (void)openURLWithURL:(NSString *)urlString;

@end








