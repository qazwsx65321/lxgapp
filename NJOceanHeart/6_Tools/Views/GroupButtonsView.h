//
//  GroupButtonsView.h
//  cloudSnatch
//
//  Created by qiushi on 2016/11/12.
//  Copyright © 2016年 xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupButtonsView : UIView



@property(nonatomic,assign)CGSize itmeSize;

@property(nonatomic,weak)UIView *delegate;

@property (nonatomic,strong) NSArray * m_buttonInfo;


- (instancetype)initWithinfoArr:(NSArray *)infoArr Tag:(id)tag MonthodSel:(SEL)selector panding:(CGFloat )panding RowNum:(NSInteger)rowNum;


@end
