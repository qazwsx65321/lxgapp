//
//  WP_PickView.m
//  WorkToDoClient_Preson
//
//  Created by qiushi on 16/5/26.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#import "WPP_PickView.h"

@interface WPP_PickView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,weak)UIPickerView *p_pickView;

@property(nonatomic,weak)UIButton *p_cancleBtn;
@property(nonatomic,weak)UIButton *p_sureBtn;
@property(nonatomic,weak)UILabel *p_title;

@end

@implementation WPP_PickView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.65];
        
        UIPickerView *pickerV = [[UIPickerView alloc]init];
        self.p_pickView = pickerV;
        self.p_pickView.width = screen_Width;
        self.p_pickView.height  = 230;
        self.p_pickView.x = 0;
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 40)];
//        view.backgroundColor = [UIColor redColor];
//        [pickerV addSubview:view];
        self.p_pickView.y = screen_Height - self.p_pickView.height;
        pickerV.backgroundColor = [UIColor whiteColor];
        pickerV.delegate = self;
        pickerV.dataSource = self;
        [self addSubview:pickerV];
        [self headView];
    }
    return self;

}

-(void)setInfoArr:(NSArray *)infoArr{
    
    _infoArr = infoArr;
    [self.p_pickView selectRow:0 inComponent:0 animated:NO];
    [self.p_pickView reloadAllComponents];
}

-(void)headView{
    UIView *view = [[UIView alloc]init];
    view.x = 0;
    view.width = screen_Width;
    
    view.height = 40;
    view.y=self.p_pickView.y - view.height;
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    self.p_cancleBtn = [self creatBtn:@"取消" :[UIColor lightGrayColor] :WPP_PickViewCancelBtnType :view];
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
    
    self.p_sureBtn = [self creatBtn:@"完成" :[UIColor blueColor] :WPP_PickViewSureBtnType :view];
    [view addSubview:self.p_sureBtn];

    self.p_sureBtn.width = self.p_cancleBtn.width;
    self.p_sureBtn.height = self.p_cancleBtn.height;
    self.p_sureBtn.x = screen_Width - self.p_sureBtn.width-10;
    self.p_sureBtn.y = self.p_cancleBtn.y;
    
}

-(UIButton *)creatBtn:(NSString *)title :(UIColor *)color :(WPP_PickViewBtnType)tag :(UIView *)view{
    
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
        case WPP_PickViewCancelBtnType:
            
            
            break;
            
        case WPP_PickViewSureBtnType:
        {
            
            [self.delegate chooseIndexForm:self.p_pickView];
            
        }
            break;
    }
    [self dismissListView];

}

-(void)setTitleName:(NSString *)titleName{
    
    self.p_title.text = titleName;
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return screen_Width;
    
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

-(void)showListView{
    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    // 2.添加自己到窗口上
    
    [window addSubview:self];
    
    
    // 3.设置尺寸
    self.frame = window.bounds;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
  return  self.infoArr.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.infoArr[row];
}


-(void)dismissListView{

    
    [self removeFromSuperview];
    
}


-(void)layoutSubviews{
    [super layoutSubviews];

}

@end
