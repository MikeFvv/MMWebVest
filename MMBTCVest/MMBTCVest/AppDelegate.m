//
//  AppDelegate.m
//  MMBTCVest
//
//  Created by Mike on 2017/12/21.
//  Copyright © 2017年 Mike. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+MMFun.h"
#import "MBaseTabBarViewController.h"







@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.launchOptions = launchOptions;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setLoadConfigThirdService];
    
    [self.window makeKeyAndVisible];
    return YES;
    
    
    return YES;
}




#warning 需要配置RN环境 参考: http://reactnative.cn/docs/0.51/getting-started.html
#pragma mark - 马甲页面入口  ⭕️推送已经写好，集成别人代码需要将推送功能全部去掉！
// ⭕️ 1. 手动调试代码时在 AppMacros.h 类修改
//    2. 需要修改 BundleIdntifier  版本号  默认的0.0.1可以测试
- (UIViewController *)nativeRootController {
    if (!_nativeRootController) {
        // ❌  ⚠️壳入口⚠️   UIViewController 替换自己的入口
        MBaseTabBarViewController *tab = [[MBaseTabBarViewController alloc] init];
        _nativeRootController = tab;
        _nativeRootController.view.backgroundColor = [UIColor whiteColor];
    }
    return _nativeRootController;
}




@end
