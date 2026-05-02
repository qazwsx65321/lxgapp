//
//  Ocean_BasicInfoCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/27.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_BasicInfoCell.h"
#import "Ocean_PersonageInfoModel.h"
@interface  Ocean_BasicInfoCell()

@property (nonatomic,strong) Ocean_PersonageInfoModel * p_infoModel;
@property (nonatomic,weak) UIButton * p_acceButton;
@property (nonatomic,weak) UILabel * p_mustLb;

@end

@implementation Ocean_BasicInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_BasicInfoCell";
    Ocean_BasicInfoCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_BasicInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
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
        self.m_tf = tf;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardChangeValue:) name:UITextFieldTextDidChangeNotification object:tf];
        tf.font = [UIFont systemFontOfSize:14];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.p_acceButton = button;
        button.size = CGSizeMake(30, 25);
        self.accessoryView = button;
        [self.contentView addSubview:tf];
        
        UILabel *mustLb = [[UILabel alloc]init];
        mustLb.text = @"*";
        mustLb.font  =[UIFont systemFontOfSize:20];
        [mustLb sizeToFit];
        mustLb.textAlignment = NSTextAlignmentCenter;
        mustLb.textColor = [UIColor redColor];
        [self.contentView addSubview:mustLb];
        self.p_mustLb = mustLb;
        
        
    }
    return self;
}

-(void)keyBoardChangeValue:(NSNotification *)not{
    UITextField *ft = not.object;
    [_p_infoModel setValue:ft.text forKey:_m_key];
    if ([@"m_bankno"isEqualToString:_m_key]) {
        if ([self.delegate respondsToSelector:@selector(textFileChange:)]) {
            [self.delegate textFileChange:ft];
        }
        
    }
}



-(void)setBaseDic:(NSDictionary *)infoDic andInfoModel:(Ocean_PersonageInfoModel *)infoModel{
    _m_key = infoDic[@"key"];
    self.textLabel.text = infoDic[@"title"];
    self.m_tf.placeholder = infoDic[@"placeHold"];
    _p_infoModel = infoModel;
    NSString *str = [infoModel valueForKey:_m_key];
    UIButton *button = (UIButton *)self.accessoryView;
    if ([infoDic[@"type"] integerValue]==2) {
        button.hidden = NO;
        self.m_tf.userInteractionEnabled =NO;
        [button setImage:[UIImage imageNamed:@"moreDown01"] forState:0];
        NSArray *alterDicArr = infoDic[@"show"];
        if (!alterDicArr.count) {
            if (str.length>=8) {
                str= [NSString stringWithDateFormater:@"yyyy-MM-dd" andTimeString:[NSString stringWithFormat:@"%@102413",str]];
            }
        }else{
        
            if (str) {
                for (NSDictionary *dic in alterDicArr) {
                    if (dic[str]) {
                        str = dic[str];
                        break;
                    }
                }
                
            }
            
        
        }
       
        
    }else{
        button.hidden = YES;
        self.m_tf.userInteractionEnabled =YES;
    }
    self.m_tf.text = str;
    self.p_mustLb.hidden = ![infoDic[@"mustCheck"] integerValue];
    
    if ([@"m_phone" isEqualToString:infoDic[@"key"]]) {
        self.userInteractionEnabled = NO;
    }else{
        self.userInteractionEnabled = YES;
    }
    
    

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.textLabel sizeToFit];
    self.textLabel.x = 10;
    self.textLabel.centerY = self.contentView.height/2;
    
    self.m_tf.x = self.textLabel.right + 10;
    self.m_tf.width = self.contentView.width - self.m_tf.x;
    self.m_tf.height = 20;
    self.m_tf.centerY = self.textLabel.centerY;
    self.p_mustLb.centerY = self.height/2 +5;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)setSelected:(BOOL)selected{


}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{

    NSLog(@"animated:%d",selected);

}

@end
