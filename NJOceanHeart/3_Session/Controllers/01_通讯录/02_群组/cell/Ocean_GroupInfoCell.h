//
//  Ocean_GroupInfoCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/18.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_GroupMemberModel;
@interface Ocean_GroupInfoCell : UICollectionViewCell

@property (nonatomic,copy) NSString *picName;
@property (nonatomic,strong) Ocean_GroupMemberModel *model;

@end
