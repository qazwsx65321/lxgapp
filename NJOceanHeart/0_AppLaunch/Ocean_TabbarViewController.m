//
//  Ocean_TabbarViewController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_TabbarViewController.h"
#import "Ocean_NavigationController.h"
#import "Ocean_SessionViewController.h"

@implementation Ocean_TabbarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self.tabBar setBarTintColor:[UIColor whiteColor]];
        [self.tabBar setTranslucent:NO];
//        [self.tabBar setBackgroundImage:[UIImage new]];
//        [self.tabBar setShadowImage:[UIImage new]];
        
        NSArray *classInfoArr  = [NSArray arrayWithContentsOfFile:ProjectListPath(@"MianPageClass", @"plist")];
        for (NSDictionary  *classInfo in classInfoArr) {
            NSString *className = classInfo[@"ClassName"];
            NSString *title = classInfo[@"Title"];
            NSString *imageN = classInfo[@"ImageName_N"];
            NSString *imageH = classInfo[@"ImageName_H"];
            
            Class childrenClass = NSClassFromString(className);
            UIViewController *childrenVC = [[childrenClass alloc]init];
            childrenVC.title = title;
            [childrenVC.tabBarItem setImage:[[UIImage imageNamed:imageN] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [childrenVC.tabBarItem setSelectedImage:[[UIImage imageNamed:imageH] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [childrenVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:BackgroundColors(1)} forState:4];
            [childrenVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(204, 204, 204)} forState:0];
            
             [childrenVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:0];
            
           
            
            Ocean_NavigationController *nav = [[Ocean_NavigationController alloc]initWithRootViewController:childrenVC];
            [self addChildViewController:nav];
            
            if ([childrenVC isKindOfClass:[Ocean_SessionViewController class]]) {
                childrenVC.view.backgroundColor = [UIColor whiteColor];
            }
        }
        self.selectedIndex = 0;
    }
    return self;
}


-(void)dealloc{
    
    NSLog(@"Ocean_TabbarViewController销毁了");

}


@end
