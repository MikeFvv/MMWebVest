//
//  FPSetViewCell.m
//  MInfoQuery
//
//  Created by Mike on 2017/8/13.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "FPSetViewCell.h"

static NSString *ID = @"FPSetViewCell";

@interface FPSetViewCell()


//
@property (nonatomic, strong) UILabel *detailedLabel;

//
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation FPSetViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}




+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    FPSetViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
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



- (void)setIsLastCell:(BOOL)isLastCell {
    _isLastCell = isLastCell;
    // 最后一个Cell
    //    if (self.isLastCell) {
    //        self.bottomLineView.hidden = YES;
    //    } else {
    //        self.bottomLineView.hidden = NO;
    //    }
}





- (void)initView {
    
    UIImageView *imagView = [[UIImageView alloc] init];
    imagView.image = [UIImage imageNamed:@"po_check_n"];
    
    [self addSubview:imagView];
    _imagView = imagView;
    
    
    [imagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(30);
    }];
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"Item";
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor darkGrayColor];
    nameLabel.numberOfLines = 1;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(imagView.mas_right).offset(10);
    }];
    
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@"fp_jiantou.png"];
    [self addSubview:iconView];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    // 详细
    UILabel *detailedLabel = [[UILabel alloc] init];
    //    detailedLabel.text = @"";
    detailedLabel.font = [UIFont systemFontOfSize:12];
    detailedLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:detailedLabel];
    _detailedLabel = detailedLabel;
    
    [detailedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imagView.mas_left).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    
    // 底线条
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomLineView];
    _bottomLineView = bottomLineView;
    
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(0.7);
    }];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.isLastCell) {
        [self.bottomLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(0);
        }];
    } else {
        [self.bottomLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(12);
        }];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end







