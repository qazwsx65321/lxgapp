//
//  Ocean_ShoppingCarControllerViewController.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/7/25.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_ShoppingCarControllerViewController.h"

@interface Ocean_ShoppingCarControllerViewController ()

@end

@implementation Ocean_ShoppingCarControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    self.navigationController.alpha = 0;

    
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
