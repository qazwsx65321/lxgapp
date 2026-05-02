//
//  RegistCell.h
//  XDMultipointLogistics
//
//  Created by 陈志伟 on 17/7/14.
//  Copyright © 2017年 轩瑞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegistCellDelegate <NSObject>

-(void)clickButtonPostCode:(UIButton *)sender;

//20220418 add
-(void)OpenUserAgreeMent;

@end

@interface RegistCell : UITableViewCell

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,assign) BOOL isShehui;

@property (nonatomic,strong) UITextField *textFiled;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,weak) id<RegistCellDelegate>delegate;

@end
