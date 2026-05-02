//
//  Ocean_FirstPageFunctionCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FirstPageFunctionCell.h"
#import "Ocean_FirstFunCell.h"
@interface Ocean_FirstPageFunctionCell()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

{
    UIPageControl *page;
    NSInteger itemNum;
}

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,weak) UICollectionView * p_collectionView;

@property (nonatomic,strong) NSMutableArray * p_InfoArr;



@end

@implementation Ocean_FirstPageFunctionCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat SW =  screen_Width * 160/404;
        self.backgroundColor  = [UIColor whiteColor];
        page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, SW +20, screen_Width, 20)];
        page.currentPage = 0;
        page.userInteractionEnabled = NO;
        page.currentPageIndicatorTintColor = [UIColor blackColor];
        page.pageIndicatorTintColor = RGB(205, 223, 244);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(screen_Width, screen_Width * 155/404 +45);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, flowLayout.itemSize.width, flowLayout.itemSize.height) collectionViewLayout:flowLayout];
        collectView.delegate = self;
        collectView.backgroundColor = [UIColor whiteColor];
        collectView.dataSource = self;
        collectView.pagingEnabled  = YES;
        self.p_collectionView = collectView;
        collectView.showsHorizontalScrollIndicator = NO;
        [collectView registerClass:[Ocean_FirstFunCell class] forCellWithReuseIdentifier:@"Ocean_FirstFunCell"];
        [self.contentView addSubview:collectView];
        [self.contentView addSubview:page];

    }
    return self;
}

-(void)setM_groupButtons:(NSArray *)m_groupButtons{
    if (_m_groupButtons != m_groupButtons) {
        _m_groupButtons = m_groupButtons;
        NSUInteger section = (m_groupButtons.count +7)/8;
        NSUInteger left = m_groupButtons.count %8;
        NSMutableArray *sectionArr = [NSMutableArray array];
        for (int i = 0; i<section; i++) {
            if (i ==section-1) {
                NSArray *arr;
                if (left == 0) {
                    arr = [m_groupButtons subarrayWithRange:NSMakeRange(i*8, 8)];
                }else{
                    arr = [m_groupButtons subarrayWithRange:NSMakeRange(i*8, left)];
                }
                [sectionArr addObject:arr];
                break;
            }
            NSArray *arr = [m_groupButtons subarrayWithRange:NSMakeRange(i*8, 8)];
            [sectionArr addObject:arr];
        }
        self.p_InfoArr = sectionArr;
        page.numberOfPages = sectionArr.count ==1 ?0:sectionArr.count;
        [self.p_collectionView reloadData];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.p_InfoArr.count;

}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Ocean_FirstFunCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Ocean_FirstFunCell" forIndexPath:indexPath];
    cell.m_buttonItems = self.p_InfoArr[indexPath.row];
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    page.currentPage = (NSUInteger)(offset.x / screen_Width +0.5);
}




-(void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    page.centerY = self.height - 25/2;
}



@end
