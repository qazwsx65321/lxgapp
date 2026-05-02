//
//  GroupButtonsView.m
//  cloudSnatch
//
//  Created by qiushi on 2016/11/12.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#import "GroupButtonsView.h"
#import "XRButton.h"
#import "Ocean_FIRSTPAGESHOWModel.h"

#define rowspace 15

@interface GroupButtonsView()

@property(nonatomic,strong)NSArray *buttonMessageArr;
@property(nonatomic,assign)CGFloat p_padding;
@property(nonatomic,assign)NSInteger p_rowNum;
@end

@implementation GroupButtonsView


- (instancetype)initWithinfoArr:(NSArray *)infoArr Tag:(id)tag MonthodSel:(SEL)selector panding:(CGFloat )panding RowNum:(NSInteger)rowNum;
{
    self = [super init];
    if (self) {
        self.p_padding = panding;
        self.buttonMessageArr = infoArr;
        self.p_rowNum = rowNum;
        for (int i =0;i<8;i++) {
            UITabBarItem *itmes = [UITabBarItem new];
            itmes.title = @"sss";
            XRButton *button = [[XRButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20) andIsTabItem:NO];
            button.item = itmes;
            button.tag = i +100;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont fontWithName:Heiti_Light size:14];
            [button addTarget:tag action:selector forControlEvents:UIControlEventTouchUpInside];
            button.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:button];
            
        }
        
        
    }
    return self;
}

-(void)layoutSubviews{
   
    [super layoutSubviews];
    NSInteger spaceCount = self.p_rowNum -1;
    CGFloat itemSpace = (screen_Width - 2*self.p_padding - self.p_rowNum *self.itmeSize.width)/spaceCount;
    NSInteger count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        XRButton *button = self.subviews[i];
        button.size = self.itmeSize;
        button.x = self.p_padding + (i%self.p_rowNum)*(itemSpace +button.width);
        button.y =  10+(i/self.p_rowNum) *(button.height+rowspace);
    }
    
}

-(void)setM_buttonInfo:(NSArray *)m_buttonInfo{
    _m_buttonInfo = m_buttonInfo;
    for (int i = 0; i<[self.subviews count]; i++) {
        XRButton *button = self.subviews[i];
        if (i>=m_buttonInfo.count) {
            button.hidden = YES;
            continue;
        }
        button.hidden = NO;
        
        groupButtonModel *model =  m_buttonInfo[i];
        button.infoModel = model;
        [button sd_setImageWithURL:[NSURL URLWithString:model.m_picture] forState:0 placeholderImage:[UIImage imageNamed:@"errorImage"]];
        [button setTitle:model.m_name forState:UIControlStateNormal];
    }
    
}

@end
