//
//  Ocean_StoreInputMessageCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_StoreInputMessageCell.h"
#import "Ocean_EnterStoreModel.h"

@interface Ocean_StoreInputMessageCell()

@property (nonatomic,strong) NSString * p_proName;
@property (nonatomic,strong) NSString * p_line;

@end

@implementation Ocean_StoreInputMessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_StoreInputMessageCell";
    Ocean_StoreInputMessageCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_StoreInputMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.m_tf  = [self creatTF:@"" andTag:100];
        self.textLabel.font = [UIFont systemFontOfSize:15];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inputingStr:) name:UITextFieldTextDidChangeNotification object:self.m_tf];
    }
    return self;
}

-(void)inputingStr:(NSNotification *)not{
    UITextField *tf = not.object;
    [self.model setValue:tf.text forKey:self.p_proName];
}

-(void)setP_accInfo:(NSDictionary *)p_accInfo{
    _p_accInfo = p_accInfo;
    self.textLabel.text = p_accInfo[@"title"];
//    self.m_tf.placeholder = p_accInfo[@"des"];
    NSAttributedString *attrStringPlace = [[NSAttributedString alloc]initWithString:p_accInfo[@"des"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [self.m_tf setAttributedPlaceholder:attrStringPlace];
    NSString *edit = p_accInfo[@"edit"];
    NSString *line = p_accInfo[@"line"];
    self.m_tf.userInteractionEnabled = [edit integerValue];
    if (![edit integerValue]) {
        self.m_tf.text = nil;
    }
    
    self.separatorInset = UIEdgeInsetsMake(0, [line integerValue] *screen_Width, 0, 0);
    self.p_line = p_accInfo[@"line"];
    self.p_proName = p_accInfo[@"propertyName"];
}

-(void)setModel:(Ocean_EnterStoreModel *)model{
    _model = model;
    if (self.p_proName) {
        NSString *str = [model valueForKeyPath:self.p_proName];
        self.m_tf.text = str;
    }
    
}



-(UITextField *)creatTF:(NSString *)placeholder andTag:(NSInteger)tag{
    
    UITextField *tex = [[UITextField alloc]init];
    tex.tag = tag;
    tex.font = [UIFont systemFontOfSize:15];
    tex.placeholder = placeholder;
    [self.contentView addSubview:tex];
    return tex;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.x = 10;
    [self.textLabel sizeToFit];
    self.textLabel.centerY = self.height/2;
    
    self.m_tf.x = self.textLabel.right + 10;
    self.m_tf.height = 20;
    self.m_tf.width = self.width - self.m_tf.x -10;
    self.m_tf.centerY = self.textLabel.centerY;
    
    

}

@end
