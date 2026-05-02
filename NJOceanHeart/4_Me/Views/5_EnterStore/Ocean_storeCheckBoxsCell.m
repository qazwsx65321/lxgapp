//
//  Ocean_storeCheckBoxsCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/4.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_storeCheckBoxsCell.h"
#import "Ocean_EnterStoreModel.h"

@interface Ocean_storeCheckBoxsCell()
{
    UIButton *lastButton;
}

@property (nonatomic,strong) NSString * p_proName;

@property (nonatomic,strong) NSMutableArray * p_buttonArr;

@end

@implementation Ocean_storeCheckBoxsCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_storeCheckBoxsCell";
    Ocean_storeCheckBoxsCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_storeCheckBoxsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
        _p_buttonArr = [NSMutableArray array];
        for (int i =0; i<3; i++) {
            UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"check"] forState:0];
            [button setImage:[UIImage imageNamed:@"check_pre"] forState:UIControlStateSelected];
            button.size = CGSizeMake(70, 25);
            button.tag = 100+i;
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [button setTitleColor:[UIColor blackColor] forState:0];
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [_p_buttonArr addObject:button];
            [self.contentView addSubview:button];
        }
        
    }
    return self;
}

-(void)setP_accInfo:(NSDictionary *)p_accInfo{
    _p_accInfo = p_accInfo;
    self.textLabel.text = p_accInfo[@"title"];
    NSArray *arr =  p_accInfo[@"buttons"];
    for (int i =0 ; i<3; i++) {
        UIButton *btn = self.p_buttonArr[i];
        NSDictionary *buttoninfo = arr[i];
        btn.hidden =  [buttoninfo[@"show"] integerValue];
        [btn setTitle:buttoninfo[@"title"] forState:0];
    }
    self.p_proName = p_accInfo[@"propertyName"];
}

-(void)setModel:(Ocean_EnterStoreModel *)model{
    _model =model;
//    m_cerType  m_storeType
    NSString *type = [model valueForKey:self.p_proName];
    for (UIButton *button in self.p_buttonArr) {
        button.selected  =NO;
    }
    UIButton *button = [self.contentView viewWithTag:[type integerValue]];
    lastButton  = button;
    button.selected = YES;
}

-(void)click:(UIButton *)sender{
    NSUInteger tag = sender.tag;
    lastButton.selected = NO;
    lastButton = sender;
    sender.selected = YES;
    [self.model setValue:[NSString stringWithFormat:@"%ld",tag] forKey:self.p_proName];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.x = 10;
    [self.textLabel sizeToFit];
    self.textLabel.centerY = self.height/2;
    CGFloat buttonX = self.textLabel.right +10;
    CGFloat buttonCentY = self.textLabel.centerY;
    for (int i = 0; i< 3; i++) {
        UIButton *btn = self.p_buttonArr[i];
        btn.x = buttonX + i *(10 + btn.width);
        btn.centerY = buttonCentY;
    }
    
    
    
}


@end
