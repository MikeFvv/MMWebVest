//
//  FPAboutController.m
//  MInfoQuery
//
//  Created by Mike on 2017/8/14.
//  Copyright © 2017年 dodremteam. All rights reserved.
//
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height//获取设备高度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width//获取设备宽度
#define MAX_LIMIT_NUMS     200

#import "FPFeedbackViewController.h"



//#define kViewMargin 15

@interface FPFeedbackViewController ()<UITextViewDelegate, LQPhotoPickerViewDelegate>{
    
    NSString *myText;
    NSString *myContact;
}

// 联系方式
@property (strong, nonatomic) UITextField *phoneTF;
@property (strong, nonatomic) UITextView *txView;

@property (strong, nonatomic) UILabel *textNumberLabel;


@end

@implementation FPFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"反馈";
    
    self.hcView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kUINavHeight)];
    self.hcView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_hcView];
    
    //添加联系方式
    [self addContactInformation];
    
    // 添加输入内容
    [self addContentTextView];
    
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitRightBtn)];
    rightBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
    //收起键盘
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    self.LQPhotoPicker_superView = _hcView;
    self.txView.layer.borderColor = [[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0] CGColor];
    self.txView.layer.borderWidth = 1;
    self.recordView = [LVRecordView recordView];
    [self.view addSubview: self.recordView];
    self.recordView.frame = CGRectMake(0, kUIScreenHeight-150, kUIScreenWidth, 150);
//    self.recordView.backgroundColor = [UIColor redColor];
    self.LQPhotoPicker_imgMaxCount = 1;
    
    [self LQPhotoPicker_initPickerView];
    [self LQPhotoPicker_updatePickerViewFrameY:200];
    
    self.LQPhotoPicker_delegate = self;
}



///添加联系方式
-(void)addContactInformation {
    
    _phoneTF = [[UITextField alloc] init];
    _phoneTF.font = [UIFont systemFontOfSize:14.f];
    _phoneTF.placeholder = @"您的联系方式(手机号)";
    _phoneTF.keyboardType = UIKeyboardTypeTwitter;
    _phoneTF.borderStyle = UITextBorderStyleRoundedRect;
//    _phoneTF.delegate = self;
    [self.hcView addSubview:_phoneTF];
    
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.hcView.mas_top).offset(10);
        make.left.mas_equalTo(self.hcView.mas_left).offset(kViewMargin);
        make.right.mas_equalTo(self.hcView.mas_right).offset(-kViewMargin);
        make.height.mas_equalTo(30);
    }];
    
}


/// 添加内容
-(void)addContentTextView {
    
    
    UILabel *contentTitleLabel = [[UILabel alloc] init];
    contentTitleLabel.text = @"内容";
    contentTitleLabel.font = [UIFont systemFontOfSize:14];
    [self.hcView addSubview:contentTitleLabel];
    
    [contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTF.mas_bottom).offset(20);
        make.left.mas_equalTo(self.hcView.mas_left).offset(kViewMargin);
    }];
    
    
    self.txView = [[UITextView alloc] init];
    self.txView.delegate = self;
    [self.hcView addSubview:self.txView];
    
    [self.txView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentTitleLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(self.hcView.mas_left).offset(kViewMargin);
        make.size.mas_equalTo(CGSizeMake(kUIScreenWidth - kViewMargin * 2, 70));
    }];
    
    
    UILabel *textNumberLabel = [[UILabel alloc] init];
    textNumberLabel.text = @"0/200";
    textNumberLabel.font = [UIFont systemFontOfSize:12];
    textNumberLabel.textColor = [UIColor blackColor];
    [self.hcView addSubview:textNumberLabel];
    _textNumberLabel = textNumberLabel;
    
    [textNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.txView.mas_bottom).offset(5);
        make.right.mas_equalTo(self.txView.mas_right);
    }];
    
    
}





- (void)viewTapped{
    [self.view endEditing:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < MAX_LIMIT_NUMS) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx++;
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            self.textNumberLabel.text = [NSString stringWithFormat:@"%d/%ld",0,(long)MAX_LIMIT_NUMS];
        }
        return NO;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
    
    //不让显示负数 口口日
    self.textNumberLabel.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 提交
- (void)submitRightBtn {
    if (![self checkInput]) {
        return;
    }
    
    [self submitToServer];
}


- (BOOL)checkInput{
    if (_phoneTF.text.length == 0) {
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入您的联系方式" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:alertAction];
        [self presentViewController:alertC animated:YES completion:nil];
       
        myContact = @"";
        return NO;
    } else if (_txView.text.length == 0) {
        
        UIAlertController *alertLength = [UIAlertController alertControllerWithTitle:@"提示" message:@"你输入的内容信息为空，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *suer = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alertLength addAction:suer];
        [self presentViewController:alertLength animated:YES completion:nil];
        
        myText = @"";
    } else {
        
        myContact = _phoneTF.text;
        myText = _txView.text;
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认提交!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *album = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            [self confirm];
            
        }];
        
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:album];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    return YES;
}



#pragma mark - 上传数据到服务器前将图片转data（上传服务器用form表单：未写）
- (void)submitToServer{
    
    NSMutableArray *bigImageArray = [self LQPhotoPicker_getBigImageArray];
    //大图数据
    NSMutableArray *bigImageDataArray = [self LQPhotoPicker_getBigImageDataArray];
    
    //小图数组
    NSMutableArray *smallImageArray = [self LQPhotoPicker_getSmallImageArray];
    
    //小图数据
    NSMutableArray *smallImageDataArray = [self LQPhotoPicker_getSmallDataImageArray];
    NSLog(@"%@++%@", _phoneTF.text,_txView.text);
    NSData *imgData = nil;
    if (bigImageArray.count == 0) {
    }else{
        imgData = bigImageDataArray[0];
    }
    
    NSString *recoStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"rPath"];
    NSData *voiceData = [NSData dataWithContentsOfFile: recoStr];
    
    NSString *url = @"https://www.pigo-tech.com/feedback/postFeedback.php";
    
    NSLog(@"录音文件地址%@",recoStr);
    NSString *voiceN = [NSString stringWithFormat:@"voice%@",[self getCurrentTimestamp]];
    NSString *imgN = [NSString stringWithFormat:@"image%@",[self getCurrentTimestamp]];
    
    
}



#pragma mark - 提交 确认
- (void)confirm {
    
    [self showLoadingViewWithText:@"正在提交.."];
    
    
    double delayInSeconds = 2.0;
    __weak __typeof(self)weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [weakSelf urationAction];
        
    });
    
}



- (void)urationAction {
    
    [self hidenLoadingView];
    
    [self showHint:@"提交成功"];
    
    // 确认以后清除内容
    self.txView.text = nil;
    self.textNumberLabel.text = @"0/200";
    
    self.phoneTF.text = nil;
    
    
}


//获取当前时间的时间戳
-(NSString*)getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}



@end






