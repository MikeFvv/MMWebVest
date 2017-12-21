//
//  PostcodeCell.m
//  MInfoQuery
//
//  Created by Mike on 2017/8/12.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "PostcodeCell.h"
#import "PostcodeContentModel.h"

static NSString *ID = @"PostcodeCell";

@interface PostcodeCell()

// 地址
@property (nonatomic, strong) UILabel *addressLabel;
// 邮编
@property (nonatomic, strong) UILabel *zipCodeLabel;

@end

@implementation PostcodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}




+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    PostcodeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
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


- (void)setModel:(PostcodeContentModel *)model {
    _model = model;
    _addressLabel.text = model.addr;
    _zipCodeLabel.text = model.zip;
}




- (void)initView {
    
    // 地址
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.textColor = kColorPink;
    addressLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:addressLabel];
    _addressLabel = addressLabel;
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(8);
        make.left.mas_equalTo(self.mas_left).offset(12);
    }];
    
    
    UILabel *zipCodeLabel = [[UILabel alloc] init];
    zipCodeLabel.textColor = kColorPink;
    zipCodeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:zipCodeLabel];
    _zipCodeLabel = zipCodeLabel;
    
    [zipCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addressLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.mas_left).offset(12);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end



