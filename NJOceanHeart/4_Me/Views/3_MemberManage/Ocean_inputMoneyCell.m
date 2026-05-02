//
//  Ocean_inputMoneyCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_inputMoneyCell.h"

@interface Ocean_inputMoneyCell()

@end

@implementation Ocean_inputMoneyCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_inputMoneyCell";
    Ocean_inputMoneyCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_inputMoneyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UITextField *tf = [[UITextField alloc]init];
        tf.placeholder = @"请输入充值金额";
        tf.keyboardType = UIKeyboardTypeDecimalPad;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:tf];

        [self.contentView addSubview:tf];
        self.p_TF = tf;
        tf.borderStyle = UITextBorderStyleRoundedRect;
    }
    return self;
}


-(void)change:(NSNotification *)not{
    UITextField *tf = not.object;
    NSString *inputStr = tf.text;
    
    if (inputStr.length >0) {
        
        NSArray *signArr =[inputStr componentsSeparatedByString:@"."];
        if (signArr.count>2) {
            [tf deleteBackward];
        }else{
            NSString * last = [signArr lastObject];
            if ([inputStr containsString:@"."] && last.length>1) {
                [tf deleteBackward];
            }
        }
        
        if ([inputStr characterAtIndex:0] =='.') {
            tf.text = @"0.";
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.p_TF.x = 10;
    self.p_TF.height = 35;
    self.p_TF.width = screen_Width-20;
    self.p_TF.centerY = self.height/2;
}

@end
