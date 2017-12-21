//
//  FPHomeViewController.m
//  MInfoQuery
//
//  Created by Mike on 2017/8/9.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "FPHomeViewController.h"
#import "FirstContentViewCell.h"

#import "PhoneNumController.h"  // 手机号
#import "PerIDViewController.h"  // 身份证查询
#import "PeccancyQueryController.h"  // 违章查询

#import "PostcodeQueryController.h"  // 邮编查询
#import "PerIDViewController.h"     // 身份证查询
#import "IPQueryController.h"    // IP地址查询
#import "BankCardController.h"   // 银行卡查询
#import "ExpressQueryController.h"  // 全国快递查询

#import "UIImage+Extension.h"



@interface FPHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
// 导航栏底部的线条
@property (nonatomic, strong) UIImageView  *navBarHairlineImageView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end




@implementation FPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"首页";
    
    self.view.backgroundColor = kFakePageMainColor;
  
    //设置导航条颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage gxz_imageWithColor: [UIColor colorWithRed: 0.953 green: 0.51 blue: 0.318 alpha: 1]] forBarMetrics:UIBarMetricsDefault];
    
    //设置状态栏字体颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    //    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    
    //设置导航栏文字颜色
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:kColorPink forKey:NSForegroundColorAttributeName];
    
    
    
    [self initData];
    
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)initData {
    
    // *** 权限控制 第一组***
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setObject:@"手机归属地" forKey:@"title"];
    [dict1 setObject:@"home_phone" forKey:@"image"];
    
    [dict1 setObject: @(1) forKey:@"roleState"];
    
    [self.dataArray addObject:dict1];
    
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setObject:@"邮编查询" forKey:@"title"];
    [dict2 setObject:@"home_youbian" forKey:@"image"];
    
    [dict2 setObject: @(1) forKey:@"roleState"];
    [self.dataArray addObject:dict2];
    
    
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
    [dict3 setObject:@"身份证查询" forKey:@"title"];
    [dict3 setObject:@"home_shenfenzheng" forKey:@"image"];
    
    [dict3 setObject: @(1) forKey:@"roleState"];
    [self.dataArray addObject:dict3];
    
    
    
    NSMutableDictionary *dict4 = [NSMutableDictionary dictionary];
    [dict4 setObject:@"IP地址" forKey:@"title"];
    [dict4 setObject:@"home_ip" forKey:@"image"];
    
    [dict4 setObject: @(1) forKey:@"roleState"];
    [self.dataArray addObject:dict4];
    
    
    NSMutableDictionary *dict5 = [NSMutableDictionary dictionary];
    [dict5 setObject:@"违章查询" forKey:@"title"];
    [dict5 setObject:@"home_weizhangquery" forKey:@"image"];
    
    [dict5 setObject: @(1) forKey:@"roleState"];
    
    [self.dataArray addObject:dict5];
    
    
    NSMutableDictionary *dict6 = [NSMutableDictionary dictionary];
    [dict6 setObject:@"银行卡查询" forKey:@"title"];
    [dict6 setObject:@"home_BankCard" forKey:@"image"];
    
    [dict6 setObject: @(1) forKey:@"roleState"];
    
    [self.dataArray addObject:dict6];
    
    
    NSMutableDictionary *dict7 = [NSMutableDictionary dictionary];
    [dict7 setObject:@"全国快递查询" forKey:@"title"];
    [dict7 setObject:@"home_express" forKey:@"image"];
    
    [dict7 setObject: @(1) forKey:@"roleState"];
    
    [self.dataArray addObject:dict7];
    
}





#pragma mark - 去掉导航栏底部的线条
/**
 *  当控制器的view即将消失的时候调用
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


/**
 *  当控制器的view即将显示的时候调用
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}



#pragma mark - 点击事件
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    
    //
    if ([eventName isEqualToString:@"HomeContentViewCellClick"]) {
        
        if ([userInfo[@"title"] isEqualToString:@"手机归属地"]) {
            
            PhoneNumController *vc = [[PhoneNumController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if ([userInfo[@"title"] isEqualToString:@"邮编查询"]) {
            
            PostcodeQueryController *vc = [[PostcodeQueryController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if ([userInfo[@"title"] isEqualToString:@"身份证查询"]) {
            
            //                        [self showHint:@"您好,客户预约功能目前还未开放"];
            PerIDViewController *vc = [[PerIDViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if ([userInfo[@"title"] isEqualToString:@"IP地址"]) {
            
            IPQueryController *vc = [[IPQueryController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if ([userInfo[@"title"] isEqualToString:@"违章查询"]) {
            
            PeccancyQueryController *vc = [[PeccancyQueryController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if ([userInfo[@"title"] isEqualToString:@"银行卡查询"]) {
            
            BankCardController *vc = [[BankCardController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if ([userInfo[@"title"] isEqualToString:@"全国快递查询"]) {
            
            ExpressQueryController *vc = [[ExpressQueryController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        
    }
    
}




#pragma mark - 初始化 tableView
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,kUIScreenWidth,kUIScreenHeight - kUINavHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        // 隐藏分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kFakePageMainColor;
        //去掉下面没有数据呈现的cell
        _tableView.tableFooterView = [[UIView alloc]init];
        // 显示横向滚动条
        _tableView.showsHorizontalScrollIndicator = NO;
        // 显示纵向滚动条
        _tableView.showsVerticalScrollIndicator = NO;
        
        // 禁止拖动
        //   _tableView.scrollEnabled = NO;
        //        _tableView.userInteractionEnabled = NO;
        
        // 偏移
        //   _tableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
        
    }
    return _tableView;
}


#pragma mark - UITableView 数据源方法
// 返回组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 返回行数
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    FirstContentViewCell *cell = [FirstContentViewCell cellWithTableView:tableView];
    cell.dataArray = self.dataArray;
    return cell;
    
}


#pragma mark - UITableView 代理方法
// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kUIScreenHeight_Scale_iPhone6(265 + 130+180);
}

// 选中某行cell时会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"选中didSelectRowAtIndexPath row = %zd", indexPath.row);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

