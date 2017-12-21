//
//  UILabel+Label.h
//  WheelTime
//
//  Created by 赖文辉 on 16/5/10.
//  Copyright © 2016年 微微. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Label)

/**
 *	快速添加Label
 *
 *	@param text	标题
 *	@param size	字体大小
 *	@param color 颜色
 *
 *	@return 生成的Label
 */
+ (UILabel *)labelWithText:(NSString *)text
              withFontSize:(CGFloat)size
                 withColor:(UIColor *)color;

@end
