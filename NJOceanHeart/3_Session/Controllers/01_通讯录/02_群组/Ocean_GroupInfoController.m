//
//  Ocean_GroupInfoController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/17.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_GroupInfoController.h"
#import "Ocean_GroupInfoCell.h"
#import "Ocean_GroupInfoCell0.h"
#import "Ocean_GroupInfoCell1.h"
#import "Ocean_GroupInfoCell2.h"
#import "Ocean_GroupInfoHeaderView.h"
#import "Ocean_GroupModel.h"
#import "Ocean_GroupSelectController.h"
#import "Ocean_FriendsInfoController.h"
#import "ChooseHeadImageTool.h"

@interface Ocean_GroupInfoController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,Ocean_GroupInfoCell2Delegate,UIImagePickerControllerDelegate>

{
    BOOL isManager;
    
    NSArray *qunArray;
}

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *infoArray;

@property (nonatomic,strong) NSMutableArray *friendList;

@end

@implementation Ocean_GroupInfoController

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"群资料";
    self.view.backgroundColor = [UIColor whiteColor];
    
    isManager = NO;
    
    [self GetGroupMember];
    
    qunArray = J_Select(Ocean_GroupModel).Where([NSString stringWithFormat:@"m_qid = '%@'",self.groupid]).list;
    
    [self.view addSubview:self.collectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNoti) name:@"DealMemberSuccess" object:nil];
    
    [self.collectionView registerClass:[Ocean_GroupInfoCell class] forCellWithReuseIdentifier:@"Ocean_GroupInfoCell"];
    [self.collectionView registerClass:[Ocean_GroupInfoCell0 class] forCellWithReuseIdentifier:@"Ocean_GroupInfoCell0"];
    [self.collectionView registerClass:[Ocean_GroupInfoCell1 class] forCellWithReuseIdentifier:@"Ocean_GroupInfoCell1"];
    [self.collectionView registerClass:[Ocean_GroupInfoCell2 class] forCellWithReuseIdentifier:@"Ocean_GroupInfoCell2"];
    [self.collectionView registerClass:[Ocean_GroupInfoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader"];
    
}

- (void)reloadNoti {
    
    [self GetGroupMember];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return isManager ? self.infoArray.count + 2 : self.infoArray.count;
    }else if (section == 1) {
        return 2;
    }else {
        return 1;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        Ocean_GroupInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Ocean_GroupInfoCell" forIndexPath:indexPath];
        
        if (isManager) {
            if (indexPath.item == self.infoArray.count) {
                cell.picName = @"plus3";
            }else if (indexPath.item == self.infoArray.count+1) {
                cell.picName = @"miu3";
            }else {
                cell.model = self.infoArray[indexPath.item];
            }
        }else {
            cell.model = self.infoArray[indexPath.item];
        }
        return cell;
    }else if (indexPath.section == 1) {
        
        if (indexPath.item == 0) {
            Ocean_GroupInfoCell0 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Ocean_GroupInfoCell0" forIndexPath:indexPath];
            Ocean_GroupModel *mode = qunArray[0];
            cell.picurl = mode.m_picture;
            return cell;
        }else {
            Ocean_GroupInfoCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Ocean_GroupInfoCell1" forIndexPath:indexPath];
            Ocean_GroupModel *mode = qunArray[0];
            cell.name = mode.m_name;
            return cell;
        }
        
    }else {
        Ocean_GroupInfoCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Ocean_GroupInfoCell2" forIndexPath:indexPath];
        cell.isManager = isManager;
        cell.delegate = self;
        return cell;
    }
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (isManager) {
        
        if (indexPath.section == 0) {
            if (indexPath.item == self.infoArray.count) {
                
                Ocean_GroupSelectController *groupVC = [[Ocean_GroupSelectController alloc] init];
                groupVC.groupid = self.groupid;
                groupVC.isAddFriend = YES;
                [self.navigationController pushViewController:groupVC animated:YES];
                
            }else if (indexPath.item == self.infoArray.count+1) {
                
                Ocean_GroupSelectController *groupVC = [[Ocean_GroupSelectController alloc] init];
                groupVC.groupid = self.groupid;
                groupVC.isAddFriend = NO;
                [self.navigationController pushViewController:groupVC animated:YES];
                
            }else {
                
                Ocean_GroupMemberModel *model = self.infoArray[indexPath.item];
                
                Ocean_FriendsInfoController *friendVC = [[Ocean_FriendsInfoController alloc] init];
                friendVC.friendid = model.m_uid;
                [self.navigationController pushViewController:friendVC animated:YES];
            }
        }else if (indexPath.section == 1) {
            if (indexPath.item == 0) {
                
                [ChooseHeadImageTool chooseImageFormLibOrAlbum:self Edit:YES andDelegate:self];
                
                
            }else {
                Ocean_GroupModel *mode = qunArray[0];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"群名称" preferredStyle:UIAlertControllerStyleAlert];
                __block UITextField *tf = [[UITextField alloc] init];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    tf = textField;
                    tf.text = mode.m_name;
                }];
                MJWeakSelf;
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [weakSelf UpdateGroup:nil withName:tf.text withFlag:@"1"];
                    
                    
                }]];
                [self presentViewController:alert animated:YES completion:nil];
                
                
            }
        }
        
        
    }else {
        
        
        if (indexPath.section == 0) {
            Ocean_GroupMemberModel *model = self.infoArray[indexPath.item];
            
            Ocean_FriendsInfoController *friendVC = [[Ocean_FriendsInfoController alloc] init];
            friendVC.friendid = model.m_uid;
            [self.navigationController pushViewController:friendVC animated:YES];
        }
        
        
    }
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        Ocean_GroupInfoHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionElementKindSectionHeader" forIndexPath:indexPath];
        
        view.groupNum = [NSString stringWithFormat:@"%zd",self.infoArray.count];
        return view;
    }else {
        return [UICollectionReusableView new];
    }
    
}

