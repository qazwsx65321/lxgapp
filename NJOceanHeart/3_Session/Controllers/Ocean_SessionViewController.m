//
//  Ocean_SessionViewController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_SessionViewController.h"
#import "Ocean_ChattingController.h"
#import "Ocean_ContactsController.h"

#import "Ocean_SearchFriendController.h"

#import "XRCF_Common_Way.h"

@interface Ocean_SessionViewController ()

@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) Ocean_ChattingController *chatController;
@property (nonatomic,strong) Ocean_ContactsController *contactController;

@end

@implementation Ocean_SessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"main_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
    
    Ocean_ChattingController *chatController = [[Ocean_ChattingController alloc] initWithDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                                                                                                    @(ConversationType_DISCUSSION),
                                                                                                                    @(ConversationType_GROUP)] collectionConversationType:@[@(ConversationType_SYSTEM)]];
    chatController.selfNav = self.navigationController;
    
    
    Ocean_ContactsController *contactController = [[Ocean_ContactsController alloc] init];
    
    
    contactController.selfNav = self.navigationController;
    
    [self addChildViewController:chatController];
    [self addChildViewController:contactController];
    
    [self.view addSubview:chatController.view];
    //    [self.view addSubview:contactController.view];
    
    self.chatController = chatController;
    self.contactController = contactController;
    
    CGFloat BHY =  screen_Height==812 ?88:64;
    
    //20210221 add
    XRCF_Common_Way * commonway=[[XRCF_Common_Way alloc]init];
    NSInteger subheightdata = [commonway GetFitScreenSubValue];
    BHY =  BHY + subheightdata;

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, BHY, screen_Width, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    self.bgView = bgView;
    
    UISegmentedControl  *segmentController = [[UISegmentedControl alloc] initWithItems:@[@"会话",@"通讯录"]];
    //设置普通状态下(未选中)状态下的文字颜色和字体
    [segmentController setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName: [UIColor colorWithRed:0.192 green:0.196 blue:0.200 alpha:1.000]} forState:UIControlStateNormal];
    //设置选中状态下的文字颜色和字体
    
    [segmentController setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName: [UIColor colorWithHexString:Navi_Background_Color]} forState:UIControlStateSelected];
    
    segmentController.frame = CGRectMake(0, 0, screen_Width, 40);
    segmentController.selectedSegmentIndex = 0;
    segmentController.tintColor = [UIColor clearColor];
    
    [bgView addSubview:segmentController];
    
    
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39, screen_Width/2.f, 1)];
    sepLine.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
    [bgView addSubview:sepLine];
    
    self.line = sepLine;
    
    [segmentController addTarget:self action:@selector(sementedControlClick:) forControlEvents:UIControlEventValueChanged];
    
    
    
}


//监听方法
- (void)sementedControlClick:(UISegmentedControl *)segment {
    //修改底部线的frame值产生动画
    [UIView animateWithDuration:0.25 animations:^{
        self.line.x = (segment.selectedSegmentIndex == 0) ? 0 : screen_Width/2.f;
    }];
    
    if (self.contactController.view || self.chatController.view) {
        [self.contactController.view removeFromSuperview];
        [self.chatController.view removeFromSuperview];
    }
    
    switch (segment.selectedSegmentIndex) {
        case 0:
        {
            //                self.chatController.view.frame = CGRectMake(0, 104, screen_Width, screen_Height - 104 - 49);
            
            [self.view addSubview:self.chatController.view];
            [self.view addSubview:self.bgView];
        }
            
            break;
        case 1:
        {
            //                self.contactController.view.frame = CGRectMake(0, 104, screen_Width, screen_Height - 104 - 49);
            [self.view addSubview:self.contactController.view];
            [self.contactController GET_GetFriendsInterface];
        }
            
            break;
        default:
            break;
    }
    
}

- (void)searchClick {
    
    Ocean_SearchFriendController *searchVC = [[Ocean_SearchFriendController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
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
