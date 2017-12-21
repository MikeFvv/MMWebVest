//
//  PostcodeQueryController.m
//  MInfoQuery
//
//  Created by Mike on 2017/8/11.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "PostcodeQueryController.h"
#import "PostcodeModels.h"
#import "PostcodeContentModel.h"
#import "PostcodeCell.h"



@interface PostcodeQueryController ()<UITableViewDataSource, UITabBarDelegate>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

// 刷新
@property (nonatomic, strong) MJRefreshAutoNormalFooter *footer;
@property (nonatomic, assign) NSInteger pageIndex;


// 查询输入框
@property (nonatomic, strong) UITextField *queryTextField;
// 查询结果
@property (nonatomic, strong) UILabel *queryResultLabel;
// 上一次的查询值
@property (nonatomic, copy) NSString *saveOldQueryValue;

@end

@implementation PostcodeQueryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self preparUI];
    
    // 上拉刷新
    [self upPullRefreshAction];
}




- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}




#pragma mark - 上拉刷新操作
- (void)upPullRefreshAction {
    
    
    // 初始化 刷新页数下标
    self.pageIndex = 1;
    
    // *** 刷新方法 ***
    __weak typeof(self) weakSelf = self;
    self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [weakSelf footerRefresh];
    }];
    
    self.tableView.mj_footer = self.footer;
    
}




#pragma mark - 初始化 tableView
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,200,kUIScreenWidth,kUIScreenHeight - kUINavHeight - 200) style:UITableViewStylePlain];
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
    
    PostcodeCell *cell = [PostcodeCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}


#pragma mark - UITableView 代理方法
// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}


// 选中某行cell时会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"选中didSelectRowAtIndexPath row = %ld", indexPath.row);
}

#pragma mark - 获取上拉刷新数据
- (void)footerRefresh {
    
    if (self.queryTextField.text == nil || [self.queryTextField.text isEqualToString:@""]) {
        [self showHint:@"请输入待查询的邮政编码"];
        return;
        
    } if (![self.queryTextField.text isValidPostalcode]) {
        [self showHint:@"邮政编码格式不对"];
        return;
    } if ([self.queryTextField.text isEqualToString: self.saveOldQueryValue]) {
        [self showHint:@"已查询"];
        return;
    }
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"43838" forKey:@"showapi_appid"];
    [parameters setValue:@"2b8b3da87db542f4900e4102f93dba6a" forKey:@"showapi_sign"];
    [parameters setValue:self.queryTextField.text forKey:@"zip"];
    [parameters setValue:[NSString stringWithFormat:@"%zd",self.pageIndex]  forKey:@"page"]; // 第几页,默认值1
    
    [self showLoadingView];
    
    NSString *requestUrl = @"http://route.showapi.com/1151-1";
    
    __weak typeof(self) weakSelf = self;
  
  
  BADataEntity *entity = [BADataEntity new];
  entity.urlString = requestUrl;
  entity.needCache = NO;
  entity.parameters = parameters;
  
  [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
    NSLog(@"post请求数据成功： *** %@", response);
    
    [self hidenLoadingView];
    
    CDLog(@"%@",response);
    
    
    PostcodeModels *models = [PostcodeModels mj_objectWithKeyValues:response];
    
    if (models.showapi_res_code == 0) {
      
      weakSelf.pageIndex++;
      // 拿到当前的上拉刷新控件，结束刷新状态
      [weakSelf.tableView.mj_footer endRefreshing];
      [weakSelf.tableView reloadData];
      
      
      [self showHint:@"完成查询"];
      self.saveOldQueryValue = self.queryTextField.text;
      
      PostcodeModel *model = models.showapi_res_body;
      
      
      NSDictionary *dictTemp = ((NSDictionary *)response[@"showapi_res_body"])[@"content"];
      
      NSMutableArray *arrayTemp = [NSMutableArray array];
      [dictTemp enumerateKeysAndObjectsUsingBlock:^(NSString  *_Nonnull key, NSDictionary*  _Nonnull subDic, BOOL * _Nonnull stop) {
        NSMutableDictionary *dicResult = [NSMutableDictionary dictionaryWithDictionary:subDic];
        dicResult[@"Id"] = key;
        [arrayTemp addObject:dicResult];
      }];
      
      
      NSArray *arrayList = [PostcodeContentModel mj_objectArrayWithKeyValuesArray:arrayTemp];
      
      [weakSelf.dataArray addObjectsFromArray: arrayList];
      
      
      PostcodeContentModel *contModel = self.dataArray.firstObject;
      
      self.queryResultLabel.text = [NSString stringWithFormat:@"地址: %@\n\n查询记录数: %@条\n\n",contModel.addr, model.count];
      
      CDLog(@"--->%@", self.dataArray);
      
    } else {
      
      [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
      [self showHint:[NSString stringWithFormat:@"%@", models.showapi_res_error]];
      
    }
  } failureBlock:^(NSError *error) {
    
  } progressBlock:nil];
  
  
    
    
}








