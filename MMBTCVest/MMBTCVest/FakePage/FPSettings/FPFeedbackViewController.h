//
//  FPAboutController.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/14.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQPhotoPickerViewController.h"
#import "LVRecordView.h"


@interface FPFeedbackViewController : LQPhotoPickerViewController<UITextViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UIView *hcView;

@property (nonatomic, strong) LVRecordView *recordView;
@end
