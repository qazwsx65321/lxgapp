//
//  Ocean_TextViewCell.h
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/9/12.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ocean_TextViewCell : UITableViewCell

@property (nonatomic,copy) NSString *XD_title;
@property (nonatomic,copy) NSString *XD_placehodel;
@property (nonatomic,copy) NSString *XD_chooseTitle;

@property (nonatomic,strong) UITextField *textView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
