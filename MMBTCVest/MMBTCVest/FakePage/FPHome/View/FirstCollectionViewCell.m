//
//  FirstCollectionViewCell.m
//  WisdomCarShop
//
//  Created by Mike on 17/6/2.
//  Copyright © 2017年 赖文辉. All rights reserved.
//

#import "FirstCollectionViewCell.h"




@interface FirstCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imagView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FirstCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5.0f;
    self.clipsToBounds = YES;
    
    
    
    _imagView = [[UIImageView alloc] init];
    // 图片做等比例放大、超出部分裁剪、居中处理
    _imagView.contentMode = UIViewContentModeScaleAspectFill;
    _imagView.clipsToBounds = YES;  // 超出边框的内容都剪掉
    
    [self addSubview:_imagView];
    
    // 图标宽高
    CGFloat widthHeight = kUIScreenHeight_Scale_iPhone6(60);
    
    [_imagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(kUIScreenWidth_Scale_iPhone6(10));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(widthHeight);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font =  [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor darkGrayColor];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_imagView.mas_right).offset(kUIScreenWidth_Scale_iPhone6(8));
        make.centerY.mas_equalTo(_imagView.mas_centerY);
        make.width.mas_equalTo(self.frame.size.width - (widthHeight + kUIScreenWidth_Scale_iPhone6(9) *3));
    }];
    
}



- (void)setDict:(NSDictionary *)dict {
    _dict = dict;
    self.titleLabel.text = dict[@"title"];
    
    
    NSNumber *roleState = dict[@"roleState"];
    
    // 没有权限做灰色处理
    if (roleState.integerValue != 1) {
        self.imagView.image = [UIImage imageNamed:dict[@"image_u"]];
        
        self.titleLabel.textColor = HEX_RGB(0x898989);

    } else {
        
        self.imagView.image = [UIImage imageNamed:dict[@"image"]];
        self.titleLabel.textColor = [UIColor darkGrayColor];
    }
}



@end

