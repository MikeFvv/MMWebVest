//
//  PostcodeCell.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/12.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostcodeContentModel;
@interface PostcodeCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

//
@property (nonatomic, strong) PostcodeContentModel *model;

@end
