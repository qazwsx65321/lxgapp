//
//  WP_PickView.m
//  WorkToDoClient_Preson
//
//  Created by qiushi on 16/5/26.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#import "WP_PickView.h"

@interface WP_PickView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString *num;
}


@property(nonatomic,strong)UIButton *p_cancleBtn;
@property(nonatomic,strong)UIButton *p_sureBtn;
@property(nonatomic,strong)UILabel *p_title;
@property (nonatomic,copy) ReturnTextBlock p_textBlock;

@end

@implementation WP_PickView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.65];
        
        UIDatePicker *pickerV = [[UIDatePicker alloc]init];
        pickerV.datePickerMode =  UIDatePickerModeDate;
        [pickerV setDate:[NSDate new]];
        self.p_pickView = pickerV;
        self.p_pickView.width = screen_Width;
        self.p_pickView.height  = 250;
        self.p_pickView.x = 0;
        
//        [self.p_pickView selectRow:3 inComponent:0 animated:YES];
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
//        view.backgroundColor = [UIColor redColor];
//        [pickerV addSubview:view];
        self.p_pickView.y = SCREEN_HEIGHT - self.p_pickView.height;
        pickerV.backgroundColor = [UIColor whiteColor];
//        pickerV addt
//        pickerV.dataSource = self;
        
        [self addSubview:pickerV];
        [self headView];
    }
    return self;

}

-(void)setTitleArray:(NSMutableArray *)titleArray{
    
    _titleArray = titleArray;
    if (titleArray.count) {
        num = titleArray[0];
    }
    
//    [self.p_pickView reloadAllComponents];
}

-(void)headView{
    UIView *view = [[UIView alloc]init];
    view.x = 0;
    view.width = screen_Width;
    view.height = 40;
    view.y=self.p_pickView.y - view.height;
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    self.p_cancleBtn = [self creatBtn:@"取消" :[UIColor lightGrayColor] :WP_PickViewCancelBtnType :view];
    [view addSubview:self.p_cancleBtn];
    self.p_cancleBtn.x = 10;
    self.p_cancleBtn.width = 30;
    self.p_cancleBtn.height = 40;
    self.p_cancleBtn.y = 0;
    
    UILabel *label = [[UILabel alloc]init];
    self.p_title = label;
    [view addSubview:label];
    label.text = @"选择您的需求";
    label.textAlignment = NSTextAlignmentCenter;
    label.width = screen_Width -2*self.p_cancleBtn.width-20;
    label.height = 15;
    label.textColor = [UIColor lightGrayColor];
    label.x = CGRectGetMaxX(self.p_cancleBtn.frame);
    label.centerY = self.p_cancleBtn.centerY;
    
    self.p_sureBtn = [self creatBtn:@"完成" :[UIColor blueColor] :WP_PickViewSureBtnType :view];
    [view addSubview:self.p_sureBtn];

    self.p_sureBtn.width = self.p_cancleBtn.width;
    self.p_sureBtn.height = self.p_cancleBtn.height;
    self.p_sureBtn.x = screen_Width - self.p_sureBtn.width-10;
    self.p_sureBtn.y = self.p_cancleBtn.y;
    
}

-(UIButton *)creatBtn:(NSString *)title :(UIColor *)color :(WP_PickViewBtnType)tag :(UIView *)view{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.tag = tag;
    [view addSubview:btn];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
    
}

-(void)click:(UIButton *)sender{
    
    switch (sender.tag) {
        case WP_PickViewCancelBtnType:
            
            [self dismissListView];
            
            break;
            
        case WP_PickViewSureBtnType:
        {
            
//            NSInteger row  = [self.p_pickView selectedRowInComponent:0];
            if (_p_textBlock != nil)
            {
                NSDate *date = self.p_pickView.date;                
                _p_textBlock(date);
            }
            [self dismissListView];
        
        }
            break;
    }
    
}

-(void)setTitleName:(NSString *)titleName{
    
    self.p_title.text = titleName;
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//    
//    return SCREENWIDTH;
//    
//}

//-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
//    return 50;
//}

-(void)showListViewandReturn:(ReturnTextBlock)returnTextBlock{
    // 1.获得最上面的窗口
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    // 2.添加自己到窗口上
    
    [window addSubview:self];
    
    self.p_textBlock = returnTextBlock;
    // 3.设置尺寸
    
    self.frame = window.bounds;
    
//    [self.p_pickView reloadAllComponents];
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
  return  self.titleArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (!num) {
        num = self.titleArray[0];
    }
    return self.titleArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    num = self.titleArray[row];
}

-(void)dismissListView{

    
    [self removeFromSuperview];
    
}


-(void)layoutSubviews{
    [super layoutSubviews];

}

@end
