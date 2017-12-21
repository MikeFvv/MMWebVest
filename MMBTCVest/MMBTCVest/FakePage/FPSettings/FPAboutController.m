//
//  FPAboutController.m
//  MInfoQuery
//
//  Created by Mike on 2017/8/14.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "FPAboutController.h"
#import "FPAboutCell.h"

static NSString *AboutCellID = @"about";


@interface FPAboutController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation FPAboutController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"关于";
  self.view.backgroundColor = kFakePageMainColor;
  [self.view addSubview:self.tableView];
  [self.tableView addSubview:self.label];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.row == 0) {
    return 100;
  }else{
    return 42;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  FPAboutCell *cell = [FPAboutCell cellWithTableView:tableView];
  
  if (indexPath.row == 0) {
    cell.nameLabel.text = @"     为你提供一个最全最好的实用查询工具,服务工具。包过手机号码归属地查询，身份证查询，IP地址查询，邮编查询，违章查询，银行卡查询等~全部都是常用的查询和经常使用到的功能~欢迎大家使用";
  } else if (indexPath.row == 1) {
    
    cell.nameLabel.text = @"版本信息:V1.1.0";
  }
  
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  return 200;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, 200)];
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kUIScreenWidth/2-70/2, 50, 70, 70)];
  imageView.image = [UIImage imageNamed:@"My_about"];

  imageView.layer.cornerRadius = 12;
  imageView.layer.masksToBounds = YES;
  
  
  UILabel *about = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, kUIScreenWidth, 21)];
  about.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
  about.textAlignment = NSTextAlignmentCenter;
  about.font = [UIFont systemFontOfSize:14];
  about.text = @"查询必备选择";
  
  [header addSubview:imageView];
  [header addSubview:about];
  return header;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
  cell.separatorInset = UIEdgeInsetsZero;
  cell.layoutMargins = UIEdgeInsetsZero;
  cell.preservesSuperviewLayoutMargins = NO;
}

#pragma mark - lazy load
-(UITableView *)tableView{
  if (!_tableView) {
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    table.backgroundColor = kFakePageMainColor;
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [[UIView alloc] init];
    _tableView = table;
  }
  return _tableView;
}

-(UILabel *)label{
  if (!_label) {
    UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(0, kUIScreenHeight-64-50, kUIScreenWidth, 20)];
    version.font = [UIFont systemFontOfSize:12];
    version.textColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1];
    version.textAlignment = NSTextAlignmentCenter;
    version.text = @"Copyright@2017-2018 QTC All Rights Reserved";
    _label = version;
  }
  return _label;
}
@end
