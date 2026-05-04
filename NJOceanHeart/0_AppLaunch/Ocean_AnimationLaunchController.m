//
//  Ocean_ AnimationLaunchController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/11.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_AnimationLaunchController.h"
#import "Ocean_TabbarViewController.h"
#import "UIImage+GIF.h"
#import "OLImageView.h"
#import "OLImage.h"
#import "AppDelegate.h"
//20260504 modify
@interface Ocean_AnimationLaunchController ()<WKNavigationDelegate,OLImageViewDelegate>
{
    BOOL firstBL;
}
@end

@implementation Ocean_AnimationLaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //20220416，去掉启动页后的青色颜色的背景
//    self.view.backgroundColor = RGB(99, 229, 252);
    
    //20220416, 去掉启动页后面gif动画的播放
    OLImageView *Aimv = [[OLImageView alloc] initWithImage:[OLImage imageNamed:@"启动页一次.gif"]];
    [Aimv setFrame:self.view.bounds];
    [Aimv setUserInteractionEnabled:YES];
    Aimv.delegate = self;
    [self.view addSubview:Aimv];
    
}

- (void)imageViewDidLoop:(OLImageView *)imageView{
    [imageView stopAnimating];
    Ocean_TabbarViewController *tabbarVC = [[Ocean_TabbarViewController alloc]init];
    tabbarVC.delegate = self.Appde;
    self.Appde.window.rootViewController = tabbarVC;
}

-(void)dealloc{
    
    NSLog(@"Animation销毁了");
    
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
