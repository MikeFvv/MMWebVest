//
//  FirstContentViewCell.m
//  WisdomCarShop
//
//  Created by Mike on 17/6/2.
//  Copyright © 2017年 赖文辉. All rights reserved.
//

#import "FirstContentViewCell.h"
#import "FirstCollectionViewCell.h"
#import "UIResponder+GXRouter.h"


#define kTopViewHeight kUIScreenHeight_Scale_iPhone6(35)
#define kLineSpacing kUIScreenWidth_Scale_iPhone6(30)



static NSString *ID = @"FirstContentViewCell";
static NSString *idenifer = @"FirstCollectionViewCell";


#define kMarginWidth 10

@interface FirstContentViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLabel;



@end

@implementation FirstContentViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    FirstContentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //    cell.backgroundColor = kMainColor;
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


- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [_collectionView reloadData];
}


- (void)initView {

    self.backgroundColor = kFakePageMainColor;

    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:backView];
    _backView = backView;
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(kUIScreenHeight_Scale_iPhone6(23));
        make.left.mas_equalTo(kHomeViewSpacing);
        make.right.mas_equalTo(-kHomeViewSpacing);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-kUIScreenHeight_Scale_iPhone6(10));
    }];
    
    [self initCollectionView];
}


#pragma mark - 初始化 CollectionView
- (void)initCollectionView {
    
    // UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  使用UICollectionView 必须实现这3个协议
    
    //创建一个layout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局 | 设置滚动方向（默认垂直滚动）
    //    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //设置每个item的大小
    //    layout.itemSize = CGSizeMake(50, 50);
    // 设置最小行间距
    layout.minimumLineSpacing = 10;  // 当前 上下间距
    // 设置垂直间距
    layout.minimumInteritemSpacing = 20;
    
    // 初始化collectionView 创建collectionView 通过一个布局策略layout来创建
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
    collectionView.backgroundColor = [UIColor clearColor];
    //设置不滚动
    collectionView.scrollEnabled = NO;
    //代理设置
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    //注册item类型 这里使用系统的类型 | 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [collectionView registerClass:[FirstCollectionViewCell class] forCellWithReuseIdentifier:idenifer];
    
    [self.backView addSubview:collectionView];
    _collectionView = collectionView;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.and.right.mas_equalTo(0);
    }];
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idenifer forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor redColor];
    cell.dict = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // + 2 因为宽度需要小于 本身计算的， 哪怕一点点
    CGFloat sizeWidth = (kUIScreenWidth - (kHomeViewSpacing * 2 + 2) - 20) / 2;
    return CGSizeMake(sizeWidth, kUIScreenHeight_Scale_iPhone6(110));
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self routerEventWithName:@"HomeContentViewCellClick" userInfo:self.dataArray[indexPath.row]];
    
    // 选中时颜色
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    //选中之后的cell变颜色
    [self updateCellStatus:cell selected:YES];
    
    // 添加延时动画 // 取消选中
    [UIView animateWithDuration:2 animations:^{
        // 取消选中
        [self updateCellStatus:cell selected:NO];
    }];
}


// 取消选中操作
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [self updateCellStatus:cell selected:NO];
}


// 改变cell的背景颜色
-(void)updateCellStatus:(UICollectionViewCell *)cell selected:(BOOL)selected
{
    cell.backgroundColor = selected ? HEX_RGB(0xeeeeee) : [UIColor whiteColor];

}


//返回这个UICollectionView是否可以被选择
// 设置是否允许选中
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

// 设置是否允许取消选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}






- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

