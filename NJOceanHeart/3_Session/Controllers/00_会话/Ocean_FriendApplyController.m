//
//  Ocean_FriendApplyController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/15.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FriendApplyController.h"

#import "Ocean_XDConnectRongCloud.h"

#import "Ocean_FriendsModel.h"

@interface Ocean_FriendApplyController ()

{
    Ocean_FriendsModel *model;
}

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIImageView *headPicView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *phoneTLabel;
@property (nonatomic,strong) UILabel *phoneLabel;

@property (nonatomic,strong) UIButton *agreeButton;
@property (nonatomic,strong) UIButton *refuseButton;

@end

@implementation Ocean_FriendApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"好友申请";
    
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
    
    self.agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.agreeButton.frame = CGRectMake(30, screen_Height - (60/480.f)*screen_Height, (screen_Width - 80)/2.f, 40/480.f*screen_Height);
    self.agreeButton.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
    [self.agreeButton setTitle:@"同意" forState:UIControlStateNormal];
    self.agreeButton.layer.cornerRadius = 5;
    self.agreeButton.layer.masksToBounds = YES;
    [self.agreeButton addTarget:self action:@selector(agreeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.agreeButton];
    
    self.refuseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.refuseButton.frame = CGRectMake(self.agreeButton.right + 20, screen_Height - 60/480.f*screen_Height, (screen_Width - 80)/2.f, 40/480.f*screen_Height);
    self.refuseButton.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
    [self.refuseButton setTitle:@"拒绝" forState:UIControlStateNormal];
    self.refuseButton.layer.cornerRadius = 5;
    self.refuseButton.layer.masksToBounds = YES;
    [self.refuseButton addTarget:self action:@selector(refuseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.refuseButton];
    
    [self GetFriendsInfoWithFriendsid:self.friendid];
    
}


- (void)agreeClick {
    [self DealFriendsWithFriendsid:self.friendid withInterface:@"ADDFRIENDS"];
}


- (void)refuseClick {
    
    NSString *extra = [NSString stringWithFormat:@"%@&::&%@&::&%@",[Ocean_UserInfo sharedOcean_UserInfo].m_touxiang,[Ocean_UserInfo sharedOcean_UserInfo].m_nickname,[Ocean_UserInfo sharedOcean_UserInfo].m_phone];
    
    [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud] RongCloudFriendsApplicationWithOption:Friend_Refuse withUserid:[Ocean_UserInfo sharedOcean_UserInfo].m_uid withFriendid:self.friendid withMessage:@"对方拒绝了您的好友申请!" withExtra:extra withSuccess:^{
        [self.navigationController popViewControllerAnimated:YES];
    } withError:nil];
    
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
            
                model = [[Ocean_FriendsModel alloc] init];
                model.m_uid = friendsid;
                model.m_nickname = respInfo[@"m_nickname"];
                model.m_phone = respInfo[@"m_phone"];
                model.m_headpic = respInfo[@"m_headpic"];
                
                
                
            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else {
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
    }];
    
}

- (void)DealFriendsWithFriendsid:(NSString *)friendsid withInterface:(NSString *)interface {
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_fuid":friendsid
                          };
    
    [MBProgressHUD showActivityMessageInWindow:@"请求发送中..."];
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:interface completion:^(id respInfo, NSError *error) {
        
        [MBProgressHUD hideHUD];
        
        if (!error) {
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
                
                
                NSString *extra = [NSString stringWithFormat:@"%@&::&%@&::&%@",[Ocean_UserInfo sharedOcean_UserInfo].m_touxiang,[Ocean_UserInfo sharedOcean_UserInfo].m_nickname,[Ocean_UserInfo sharedOcean_UserInfo].m_phone];
                
                [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud] RongCloudFriendsApplicationWithOption:Friend_Agree withUserid:[Ocean_UserInfo sharedOcean_UserInfo].m_uid withFriendid:self.friendid withMessage:@"你们已成为好友!" withExtra:extra withSuccess:^{
                    J_Insert(model).updateResult;
                    [self.navigationController popViewControllerAnimated:YES];
                } withError:nil];
                
                
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
