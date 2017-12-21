//
//  FPSetViewCell.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/13.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPSetViewCell : UITableViewCell


//
@property (nonatomic, strong) UIImageView *imagView;
//
@property (nonatomic, strong) UILabel *nameLabel;
// 是否最后一个Cell
@property (nonatomic, assign) BOOL isLastCell;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
