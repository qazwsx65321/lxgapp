//
//  Ocean_WithDetailCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/23.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_WithDetailCell.h"

@implementation Ocean_WithDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_WithDetailCell";
    Ocean_WithDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_WithDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.textAlignment = NSTextAlignmentRight;
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.x = 15;
    self.textLabel.height = 15;
    self.textLabel.centerY = self.height/2;
    
    self.detailTextLabel.right = self.width -10;
    self.detailTextLabel.centerY = self.height/2;
    
    
}

@end
