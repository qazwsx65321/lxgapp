//
//  WP_PickView.h
//  WorkToDoClient_Preson
//
//  Created by qiushi on 16/5/26.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    WP_PickViewCancelBtnType,
    WP_PickViewSureBtnType
}WP_PickViewBtnType;

typedef void (^ReturnTextBlock)(NSDate *date);

@interface WP_PickView : UIView

-(void)showListViewandReturn:(ReturnTextBlock)returnTextBlock;
-(void)dismissListView;

@property(nonatomic,strong)NSMutableArray * titleArray;

@property(nonatomic,copy)NSString *titleName;

@property(nonatomic,strong)UIDatePicker *p_pickView;

@end
