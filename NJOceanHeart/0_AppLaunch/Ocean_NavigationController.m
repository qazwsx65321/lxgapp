//
//  Ocean_NavigationController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_NavigationController.h"

@interface Ocean_NavigationController ()
@property (nonatomic,strong) UIView * bgView;
@end

@implementation Ocean_NavigationController

+ (void)initialize
{
    if (self == [Ocean_NavigationController class]) {
        

    }
}



-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if ([super initWithRootViewController:rootViewController]) {
        
        
        UINavigationBar *navbar = self.navigationBar;
        [navbar setBackgroundColor:BackgroundColors(1)];
        [navbar setBarTintColor:BackgroundColors(1)];
        [navbar setTranslucent:YES];

        NSDictionary *textAtt = @{
                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                  NSForegroundColorAttributeName:[UIColor whiteColor]
                                  };
        [navbar setTitleTextAttributes:textAtt];
        
        
        UIBarButtonItem *navItem = [UIBarButtonItem appearance];
        NSMutableDictionary *attributeDict = [NSMutableDictionary dictionary];
        attributeDict[NSForegroundColorAttributeName] = [UIColor redColor];
        attributeDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
        [navItem setTitleTextAttributes:attributeDict forState:UIControlStateNormal];
        
        NSMutableDictionary *disableAttributeDict = [NSMutableDictionary dictionary];
        disableAttributeDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        disableAttributeDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
        [navItem setTitleTextAttributes:disableAttributeDict forState:UIControlStateDisabled];
        
        
        
        //在navigationBar下放一层view
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height+20)];
        
        self.bgView.backgroundColor =BackgroundColors(1);
        [self.view insertSubview:self.bgView belowSubview:self.navigationBar];
        //导航栏透明
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
        [self.navigationBar setShadowImage:[UIImage new]];
    }
    return self;
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count) {
        
        UIBarButtonItem *navItem  = viewController.navigationItem.rightBarButtonItem;
        
        NSMutableDictionary *attributeDict = [NSMutableDictionary dictionary];
        attributeDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
        attributeDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
        [navItem setTitleTextAttributes:attributeDict forState:UIControlStateNormal];
        
        NSMutableDictionary *disableAttributeDict = [NSMutableDictionary dictionary];
        disableAttributeDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        disableAttributeDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
        [navItem setTitleTextAttributes:disableAttributeDict forState:UIControlStateDisabled];
        
        
        
        
        
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        backButton.size =CGSizeMake(30, 30);
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    }
    [super pushViewController:viewController animated:animated];
}

-(void)backAction:(UIButton *)sender{

    [self popViewControllerAnimated:YES];

}

-(void)setAlpha:(CGFloat)alpha{
    self.bgView.backgroundColor = BackgroundColors(alpha);
    if (alpha ==0) {
        self.bgView.hidden = YES;
    }else{
        self.bgView.hidden = NO;
    }
}

@end
