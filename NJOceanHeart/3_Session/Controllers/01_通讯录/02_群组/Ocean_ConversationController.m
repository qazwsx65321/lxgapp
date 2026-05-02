//
//  Ocean_ConversationController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/17.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ConversationController.h"

#import "Ocean_GroupInfoController.h"

@interface Ocean_ConversationController ()

@end

@implementation Ocean_ConversationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightlightGrayColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contact"] style:UIBarButtonItemStylePlain target:self action:@selector(infoClick)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)infoClick {
    Ocean_GroupInfoController *infoVC = [[Ocean_GroupInfoController alloc] init];
    infoVC.groupid = self.targetId;
    [self.navigationController pushViewController:infoVC animated:YES];
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
