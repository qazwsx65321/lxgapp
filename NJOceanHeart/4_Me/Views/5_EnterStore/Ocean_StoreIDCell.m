//
//  Ocean_StoreIDCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_StoreIDCell.h"
#import "Ocean_EnterStoreModel.h"
#import "ChooseHeadImageTool.h"
#import "Ocean_imagePickerController.h"
@interface  Ocean_StoreIDCell()<Ocean_imagePickerControllerDelegate>

@property (nonatomic,strong) NSString * p_proName;


@end

@implementation Ocean_StoreIDCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_StoreIDCell";
    Ocean_StoreIDCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_StoreIDCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImage)];
        [self.imageView addGestureRecognizer:tap];
        
    }
    return self;
}

-(void)chooseImage{

    [ChooseHeadImageTool chooseImageFormLibOrAlbum:self.vc Edit:YES  andDelegate:self];

}

-(void)setP_accInfo:(NSDictionary *)p_accInfo{
    _p_accInfo = p_accInfo;
    self.p_proName = self.p_accInfo[@"propertyName"];
    self.imageView.image = [UIImage imageNamed:p_accInfo[@"image"]];
    
}

-(void)setModel:(Ocean_EnterStoreModel *)model{
    _model = model;
    NSData *data = [model valueForKeyPath:self.p_proName];
    if (data) {
        self.imageView.image = [UIImage imageWithData:data];
    }
}

-(void)Ocean_imagePickerControllerdidFinishPickingImageData:(NSData *)imageData{

    [self.model setValue:imageData forKey:self.p_proName];
    self.imageView.image = [UIImage imageWithData:imageData];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
//    560 × 350
    self.imageView.x = 15;
    self.imageView.width = self.width - 2*self.imageView.x;
    self.imageView.height = self.imageView.width *350/560;
    self.imageView.centerY = self.height/2;
    
    self.separatorInset = UIEdgeInsetsMake(0, screen_Width, 0, 0);
}


@end