#pragma mark - 设置界面
- (void)preparUI {
    
    self.title = @"邮政编码查询";
    
    self.view.backgroundColor = kFakePageMainColor;
    
    
    UITextField *queryTextField = [UITextField new];
    //    queryTextField.backgroundColor = [UIColor blueColor];
    queryTextField.placeholder = @"输入待查询邮编";
    queryTextField.font = [UIFont systemFontOfSize:14];
    queryTextField.clearButtonMode = UITextFieldViewModeAlways;
    queryTextField.borderStyle              = UITextBorderStyleRoundedRect;
    queryTextField.keyboardType             = UIKeyboardTypeDefault;
    // 密码就 YES
    queryTextField.secureTextEntry          = NO;
    queryTextField.textAlignment            = NSTextAlignmentLeft;
    queryTextField.textColor = [UIColor grayColor];
    
    [queryTextField becomeFirstResponder];
    queryTextField.delegate = self;
    queryTextField.frame=CGRectMake(12, 15, kUIScreenWidth - kViewMargin *2 - 66, 42);
    
    [self.view addSubview:queryTextField];
    _queryTextField = queryTextField;
    
    
    
    UIButton *submitButton = [[UIButton alloc] init];
    submitButton.backgroundColor = [UIColor colorWithRed: 0 green: 0.565 blue: 0.576 alpha: 1];
    [submitButton setTitle:@"查询" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    
    //    submitButton.layer.cornerRadius = 5;
    submitButton.frame=CGRectMake(kUIScreenWidth - kViewMargin - 70, 15, 70, 42);
    
    [self.view addSubview:submitButton];
    
    
    UIBezierPath *maskPath= [UIBezierPath bezierPathWithRoundedRect:submitButton.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer=[[CAShapeLayer alloc]init];
    maskLayer.frame=submitButton.bounds;
    maskLayer.path=maskPath.CGPath;
    submitButton.layer.mask=maskLayer;
    
    
    
    UILabel *queryResultTitleLabel = [[UILabel alloc] init];
    queryResultTitleLabel.text = @"查询结果:";
    queryResultTitleLabel.font = [UIFont systemFontOfSize:14];
    queryResultTitleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:queryResultTitleLabel];
    
    [queryResultTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(kViewMargin);
        make.top.mas_equalTo(submitButton.mas_bottom).offset(20);
    }];
    
    
    UILabel *queryResultLabel = [[UILabel alloc] init];
    //    queryResultLabel.text = @"查询结果:";
    queryResultLabel.font = [UIFont systemFontOfSize:15];
    queryResultLabel.textColor = kColorPink;
    queryResultLabel.numberOfLines = 0;
    [self.view addSubview:queryResultLabel];
    _queryResultLabel = queryResultLabel;
    
    [queryResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(queryResultTitleLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(kViewMargin);
        make.right.mas_equalTo(self.view.mas_right).offset(-kViewMargin);
    }];
    
    
    
    
    [self.view addSubview:self.tableView];
    self.tableView.hidden = YES;
    
}

#pragma mark - 提交
- (void)submitClick {
    
    if (self.queryTextField.text == nil || [self.queryTextField.text isEqualToString:@""]) {
        [self showHint:@"请输入待查询的邮政编码"];
        return;
        
    } if (![self.queryTextField.text isValidPostalcode]) {
        [self showHint:@"邮政编码格式不对"];
        return;
    } if ([self.queryTextField.text isEqualToString: self.saveOldQueryValue]) {
        [self showHint:@"已查询"];
        return;
    }
    
    NSDictionary *parameters = @{@"showapi_appid":@"43838",@"showapi_sign":@"2b8b3da87db542f4900e4102f93dba6a", @"zip": self.queryTextField.text, @"page": @"1"};
    
    [self showLoadingView];
    
    NSString *requestUrl = @"http://route.showapi.com/1151-1";
  
  BADataEntity *entity = [BADataEntity new];
  entity.urlString = requestUrl;
  entity.needCache = NO;
  entity.parameters = parameters;
  
  [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
    NSLog(@"post请求数据成功： *** %@", response);
    
    
    [self hidenLoadingView];
    
    CDLog(@"%@",response);
    
    
    PostcodeModels *models = [PostcodeModels mj_objectWithKeyValues:response];
    
    if (models.showapi_res_code == 0) {
      
      [self showHint:@"完成查询"];
      self.saveOldQueryValue = self.queryTextField.text;
      
      PostcodeModel *model = models.showapi_res_body;
      
      
      NSDictionary *dictTemp = ((NSDictionary *)response[@"showapi_res_body"])[@"content"];
      
      NSMutableArray *arrayTemp = [NSMutableArray array];
      [dictTemp enumerateKeysAndObjectsUsingBlock:^(NSString  *_Nonnull key, NSDictionary*  _Nonnull subDic, BOOL * _Nonnull stop) {
        NSMutableDictionary *dicResult = [NSMutableDictionary dictionaryWithDictionary:subDic];
        dicResult[@"Id"] = key;
        [arrayTemp addObject:dicResult];
      }];
      
      //        modelarray
      NSMutableArray *array = [PostcodeContentModel mj_objectArrayWithKeyValuesArray:arrayTemp];
      
      PostcodeContentModel *contModel = array.firstObject;
      
      self.dataArray = [NSMutableArray arrayWithArray:array];
      
      
      self.queryResultLabel.text = [NSString stringWithFormat:@"地址: %@\n\n查询记录数: %@条\n\n",contModel.addr, model.count];
      
      self.tableView.hidden = NO;
      [self.tableView reloadData];
      
      CDLog(@"--->%@", array);
      
    } else {
      
      [self showHint:[NSString stringWithFormat:@"%@", models.showapi_res_error]];
      
    }
  } failureBlock:^(NSError *error) {
    
  } progressBlock:nil];
  
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end








