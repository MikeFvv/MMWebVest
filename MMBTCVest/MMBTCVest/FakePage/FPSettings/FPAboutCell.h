//
//  FPAboutCell.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/14.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPAboutCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
