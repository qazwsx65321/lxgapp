//
//  Ocean_ GoodsStandardCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/16.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_GoodsStandardCell.h"
#import "JCTagListView.h"
#import "GoodDetailBody.h"
@interface Ocean_GoodsStandardCell()

@property (nonatomic, strong)JCTagListView *tagListView;


@end

@implementation Ocean_GoodsStandardCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_GoodsStandardCell";
    Ocean_GoodsStandardCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_GoodsStandardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
            _tagListView = [[JCTagListView alloc] init];
            _tagListView.canSelectTags = YES;
            _tagListView.tagSelectedTextColor = [UIColor whiteColor];
            _tagListView.tagCornerRadius = 5.0f;
            [self.contentView addSubview:_tagListView];
        
        
    }
    return self;
}

-(void)setGoodDetail:(GoodDetailRespBody *)goodDetail{

    if (_goodDetail !=goodDetail) {
        
        _goodDetail = goodDetail;
        NSMutableArray *tags = [NSMutableArray array];
        for (GoodSpecModel *spec in _goodDetail.list1) {
            [tags addObject:spec.m_title];
        }    
        JCCollectionViewTagFlowLayout *layout =  (JCCollectionViewTagFlowLayout*)_tagListView.collectionView.collectionViewLayout;
       CGFloat H =  [layout calculateContentHeight:tags];
        [self.delegate standardCellGetstandardNum:H];
        _tagListView.tags = tags;
        __weak typeof(self) weakSelf = self;
        [_tagListView setCompletionBlockWithSelected:^(NSInteger index) {
            
            [weakSelf.delegate StandardCellInfoDidSelectedItem:goodDetail.list1[index]];
            
        }];
    

    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _tagListView.frame = self.bounds;
}

@end
