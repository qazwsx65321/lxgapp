//
//  Ocean_GroupInfoCell2.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/18.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ocean_GroupInfoCell2;
@protocol Ocean_GroupInfoCell2Delegate <NSObject>

- (void)quitGroup:(Ocean_GroupInfoCell2 *)cell;

@end

@interface Ocean_GroupInfoCell2 : UICollectionViewCell

@property (nonatomic,assign) id<Ocean_GroupInfoCell2Delegate>delegate;

@property (nonatomic,assign) BOOL isManager;

@end
