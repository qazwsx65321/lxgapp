//
//  Ocean_BankCardTypeCell.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/30.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ocean_BankCardTypeCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
-(void)setBaseDic:(NSDictionary *)infoDic andCardMessage:(NSString *)message;
@end
