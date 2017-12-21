//
//  FirstContentViewCell.h
//  WisdomCarShop
//
//  Created by Mike on 17/6/2.
//  Copyright © 2017年 赖文辉. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface FirstContentViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataArray;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
