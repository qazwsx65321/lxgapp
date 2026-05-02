//
//  WP_PickView.h
//  WorkToDoClient_Preson
//
//  Created by qiushi on 16/5/26.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    WPP_PickViewCancelBtnType,
    WPP_PickViewSureBtnType

}WPP_PickViewBtnType;

@protocol WPP_PickViewDelegate <NSObject>

-(void)chooseIndexForm:(UIPickerView *)pickView;

@end

@interface WPP_PickView : UIView

-(void)showListView;
-(void)dismissListView;

@property(nonatomic,strong)NSArray * infoArr;

@property(nonatomic,copy)NSString *titleName;

@property(nonatomic,weak)id<WPP_PickViewDelegate>delegate;

@end
