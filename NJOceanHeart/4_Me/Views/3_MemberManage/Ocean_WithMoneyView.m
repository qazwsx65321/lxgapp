//
//  Ocean_WithMoneyView.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/23.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_WithMoneyView.h"

@interface Ocean_WithMoneyView()


@end

@implementation Ocean_WithMoneyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = RGB(216, 216,216).CGColor;
        self.layer.borderWidth = 1;
        
        UITextField *tfInput = [[UITextField alloc]init];
        tfInput.placeholder = @"请输入您的提现金额,最少100元";
        tfInput.font = [UIFont systemFontOfSize:16];
        tfInput.x = 10;
        tfInput.width = self.width - 2*tfInput.x;
        tfInput.height = 25;
        tfInput.keyboardType = UIKeyboardTypeDecimalPad;
        tfInput.centerY= self.height *1/4;
        [self addSubview:tfInput];
        [tfInput becomeFirstResponder];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:tfInput];

        UIView *line = [[UIView alloc]init];
        line.width = self.width;
        line.height = .8;
        line.backgroundColor =RGB(216, 216, 216);
        line.centerY = self.height/2;
        [self addSubview:line];

        
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = @"手续费";
        
        label1.font = [UIFont systemFontOfSize:16];
        [self addSubview:label1];
        label1.x = 5;
        label1.y = tfInput.bottom +16;
        [label1 sizeToFit];
        label1.height = 16;
        label1.centerY = self.height *3/4;
        
        UILabel *label2 = [[UILabel alloc]init];
        label2.text = @"0.00 元";
        label2.textColor = BackgroundColors(1);
        [self addSubview:label2];
        label2.font = [UIFont systemFontOfSize:16];
        label2.x = label1.right +10;
        label2.width = self.width - label2.x;
        label2.height = 16;
        label2.centerY = self.height *3/4;
        self.p_lable2 = label2;

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
            if ([inputStr containsString:@"."] && last.length>2) {
                [tf deleteBackward];
            }
        }
        
        if ([inputStr characterAtIndex:0] =='.' ||[inputStr characterAtIndex:0] == '0') {
            tf.text = @"";
            [MBProgressHUD showErrorMessage:@"请输入正确金额!"];
        }
        
    
        
        if ([tf.text floatValue]>=100) {
            //符合条件
            [self.delegate judgeInputRight:YES andText:tf.text];
            
        }else{
            //不符合条件
            [self.delegate judgeInputRight:NO andText:tf.text];
        }

    }else{
        //不符合条件
        [self.delegate judgeInputRight:NO andText:tf.text];
    }
    
}

-(void)setCommissionCharge:(NSString *)money{

    self.p_lable2.text  =[NSString stringWithFormat:@"%@ 元",money];

}


@end
