//
//  Ocean_XDConversationController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/22.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_XDConversationController.h"

#import "Ocean_XDMessageCell.h"

#import "Ocean_XDMessage.h"

@interface Ocean_XDConversationController ()


@end

@implementation Ocean_XDConversationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerClass:[Ocean_XDMessageCell class] forMessageClass:[Ocean_XDMessage class]];
    
    
}


//
//- (RCMessageBaseCell *)rcConversationCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    RCMessageModel *model = self.conversationDataRepository[indexPath.row];
//    NSString * cellIndentifier = @"Ocean_XDMessageCell";
//    
//    RCMessageBaseCell *cell;
//
//    [cell setDataModel:model];
//    return cell;
//}
////
//
//-(CGSize)rcConversationCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    //返回自定义cell的实际高度（这里请返回消息的实际大小）
//    return CGSizeMake(300, 60);
//}


@end
