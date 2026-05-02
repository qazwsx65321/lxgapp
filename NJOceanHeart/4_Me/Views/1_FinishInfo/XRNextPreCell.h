//
//  XRNextPreCell.h
//  OwnerPort
//
//  Created by qiushi on 2017/4/5.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XRNextPreCellDelegate <NSObject>

-(void)clickNextbutton;

@end

@interface XRNextPreCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,weak)id<XRNextPreCellDelegate>delegate;
@property(nonatomic,weak)UIButton *p_nextButton;
@property(nonatomic,strong)NSString *nextTitle;
@end
