//
//  Ocean_UploadCerCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/30.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_UploadCerCell.h"
#import "Ocean_EnterStoreModel.h"

@implementation Ocean_UploadCerCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_UploadCerCell";
    Ocean_UploadCerCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_UploadCerCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.numberOfLines = 0;
        self.detailTextLabel.textColor = RGB(208, 208, 208);
        
    }
    return self;
}

-(void)setP_accInfo:(NSDictionary *)p_accInfo{
    _p_accInfo = p_accInfo;
    self.textLabel.text = p_accInfo[@"title"];
    //    self.m_tf.placeholder = p_accInfo[@"des"];
    self.detailTextLabel.text = p_accInfo[@"des"];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.textLabel sizeToFit];
    self.textLabel.x = 10;
    self.textLabel.centerY = self.height/2;
    
    self.detailTextLabel.x = self.textLabel.right +10;
    self.detailTextLabel.width = self.width - self.detailTextLabel.x -5;
    [self.detailTextLabel sizeToFit];
    self.detailTextLabel.centerY = self.height/2;
    
    
}
@end
