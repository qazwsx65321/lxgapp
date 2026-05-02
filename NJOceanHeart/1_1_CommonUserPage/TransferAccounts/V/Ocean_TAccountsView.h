//
//  Ocean_TAccountsView.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/16.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Ocean_TAccountsViewDelegate <NSObject>

-(void)Ocean_TAccountsViewClickTransferAccount:(NSString *)money;

@end

@interface Ocean_TAccountsView : UIView

@property (nonatomic,weak) id<Ocean_TAccountsViewDelegate>delegate;

-(void)setFriendPic:(NSString *)headPic andNickName:(NSString *)nickName;

@end
