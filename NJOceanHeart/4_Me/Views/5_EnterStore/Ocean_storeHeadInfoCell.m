//
//  Ocean_storeHeadInfoCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_storeHeadInfoCell.h"

@implementation Ocean_storeHeadInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_storeHeadInfoCell";
    Ocean_storeHeadInfoCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_storeHeadInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = RGB(249, 249, 249);
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.y = self.height/2;
    self.contentView.height = self.height/2;
    
    self.imageView.x = 10;
    [self.imageView sizeToFit];
    self.imageView.centerY = 0;
    
    self.separatorInset = UIEdgeInsetsMake(0, screen_Width, 0, 0);

}

@end
