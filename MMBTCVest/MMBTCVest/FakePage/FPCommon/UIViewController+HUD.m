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

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;


@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD
{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD
{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}


- (void)hideHud
{
    [[self HUD] hide:YES];
}





///  提示框
///
///  @param hint 提示内容   延时时间 2 秒
- (void)showHint:(NSString *)hint
{
    [self hideHud];
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    //    hud.yOffset = -(view.frame.size.height*0.5-64-64*0.5);
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.0f];
    [self setHUD:hud];
}

///  @param hint 提示内容   延时时间 2 秒
- (void)showHintWithoutHide:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    //    hud.yOffset = -(view.frame.size.height*0.5-64-64*0.5);
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.0f];
    
}



- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    [self hideHud];
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = -(view.frame.size.height *0.5-64-64*0.5);
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.0f];
    [self setHUD:hud];
}

- (void)showHint:(NSString *)hint fontSize:(float)size {
    [self hideHud];
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.labelFont = [UIFont systemFontOfSize:size];
    hud.margin = 10.f;
    hud.yOffset = -(view.frame.size.height *0.5-64-64*0.5);
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.0f];
    [self setHUD:hud];
}



/********************** 没有文字加载状态 ************************/
// 显示加载状态
- (void)showLoadingView {
    
    [self hideHud];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    // 添加到 window 上面 整个屏幕就不能交互了
    //    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    
    [self.view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
    
}

// 显示加载状态 带文字
- (void)showLoadingViewWithText:(NSString *)str{
    [self hideHud];
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
    HUD.labelText = str;
    // 需要移除， 创建多了会崩溃
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    [self.view addSubview:HUD];
    [self setHUD:HUD];
}

// 隐藏加载状态界面
- (void)hidenLoadingView {
    
    [[self HUD] hide:YES];
}

/************************************************/





/*****************************************/

///  警告框  自定义 延时时间
///
///  @param message 内容
///  @param delay   延时时间 秒
- (void)showMessage:(NSString *)message delay:(NSTimeInterval)delay {
    [self hideHud];
    MBProgressHUD *hub = [[MBProgressHUD alloc] init];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = message;
    [hub show:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:hub];
    [hub hide:YES afterDelay:delay];
    [self setHUD:hub];
}



/// 跳转 WiFi 界面
- (void)openURLWithURL:(NSString *)urlString
{
    if (urlString == nil) {
        urlString = @"prefs:root=WIFI";
    }
    
    UIResponder* responder = self;
    while ((responder = [responder nextResponder]) != nil)
    {
        if([responder respondsToSelector:@selector(openURL:)] == YES)
        {
            [responder performSelector:@selector(openURL:) withObject:[NSURL URLWithString:urlString]];
            break;
        }
    }
    
    //iOS 10版本无法跳转到系统的WiFi界面，提示用户前往设置连接wifi
    if ([UIDevice currentDevice].systemVersion.integerValue >= 10) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请前往手机设置中连接设备的Wi-Fi" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alertView show];
    }
    
    
}



@end





