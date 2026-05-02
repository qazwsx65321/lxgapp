//
//  Ocean_ StoreIntroduceCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_StoreIntroduceCell.h"
#import "XDTextView.h"
#import "Ocean_EnterStoreModel.h"

@interface Ocean_StoreIntroduceCell()<XDTextViewDelegate>

@property (nonatomic,weak) XDTextView * p_tv;

@property (nonatomic,strong) NSString * p_proName;

@end

@implementation Ocean_StoreIntroduceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_StoreIntroduceCell";
    Ocean_StoreIntroduceCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_StoreIntroduceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
        XDTextView *tv = [[XDTextView alloc]init];
        tv.delegate = self;
        tv.XD_font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:tv];
        self.p_tv  = tv;
        
    }
    return self;
}

-(void)setP_accInfo:(NSDictionary *)p_accInfo{
    _p_accInfo = p_accInfo;
    self.textLabel.text = p_accInfo[@"title"];
    self.p_tv.XD_placehodel = p_accInfo[@"des"];
    self.p_proName = p_accInfo[@"propertyName"];
}

-(void)setModel:(Ocean_EnterStoreModel *)model{
    _model = model;
    if (self.p_proName) {
        NSString *str = [model valueForKeyPath:self.p_proName];
        self.p_tv.XD_text = str;
    }
    
}

- (void)didChangeXDText:(XDTextView *)textView{

    
    NSString *inputstring = textView.XD_text;
    
    [self.model setValue:inputstring forKey:self.p_proName];

}

-(void)didKeyBoardReturn:(XDTextView *)textView{


}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.x = 10;
    [self.textLabel sizeToFit];
    self.textLabel.y = 15;
    self.p_tv.x = self.textLabel.right +10;
    self.p_tv.width = self.width - self.p_tv.x -10;
    self.p_tv.y = self.textLabel.y -7;
    self.p_tv.height = self.height -2 *self.p_tv.y;
    
}

@end
