//
//  Ocean_FriendsInfoController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/15.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FriendsInfoController.h"

#import "Ocean_XDConnectRongCloud.h"
#import "Ocean_FriendsModel.h"

@interface Ocean_FriendsInfoController ()

{
    NSString *flag;
    NSString *nickName;
    Ocean_FriendsModel *model;
}

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIImageView *headPicView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *phoneTLabel;
@property (nonatomic,strong) UILabel *phoneLabel;

@property (nonatomic,strong) UIButton *funButton;
@property (nonatomic,strong) UIButton *connectButton;

@end

@implementation Ocean_FriendsInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"好友信息";
    
    nickName = @"10号葫芦娃";
    flag = @"0";
    
    self.view.backgroundColor = [UIColor lightlightGrayColor];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, screen_Width, 150/480.f*screen_Height)];
    self.headerView.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
    [self.view addSubview:self.headerView];
    
    self.headPicView = [[UIImageView alloc] initWithFrame:CGRectMake(120.f/320.f*screen_Width, (150/480.f*screen_Height-80.f/320.f*screen_Width)/2.f, 80.f/320.f*screen_Width, 80.f/320.f*screen_Width)];
    self.headPicView.layer.cornerRadius = 80.f/320.f*screen_Width/2.f;
    self.headPicView.layer.masksToBounds = YES;
    [self.headerView addSubview:self.headPicView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headPicView.bottom + 10, screen_Width, 20)];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.headerView addSubview:self.nameLabel];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, screen_Width, 40/480.f*screen_Height)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    
    self.phoneTLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screen_Width-20, 20/480.f*screen_Height)];
    self.phoneTLabel.textColor = [UIColor colorWithRed:0.263 green:0.271 blue:0.275 alpha:1.000];
    self.phoneTLabel.text = @"手机号码";
    self.phoneTLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.phoneTLabel];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20/480.f*screen_Height, screen_Width-20, 20/480.f*screen_Height)];
    self.phoneLabel.textColor = [UIColor colorWithRed:0.263 green:0.271 blue:0.275 alpha:1.000];
    self.phoneLabel.font = [UIFont systemFontOfSize:15];
    [self.bgView addSubview:self.phoneLabel];
    
    self.connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.connectButton.frame = CGRectMake(0, 0, screen_Width, 40/480.f*screen_Height);
    [self.connectButton addTarget:self action:@selector(talkClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.connectButton];
    
    
    if (![[Ocean_UserInfo sharedOcean_UserInfo].m_uid isEqualToString:self.friendid]) {
        self.funButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.funButton.frame = CGRectMake(30, screen_Height - (60/480.f)*screen_Height, screen_Width - 60, 40/480.f*screen_Height);
        self.funButton.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
        [self.funButton setTitle:@"添加好友" forState:UIControlStateNormal];
        self.funButton.layer.cornerRadius = 5;
        self.funButton.layer.masksToBounds = YES;
        [self.funButton addTarget:self action:@selector(funClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.funButton];
        
    }
    
    [self GetFriendsInfoWithFriendsid:self.friendid];
    
    
    
}

- (void)talkClick {
    
    if ([@"1" isEqualToString:flag]) {
        RCConversationViewController *controller = [[RCConversationViewController alloc] init];
        controller.conversationType = ConversationType_PRIVATE;
        controller.targetId = self.friendid;
        controller.title = nickName;
        [self.navigationController pushViewController:controller animated:YES];
    }else {
        [MBProgressHUD showWarnMessage:@"他不是您的好友，无法发消息!"];
    }
    
    
    
}

- (void)funClick {
    
    
    if ([@"1" isEqualToString:flag]) {
        [self DealFriendsWithFriendsid:self.friendid withInterface:@"DELETEFRIENDS"];
    }else {
        
        //添加好友功能
        NSString *extra = [NSString stringWithFormat:@"%@&::&%@&::&%@",[Ocean_UserInfo sharedOcean_UserInfo].m_touxiang,[Ocean_UserInfo sharedOcean_UserInfo].m_nickname,[Ocean_UserInfo sharedOcean_UserInfo].m_phone];
        
        [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud] RongCloudFriendsApplicationWithOption:Friend_Apply withUserid:[Ocean_UserInfo sharedOcean_UserInfo].m_uid withFriendid:self.friendid withMessage:[NSString stringWithFormat:@"我是%@,能加一下好友吗?",[Ocean_UserInfo sharedOcean_UserInfo].m_nickname] withExtra:extra withSuccess:^{
            [MBProgressHUD showTipMessageInView:@"好友申请发送成功!"];
            
            self.funButton.backgroundColor = [UIColor lightGrayColor];
            self.funButton.userInteractionEnabled = NO;
            
            
        } withError:^{
            [MBProgressHUD showTipMessageInView:@"好友申请发送失败!"];
        }];
        
        
        
    }
    
}


- (void)GetFriendsInfoWithFriendsid:(NSString *)friendsid {
    
    MJWeakSelf;
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_fuid":friendsid
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"GETFRIENDSINFO" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                [weakSelf.headPicView sd_setImageWithURL:[NSURL URLWithString:respInfo[@"m_headpic"]] placeholderImage:[UIImage imageNamed:@"HYZXIcon"]];
                weakSelf.nameLabel.text = respInfo[@"m_nickname"];
                weakSelf.phoneLabel.text = respInfo[@"m_phone"];
                
                nickName = respInfo[@"m_nickname"];
                flag = [respInfo[@"m_isfriend"] boolValue] ? @"1" : @"0";
                
                if ([respInfo[@"m_isfriend"] boolValue]) {
                    [weakSelf.funButton setTitle:@"删除好友" forState:UIControlStateNormal];
                }else {
                    [weakSelf.funButton setTitle:@"添加好友" forState:UIControlStateNormal];
                }
                
                
                model = [[Ocean_FriendsModel alloc] init];
                model.m_uid = friendsid;
                model.m_nickname = respInfo[@"m_nickname"];
                model.m_phone = respInfo[@"m_phone"];
                model.m_headpic = respInfo[@"m_headpic"];
                J_Insert(model).updateResult;
                
            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else {
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)DealFriendsWithFriendsid:(NSString *)friendsid withInterface:(NSString *)interface {
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_fuid":friendsid
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:interface completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
                
                NSString *extra = [NSString stringWithFormat:@"%@&::&%@&::&%@",[Ocean_UserInfo sharedOcean_UserInfo].m_touxiang,[Ocean_UserInfo sharedOcean_UserInfo].m_nickname,[Ocean_UserInfo sharedOcean_UserInfo].m_phone];

                
                [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud] RongCloudFriendsApplicationWithOption:Friend_Delete withUserid:[Ocean_UserInfo sharedOcean_UserInfo].m_uid withFriendid:self.friendid withMessage:@"删除好友!" withExtra:extra withSuccess:nil withError:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteFriendSuccess" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else {
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
    
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
