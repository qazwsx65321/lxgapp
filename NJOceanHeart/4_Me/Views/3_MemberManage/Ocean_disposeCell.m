//
//  Ocean_disposeCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/24.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_disposeCell.h"
#import "Ocean_DespositDetailModel.h"
@interface Ocean_disposeCell()


@property (nonatomic,weak) UIButton * m_button1;
@property (nonatomic,weak) UIButton * m_button2;

@property (nonatomic,weak) UIButton * m_label1;
@property (nonatomic,weak) UIButton * m_label2;

@property (nonatomic,strong) UIView * p_lineBackView;
@property (nonatomic,strong) UIView * p_lineprocessView;


@end

@implementation Ocean_disposeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellsign = @"Ocean_disposeCell";
    Ocean_disposeCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell  = [[Ocean_disposeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsign];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.textLabel.text = @"处理进度";
        self.textLabel.font = [UIFont systemFontOfSize:14];
    
        self.p_lineBackView = [self creatLineV:[UIColor lightGrayColor]];
        self.p_lineprocessView = [self creatLineV:BackgroundColors(1)];
        [self.p_lineBackView addSubview:self.p_lineprocessView];
        [self.contentView addSubview:self.p_lineBackView];
        
        self.m_button1 = [self creatbutton];
        self.m_button2 = [self creatbutton];

        self.m_label1 = [self creatLbButton];
        self.m_label2 = [self creatLbButton];

  
        
        
    }
    return self;
}

-(UIView *)creatLineV:(UIColor *)color{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = color;
    view.width = 1.5;
    return view;
}


-(void)setModel:(Ocean_DespositDetailModel *)model{
    _model = model;
    
    NSString *cheaktime = model.m_checktime?model.m_checktime:@"";
    
    NSDictionary *rowDic = @{
                             @"1":@"待处理",
                             @"2":@"提现成功",
                             @"3":@"不同意"
                             };
    
    [self.m_label2 setTitle:[NSString stringWithFormat:@"%@ %@",rowDic[model.m_state],cheaktime] forState:0];
    
    [self.m_label1 setTitle:[NSString stringWithFormat:@"提交申请 %@",model.m_buildtime] forState:0];
    
    if ([@"1" isEqualToString:model.m_state]) {
        self.m_button1.selected = YES;
        self.m_button2.selected = NO;
        self.m_label1.selected = YES;
        self.m_label2.selected = NO;
    }else{
        self.m_button1.selected = YES;
        self.m_button2.selected = YES;
        self.m_label1.selected = YES;
        self.m_label2.selected = YES;
        
    }
    [self setNeedsDisplay];

}

-(UIButton *)creatLbButton{

    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor lightGrayColor] forState:0];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    button.userInteractionEnabled = NO;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:button];
    return button;
}





-(UIButton *)creatbutton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"iconfont-zhengque"] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"iconfont-yuanquan"] forState:0];
    btn.userInteractionEnabled = NO;
    btn.size = CGSizeMake(30, 30);
    [self.contentView addSubview:btn];
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.x = 15;
    [self.textLabel sizeToFit];
    self.textLabel.y = 15;
    
    self.m_button1.x = self.textLabel.centerX;
    self.m_button1.y = self.textLabel.bottom+10;
    [self.m_label1 sizeToFit];
    
    self.m_label1.x = self.m_button1.right +10;
    self.m_label1.centerY = self.m_button1.centerY;
    
    
    self.p_lineBackView.height = 40;
    self.p_lineBackView.centerX = self.m_button1.centerX;
    self.p_lineBackView.y = self.m_button1.bottom -5;
    
    if ([@"1" isEqualToString:self.model.m_state]) {
        self.p_lineprocessView.height = self.p_lineBackView.height/2;
    }else{
        self.p_lineprocessView.height = self.p_lineBackView.height;
    }
    self.m_button2.y = self.p_lineBackView.bottom-2;
    self.m_button2.x = self.m_button1.x;
    
    [self.m_label2 sizeToFit];
    self.m_label2.x = self.m_button2.right +10;
    self.m_label2.centerY = self.m_button2.centerY;
    
   CGFloat he = self.m_label2.bottom +15;
    NSLog(@"%lf",he);
    
    
}

@end
