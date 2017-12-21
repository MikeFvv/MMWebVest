//
//  PhoneNumController.m
//  MInfoQuery
//
//  Created by Mike on 2017/8/9.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "PhoneNumController.h"
#import "ResultPhoneModel.h"
#import "ResultPhoneModels.h"


@interface PhoneNumController ()

// 查询输入框
@property (nonatomic, strong) UITextField *queryTextField;
// 查询结果
@property (nonatomic, strong) UILabel *queryResultLabel;
// 上一次的查询值
@property (nonatomic, copy) NSString *saveOldQueryValue;

@end

@implementation PhoneNumController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self preparUI];
    
    
    
}

#pragma mark - 设置界面
- (void)preparUI {
    
    self.title = @"手机归属地查询";
    
    self.view.backgroundColor = kFakePageMainColor;
    
    
    UITextField *queryTextField = [UITextField new];
    //    queryTextField.backgroundColor = [UIColor blueColor];
    queryTextField.placeholder = @"输入待查询的手机号码";
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
    
    //    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(self.view.mas_top).offset(15);
    //        make.right.mas_equalTo(self.view.mas_right).offset(-12);
    //        make.size.mas_equalTo(CGSizeMake(100, 42));
    //    }];
    
    
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
    
}

#pragma mark - 提交
- (void)submitClick {
    
    if (self.queryTextField.text == nil || [self.queryTextField.text isEqualToString:@""]) {
        [self showHint:@"请输入待查询的手机号码"];
        return;
    } if (![self.queryTextField.text isMobileNumber]) {
        [self showHint:@"手机号码格式不对"];
        return;
    } if ([self.queryTextField.text isEqualToString: self.saveOldQueryValue]) {
        [self showHint:@"已查询"];
        return;
    }
    
    NSDictionary *parameters = @{@"showapi_appid":@"43838",@"showapi_sign":@"2b8b3da87db542f4900e4102f93dba6a", @"num": self.queryTextField.text};
    
    NSString *requestUrl = @"http://route.showapi.com/6-1";
    
    [self showLoadingView];
    
  
  
  BADataEntity *entity = [BADataEntity new];
  entity.urlString = requestUrl;
  entity.needCache = NO;
  entity.parameters = parameters;
  
  [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
    NSLog(@"post请求数据成功： *** %@", response);
    
    [self hidenLoadingView];
    
    CDLog(@"%@",response);
    
    ResultPhoneModels *models = [ResultPhoneModels mj_objectWithKeyValues:response];
    
    if (models.showapi_res_code == 0) {
      [self showHint:@"完成查询"];
      
      self.saveOldQueryValue = self.queryTextField.text;
      
      ResultPhoneModel *model = models.showapi_res_body;
      
      self.queryResultLabel.text = [NSString stringWithFormat:@"运营商: %@\n\n归属地: %@省 %@\n\n省份编码: %@\n\n城市编码: %@\n\n城市区号: %@", model.name, model.prov, model.city,model.provCode,model.cityCode, model.areaCode];
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







