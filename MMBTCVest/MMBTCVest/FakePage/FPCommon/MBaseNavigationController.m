//
//  YHNavigationController.m
//  YouCheLian
//
//  Created by Mike on 15/11/7.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MBaseNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface MBaseNavigationController ()

@end

@implementation MBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setBaseNav];
    
    
//    // 4.设置状态栏样式
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)setBaseNav {
    
    self.navigationBar.translucent = NO;
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
    
    // 设置导航栏 Nav 头部颜色
    self.navigationBar.barTintColor = [UIColor redColor];
    //    [self.navigationController.navigationBar setBarTintColor:kNavColor];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@""]
                             forBarMetrics:UIBarMetricsDefault];
}



/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)  // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //这里可以设置左右按钮 统一管理方法
        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav_back.png" highImageName:@"nav_back.png" target:self action:@selector(back)];
        
    }
    
    //让手势可交互
    //    self.enable = YES;
    [super pushViewController:viewController animated:animated];
}




#pragma mark - 返回上一级控制器
- (void)back
{
    // !!! 这里用的是self, 因为self就是当前正在使用的导航控制器
    [self popViewControllerAnimated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
