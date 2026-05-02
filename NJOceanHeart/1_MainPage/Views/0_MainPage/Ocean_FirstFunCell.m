//
//  Ocean_FirstFunCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/7.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FirstFunCell.h"
#import "GroupButtonsView.h"
#import "XRButton.h"
#import "Ocean_FIRSTPAGESHOWModel.h"
@interface Ocean_FirstFunCell()

@property (nonatomic,weak) GroupButtonsView * p_groupButton;

@end
@implementation Ocean_FirstFunCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat SW =  screen_Width * 160/404;
        NSArray *info = [NSArray arrayWithContentsOfFile:ProjectListPath(@"FirstPageFunction",@"plist")];
        GroupButtonsView *view = [[GroupButtonsView alloc]initWithinfoArr:info Tag:self MonthodSel:@selector(chooseBtn:) panding:0 RowNum:4];
        CGFloat W =  screen_Width /4;
        self.p_groupButton = view;
        CGFloat H = SW/2;
        view.itmeSize = CGSizeMake(W, H);
        [self addSubview:view];
        
        
    }
    return self;
}
-(void)chooseBtn:(XRButton *)sender{
    groupButtonModel *model = sender.infoModel;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HYZXGroupButtonClickEvent" object:model];
}

-(void)setM_buttonItems:(NSArray *)m_buttonItems{
    _m_buttonItems = m_buttonItems;
    self.p_groupButton.m_buttonInfo = m_buttonItems;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.p_groupButton.frame = self.bounds;
}

@end
