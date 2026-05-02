//
//  Ocean_DespositResonController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/24.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_DespositResonController.h"

@interface Ocean_DespositResonController ()

@end

@implementation Ocean_DespositResonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拒绝原因";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.x = 10;
    label.width = screen_Width -2 *label.x;
    label.numberOfLines = 0;
    label.y = 15;
    label.text = self.m_reson;
    label.font = [UIFont systemFontOfSize:14];
    [label sizeToFit];
    UIScrollView *scroller = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [scroller addSubview:label];
    [self.view addSubview:scroller];
    scroller.contentSize = CGSizeMake(screen_Width, label.bottom +30);

}


@end
