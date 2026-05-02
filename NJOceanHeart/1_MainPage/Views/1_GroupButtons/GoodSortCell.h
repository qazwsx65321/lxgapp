//
//  GoodSortCell.h
//  NinthTribe-O
//
//  Created by 史伟文 on 2017/4/2.
//  Copyright © 2017年 NanJing. All rights reserved.
//

typedef enum {
    
    GoodSortTypeDefault,
    GoodSortTypeSVolume,
    GoodSortTypePrice,
    GoodSortTypeTime
    
}GoodSortType;

#import <UIKit/UIKit.h>

@protocol GoodSortDelegate <NSObject>

- (void)didSelectSegmentAtIndex:(GoodSortType)sortType increase:(BOOL)increase;

@end

@interface GoodSortCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, assign)id<GoodSortDelegate>delegate;

@end
