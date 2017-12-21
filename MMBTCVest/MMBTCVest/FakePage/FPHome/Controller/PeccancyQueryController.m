//
//  PeccancyQueryController.m
//  WheelTime
//
//  Created by Mike on 16/5/16.
//  Copyright © 2016年 微微. All rights reserved.
//

#import "PeccancyQueryController.h"
#import "UILabel+Label.h"
#import "UIViewController+HUD.h"



// 违章查询-微车  http://light.weiche.me/#&index

// 后面找的
#define WeicheUrl @"http://m2.weizhang8.cn"


@interface PeccancyQueryController()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIView *tipView;


@end

@implementation PeccancyQueryController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initWebView];
    
}


- (void)initWebView {
    
    self.title = @"违章查询";
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kUINavHeight)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    UIView *view = [[UIView alloc] init];
    view.hidden = YES;
    [self.view addSubview:view];
    self.tipView = view;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@"Illegal"];
    [view addSubview:iconView];
    
    
    
    UILabel *tipLabel = [UILabel labelWithText:@"页面加载失败，请重试" withFontSize:14 withColor: HEX_RGB(0x535353)];
    
    
    [view addSubview:tipLabel];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadView)];
    [view addGestureRecognizer:tapGesture];
    

    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(190);
        
    }];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(view.mas_top);
        make.centerX.mas_equalTo(view.mas_centerX);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(160);
        
    }];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(view.mas_bottom);
        make.centerX.mas_equalTo(view.mas_centerX);
        
    }];
    
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:WeicheUrl]];
    [self.webView loadRequest:request];
    
}

- (void)reloadView {
    
    self.tipView.hidden = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:WeicheUrl]];
    [self.webView loadRequest:request];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self showLoadingView];
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hidenLoadingView];
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self hidenLoadingView];
    self.tipView.hidden = NO;
//    [self showHint:@"加载失败"];
    
}

@end




