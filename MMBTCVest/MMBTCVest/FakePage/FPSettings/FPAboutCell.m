//
//  FPAboutCell.m
//  MInfoQuery
//
//  Created by Mike on 2017/8/14.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "FPAboutCell.h"



static NSString *ID = @"FPAboutCell";

@interface FPAboutCell()


//
@property (nonatomic, strong) UILabel *detailedLabel;

//
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation FPAboutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}




+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    FPAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = kFakePageMainColor;
    // cell 被选中时的风格
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}




- (void)initView {

    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"Item";
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor =  [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];;
    nameLabel.numberOfLines = 0;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
    }];

    
    
    // 底线条
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomLineView];
    _bottomLineView = bottomLineView;
    
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.mas_left).offset(12);
        make.bottom.right.left.mas_equalTo(0);
        make.height.mas_equalTo(0.7);
    }];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end








