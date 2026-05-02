//
//  Ocean_BankCardTypeCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/30.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_BankCardTypeCell.h"

@implementation Ocean_BankCardTypeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_BankCardTypeCell";
    Ocean_BankCardTypeCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_BankCardTypeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        
        
    }
    return self;
}


-(void)setBaseDic:(NSDictionary *)infoDic andCardMessage:(NSString *)message{

    self.textLabel.text = infoDic[@"title"];
    self.detailTextLabel.text = message;
    

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.x = 10;
    self.textLabel.centerY = self.contentView.height/2;
    
    self.detailTextLabel.x = self.textLabel.right + 10;
    self.detailTextLabel.width = self.contentView.width - self.detailTextLabel.x;
    self.detailTextLabel.height = 20;
    self.detailTextLabel.centerY = self.textLabel.centerY;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