#pragma mark ---- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake((screen_Width - 60.f/320.f*screen_Width)/5.f, (screen_Width - 60.f/320.f*screen_Width)/5.f);
    }else if (indexPath.section == 1) {
        
        if (indexPath.item == 0) {
            return CGSizeMake(screen_Width, 60);
        }else {
            return CGSizeMake(screen_Width, 50);
        }
        
    }else {
        return CGSizeMake(screen_Width, 60);
    }
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return CGSizeMake(screen_Width, 50);
    }else {
        return CGSizeMake(0, 0);
    }
}

//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if (section == 0) {
        return 10.f/320.f*screen_Width;
    }else {
        return 0;
    }
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(5, 10.f/320.f*screen_Width, 5, 10.f/320.f*screen_Width);
    }else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (void)quitGroup:(Ocean_GroupInfoCell2 *)cell {
    
    self.friendList = [NSMutableArray array];
    
    if (cell.isManager) {
        for (Ocean_GroupMemberModel *model in self.infoArray) {
            NSDictionary *dic = @{
                                  @"m_qid":self.groupid,
                                  @"m_uid":model.m_uid
                                  };
            [self.friendList addObject:dic];
        }
    }else {
        NSDictionary *dic = @{
                              @"m_qid":self.groupid,
                              @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid
                              };
        [self.friendList addObject:dic];
    }
    
    [self DeleteGroupMember];
    
}


-(void)Ocean_imagePickerControllerdidFinishPickingImageData:(NSData *)imageData{
    
    [self UpdateGroup:imageData withName:@"" withFlag:@"0"];
    
}

-(void)UpdateGroup:(NSData*)data withName:(NSString *)name withFlag:(NSString *)flag  {
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_sign":@"0",
                          @"m_qid":self.groupid,
                          @"m_flag":flag,
                          @"m_content":[@"0" isEqualToString:flag] ? data : name,
                          @"m_filepix":[@"0" isEqualToString:flag] ? @".jpg" : @""
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"IOSUPDATEGROUP" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                [MBProgressHUD showSuccessMessage:respInfo[@"ERRORDESTRIPTION"]];
                
                Ocean_GroupModel *model = qunArray[0];
                
                if ([@"1" isEqualToString:flag]) {
                    
                    model.m_name = name;
                }else {
//                    model.m_picture = [NSString stringWithFormat:@"http://show.xuanrui68.com/XuanR_HyZxSoftWare_Server/userpic/%@g.jpg",[Ocean_UserInfo sharedOcean_UserInfo].m_uid];
                }
                
                J_Update(model).updateResult;
                
                qunArray = J_Select(Ocean_GroupModel).Where([NSString stringWithFormat:@"m_qid = '%@'",self.groupid]).list;
                
                [self.collectionView reloadData];
                
                
            }else {
                [MBProgressHUD showWarnMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
            
        }else {
            [MBProgressHUD showErrorMessage:@"网络错误!"];
        }
        
        
        
        
    }];
    
}


- (void)GetGroupMember {
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_qid":self.groupid
                          };
    
    self.infoArray = [NSMutableArray array];
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"GETGROUPMEMBER" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            Ocean_GroupMemberHead *head = [Ocean_GroupMemberHead mj_objectWithKeyValues:respInfo];
            if ([@"0000" isEqualToString:head.ERRORCODE]) {
                
                
                for (int i = 0; i < head.m_myfriends.count; i ++) {
                    Ocean_GroupMemberModel *model = head.m_myfriends[i];
                    if ([model.m_uid isEqualToString:[Ocean_UserInfo sharedOcean_UserInfo].m_uid]) {
                        if ([@"1" isEqualToString:model.m_ismanager]) {
                            isManager = YES;
                        }else {
                            isManager = NO;
                        }
                    }
                    
                    [self.infoArray addObject:model];
                }
                
            }else {
                [MBProgressHUD showInfoMessage:head.ERRORDESTRIPTION];
            }
            
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }
        
        [self.collectionView reloadData];
    }];
    
}



- (void)DeleteGroupMember {
    
    NSDictionary *dic = @{
                          @"m_uuid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_sign":@"0",
                          @"m_userList":self.friendList
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"DELETEGROUPMEMBER" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                UIViewController *contr = self.navigationController.childViewControllers[1];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"QuitGroupSuccess" object:nil];
                [self.navigationController popToViewController:contr animated:YES];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
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
