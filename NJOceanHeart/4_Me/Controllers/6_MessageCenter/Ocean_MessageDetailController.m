//
//  Ocean_MessageDetailController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/11/10.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_MessageDetailController.h"

@interface Ocean_MessageDetailController ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *stateLabel;
@property (nonatomic,strong) UILabel *contentLabel;

@end

@implementation Ocean_MessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initViews];
    
}


- (void)initViews {
    
    self.stateLabel = [[UILabel alloc] init];
    self.stateLabel.font = [UIFont systemFontOfSize:13];
    self.stateLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.stateLabel];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.contentLabel];
    
    self.titleLabel.text = self.dic[@"title"];
    
    if ([@"1" isEqualToString:self.dic[@"deviceid"]]) {
        self.stateLabel.text = @"公告通知";
    }else {
        self.stateLabel.text = @"提醒通知";
    }
    
    self.contentLabel.text = self.dic[@"content"];
    
    [self layout];
    
}

- (void)layout {
    
    self.titleLabel.frame = CGRectMake(0, 64, screen_Width, 30);
    
    self.stateLabel.frame = CGRectMake(0, self.titleLabel.bottom + 10, screen_Width, 30);
    
    CGSize conS = [StringSizeModel sizeWithText:self.dic[@"content"] font:[UIFont systemFontOfSize:14] maxW:screen_Width - 20];
    self.contentLabel.frame = CGRectMake(10, self.stateLabel.bottom + 10, screen_Width - 20, conS.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
