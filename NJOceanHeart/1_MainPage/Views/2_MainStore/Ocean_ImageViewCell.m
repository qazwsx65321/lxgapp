//
//  Ocean_ImageViewCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/28.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ImageViewCell.h"

@interface Ocean_ImageViewCell()

@property (nonatomic,assign) UIEdgeInsets imageInsets;

@end


@implementation Ocean_ImageViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andImageInsets:(UIEdgeInsets)imageInset
{
    static NSString *cellsign = @"Ocean_ImageViewCell";
    Ocean_ImageViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_ImageViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.imageInsets = imageInset;
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


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(self.imageInsets.left, self.imageInsets.top, self.width -self.imageInsets.left-self.imageInsets.right ,self.height -self.imageInsets.top - self.imageInsets.bottom);
    
}
@end
