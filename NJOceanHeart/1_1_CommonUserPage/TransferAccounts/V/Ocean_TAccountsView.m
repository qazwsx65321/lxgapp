//
//  Ocean_TAccountsView.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/16.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_TAccountsView.h"

@interface Ocean_TAccountsView()


@property (nonatomic,weak) UILabel * p_titleLb;
@property (nonatomic,weak) UILabel * p_nicknameLb;
@property (nonatomic,weak) UILabel * p_moneyLb;
@property (nonatomic,weak) UILabel * p_signLb;

@property (nonatomic,weak) UITextField * p_InputMoneyTF;
@property (nonatomic,weak) UIImageView * p_headImageV;

@property (nonatomic,weak) UIButton * p_messgaeBtn;
@property (nonatomic,weak) UIButton * p_tranBtn;
@property (nonatomic,weak) UIView * p_lightGrayView;

@end

@implementation Ocean_TAccountsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *backGrayView = [[UIView alloc]init];
        self.p_lightGrayView = backGrayView;
        backGrayView.backgroundColor = RGB(251, 251, 251);
        [self addSubview:backGrayView];
        
        self.p_titleLb = [self creatLbTitle:@"向个人用户转账" Font:[UIFont fontWithName:Heiti_Medium size:15] Color:[UIColor blackColor]];
        self.p_nicknameLb = [self creatLbTitle:@"昵称:" Font:[UIFont fontWithName:Heiti_Light size:15] Color:        [UIColor lightGrayColor]];
        self.p_moneyLb = [self creatLbTitle:@"金额" Font:[UIFont fontWithName:Heiti_Medium size:16] Color:[UIColor blackColor]];
        self.p_signLb = [self creatLbTitle:@"¥" Font:[UIFont fontWithName:Heiti_Medium size:20] Color:[UIColor blackColor]];
        
        UIImageView *headImageV = [[UIImageView alloc]init];
        [self addSubview:headImageV];
        self.p_headImageV = headImageV;
        
        UITextField *tf = [[UITextField alloc]init];
        self.p_InputMoneyTF = tf;
        [tf becomeFirstResponder];
        tf.font = [UIFont systemFontOfSize:40];
        tf.keyboardType =UIKeyboardTypeDecimalPad;
        [self addSubview:tf];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:tf];
        
        UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [messageBtn setTitle:@"添加留言" forState:UIControlStateNormal];
        messageBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [messageBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:messageBtn];
        self.p_messgaeBtn = messageBtn;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:RGB(163, 222, 163)];
        [btn addTarget:self action:@selector(clickAccount) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"转账" forState:UIControlStateNormal];
        [btn setTitleColor:RGB(208, 208, 208) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self addSubview:btn];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        self.p_tranBtn = btn;
        
        
        
    }
    return self;
}

-(void)setFriendPic:(NSString *)headPic andNickName:(NSString *)nickName{

    [self.p_headImageV sd_setImageWithURL:[NSURL URLWithString:headPic]];
    self.p_nicknameLb.text = [NSString  stringWithFormat:@"昵称:%@",nickName];
    
}

-(void)clickAccount{
    [self.p_InputMoneyTF resignFirstResponder];
    [self.delegate Ocean_TAccountsViewClickTransferAccount:self.p_InputMoneyTF.text];

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
            if ([inputStr containsString:@"."] && last.length>2) {
                [tf deleteBackward];
            }
        }
        
        if ([inputStr characterAtIndex:0] =='.') {
            tf.text = @"0.";
        }
        
        self.p_tranBtn.userInteractionEnabled = YES;
        [self.p_tranBtn setBackgroundColor:RGB(84, 174, 10)];
        self.p_tranBtn.selected = YES;
    }else{
        self.p_tranBtn.userInteractionEnabled = NO;
        [self.p_tranBtn setBackgroundColor:RGB(163, 222, 163)];
        self.p_tranBtn.selected = NO;
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    407/50
    self.p_headImageV.width = self.p_headImageV.height = self.width *50/407;
    self.p_headImageV.y = 15;
    self.p_headImageV.centerX = self.width/2;
    
    self.p_titleLb.width = self.width;
    self.p_titleLb.height = 15;
    self.p_titleLb.y = self.p_headImageV.bottom +10;
    self.p_titleLb.textAlignment = NSTextAlignmentCenter;

    self.p_nicknameLb.width = self.width;
    self.p_nicknameLb.height = 15;
    self.p_nicknameLb.y = self.p_titleLb.bottom +10;
    self.p_nicknameLb.textAlignment = NSTextAlignmentCenter;

    self.p_lightGrayView.height = self.p_nicknameLb.bottom +15;
    self.p_lightGrayView.width = self.width;
    
    self.p_moneyLb.x = 25;
    self.p_moneyLb.width = 100;
    self.p_moneyLb.height = 16;
    self.p_moneyLb.y = self.p_lightGrayView.bottom +20;
    
    self.p_signLb.x = self.p_moneyLb.x;
    self.p_signLb.y = self.p_moneyLb.bottom +15;
    self.p_signLb.width= self.p_signLb.height = 20;
    
    self.p_InputMoneyTF.x = self.p_signLb.right +5;
    self.p_InputMoneyTF.width = self.width - self.p_InputMoneyTF.x -20;
    self.p_InputMoneyTF.height = 45;
    self.p_InputMoneyTF.y = self.p_signLb.y;
    
    self.p_tranBtn.x = self.p_signLb.x;
    self.p_tranBtn.width = self.width - 2*self.p_signLb.x;
    self.p_tranBtn.height = 45;
    self.p_tranBtn.y = self.p_InputMoneyTF.bottom +20;
//
    }

-(UILabel *)creatLbTitle:(NSString *)title Font:(UIFont *)font Color:(UIColor *)color{
    UILabel *label = [[UILabel alloc]init];
    [self addSubview:label];
    label.text = title;
    label.font = font;
    label.textColor = color;
    return label;
}

@end
