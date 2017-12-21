//
//  FPSetViewController.m
//  MInfoQuery
//
//  Created by Mike on 2017/8/13.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "FPSetViewController.h"
#import "FPSetViewCell.h"
#import "FPFeedbackViewController.h"
#import "FPAboutController.h"

@interface FPSetViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *imagArray;

@end

@implementation FPSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    [self preparUI];
    
    _dataArray = @[@"反馈",@"关于"];
    _imagArray = @[@"fp_feedback.png",@"fp_about.png"];
    
    self.navigationController.navigationBar.barTintColor = APPCOLOR;
    
    //设置导航栏文字颜色
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:kColorPink forKey:NSForegroundColorAttributeName];
    
    // 注册cell
    [self.tableView registerClass:[FPSetViewCell class] forCellReuseIdentifier:@"FPSetViewCell"];
}



#pragma mark - 设置界面
- (void)preparUI {
    
    [self.view addSubview:self.tableView];
    
}


#pragma mark - 初始化 tableView
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,kUIScreenWidth,kUIScreenHeight - kUINavHeight) style:UITableViewStylePlain];
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
        _tableView.showsVerticalScrollIndicator = YES;
        
        // 禁止拖动
        //   _tableView.scrollEnabled = NO;
        // 偏移
        //   _tableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
        
    }
    return _tableView;
}


#pragma mark - UITableView 数据源方法
// 返回行数
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
 
    
    FPSetViewCell *cell = [FPSetViewCell cellWithTableView:tableView];

    cell.imagView.image = [UIImage imageNamed:self.imagArray[indexPath.row]];
    cell.nameLabel.text = self.dataArray[indexPath.row];
    
    // 最后一个隐藏底线条
    if (indexPath.row == self.dataArray.count -1) {
        cell.isLastCell = YES;
    } else {
        cell.isLastCell = NO;
    }
    
    return cell;
}


#pragma mark - UITableView 代理方法
// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

// 选中某行cell时会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        FPFeedbackViewController *hcVc = [[FPFeedbackViewController alloc] init];
        [self.navigationController pushViewController:hcVc animated:YES];
    } if (indexPath.row == 1) {
        FPAboutController *vc = [[FPAboutController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    NSLog(@"选中didSelectRowAtIndexPath row = %ld", indexPath.row);
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
