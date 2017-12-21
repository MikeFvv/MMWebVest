//
//  YHTabBarViewController.m
//  YouCheLian
//
//  Created by Mike on 15/11/7.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "MBaseTabBarViewController.h"
#import "MTabBar.h"

#import "FPHomeViewController.h"
#import "FPSetViewController.h"
#import "MBaseNavigationController.h"


@interface MBaseTabBarViewController ()<tabbarDelegate>

@property(nonatomic ,strong) MTabBar *costomTabBar;


@end

@implementation MBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tabbar
    [self setUpTabBar];
    
    //添加子控制器
    [self setUpAllChildViewController];
}

//取出系统自带的tabbar并把里面的按钮删除掉
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //    self.tabBar.hidden = YES;
    
    
    for ( UIView * child in  self.tabBar.subviews) {
        child.hidden = YES;
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    self.costomTabBar.hidden = NO;
}

-(void)setUpTabBar{
    MTabBar *customTabBar = [[MTabBar alloc]init];
    customTabBar.delegate = self;
    //    customTabBar.backgroundColor = [UIColor redColor];
    customTabBar.frame = self.tabBar.bounds;
    self.costomTabBar = customTabBar;
    [self.tabBar addSubview:customTabBar];
    
}

-(void)tabBar:(MTabBar *)tabBar didselectedButtonFrom:(int)from to:(int)to{
    NSLog(@"%d, %d", from, to);
    self.selectedIndex = to;
    NSLog(@"%lu", (unsigned long)self.selectedIndex);
    
    
}

-(void)setUpAllChildViewController {

    //
    FPHomeViewController *vipVC = [[FPHomeViewController alloc] init];
    [self setupChildViewController:vipVC title:@"首页" imageName:@"home_tabbarhome_normal.png" seleceImageName:@"home_tabbarhome_selected.png"];
    
    
    FPSetViewController *chatListVC = [[FPSetViewController alloc] init];
    [self setupChildViewController:chatListVC title:@"设置" imageName:@"home_set_normal.png" seleceImageName:@"home_set_selected.png"];
    
}


-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
        controller.title = title;
//    controller.tabBarItem.title = title; // 设置跟Nav title一样文字
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    
    //包装导航控制器
    MBaseNavigationController *nav = [[MBaseNavigationController alloc]initWithRootViewController:controller];
    [self addChildViewController:nav];
    [self.costomTabBar addTabBarButtonWithItem:controller.tabBarItem];
    
}




@end






