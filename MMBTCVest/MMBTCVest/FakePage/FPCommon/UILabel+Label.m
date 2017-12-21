//
//  UILabel+Label.m
//  WheelTime
//
//  Created by 赖文辉 on 16/5/10.
//  Copyright © 2016年 微微. All rights reserved.
//

#import "UILabel+Label.h"

@implementation UILabel (Label)
+ (UILabel *)labelWithText:(NSString *)text
              withFontSize:(CGFloat)size
                 withColor:(UIColor *)color{
    
    UILabel *label = [[UILabel alloc] init];
    label.text =  text;
    
    if (color) {
        label.textColor = color;
    }
    if (size) {
        label.font = [UIFont systemFontOfSize:size];
    }
    
    return label;
    
}

@end
