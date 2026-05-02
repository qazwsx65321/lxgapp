//
//  Ocean_PersonageInfoController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_PersonageInfoController.h"

#import "Ocean_InfoDetailController.h"
#import "Ocean_MyCardController.h"
#import "Ocean_AddressListController.h"

#import "Ocean_PersonageInfoCell0.h"
#import "Ocean_PersonageInfoCell1.h"
#import "XRNextPreCell.h"
#import "ChooseHeadImageTool.h"
#import "Ocean_imagePickerController.h"
#import "Ocean_ProfessionController.h"
#import "Ocean_MyQRCodeController.h"
#import "Ocean_XDConnectRongCloud.h"
#import <JPUSHService.h>
@interface Ocean_PersonageInfoController ()<UITableViewDelegate,UITableViewDataSource,XRNextPreCellDelegate,Ocean_imagePickerControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation Ocean_PersonageInfoController

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料"; 
    
    [[Ocean_UserInfo sharedOcean_UserInfo] judgeObjectPropertyNull];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    
    [self.view addSubview:self.tableView];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section?1:7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        XRNextPreCell *cell = [XRNextPreCell cellWithTableView:tableView];
        cell.nextTitle = @"退出";
        cell.delegate = self;
        return cell;
    }else {
        if (indexPath.row == 0) {
            
            Ocean_PersonageInfoCell0 *cell = [Ocean_PersonageInfoCell0 cellWithTableView:tableView];
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[Ocean_UserInfo sharedOcean_UserInfo].m_touxiang] placeholderImage:[UIImage imageNamed:@"me_user"]];
            return cell;
            
        }else {
            Ocean_PersonageInfoCell1 *cell = [Ocean_PersonageInfoCell1 cellWithTableView:tableView];
            cell.type = indexPath.row;
            
            return cell;
        }
    }
    
}

-(void)clickNextbutton{

    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出程序" preferredStyle:UIAlertControllerStyleAlert];
    [alter addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
      [alter addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          [[Ocean_UserInfo sharedOcean_UserInfo] removeKeyChain];
          [[Ocean_XDConnectRongCloud sharedOcean_XDConnectRongCloud] logoutRongCloudWithReceivePush:NO];
          
          [[SDImageCache sharedImageCache] clearMemory];
          [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
          [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
              
              
          } seq:0];
          NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",@"OceanTable"]];
          [[JRDBMgr shareInstance] deleteDatabaseWithPath:filePath];
          [self.navigationController popViewControllerAnimated:YES];
      }]];
    [self presentViewController:alter animated:YES completion:nil];
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130.f*screen_Width/750.f + 5;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        
        if (indexPath.row == 0) {
            [ChooseHeadImageTool chooseImageFormLibOrAlbum:self Edit:YES andDelegate:self];
        }else if (indexPath.row == 1) {
            
            [self showAlertView];
            
        }else if (indexPath.row == 2) {
            
            Ocean_MyQRCodeController *codeVC = [[Ocean_MyQRCodeController alloc]init];
            [self.navigationController pushViewController:codeVC animated:YES];
            
        }else if (indexPath.row == 3) {
            Ocean_InfoDetailController *infoVC = [[Ocean_InfoDetailController alloc] init];
            [self.navigationController pushViewController:infoVC animated:YES];
        }else if (indexPath.row == 4) {
            Ocean_ProfessionController *professionVC = [[Ocean_ProfessionController alloc] init];
            [self.navigationController pushViewController:professionVC animated:YES];
            
        }else if (indexPath.row == 5) {
            Ocean_MyCardController *mycardVC = [[Ocean_MyCardController alloc] init];
            [self.navigationController pushViewController:mycardVC animated:YES];
        }else if (indexPath.row == 6) {
            Ocean_AddressListController *addressVC = [[Ocean_AddressListController alloc] init];
            [self.navigationController pushViewController:addressVC animated:YES];
        }
    }
    
    
}

-(void)Ocean_imagePickerControllerdidFinishPickingImageData:(NSData *)imageData{

    [self editHeadImage:imageData];

}


-(void)editHeadImage:(NSData*)data{

    MJWeakSelf;
    NSDate *date = [NSDate new];
    NSDateFormatter *dateF = [[NSDateFormatter alloc]init];
    dateF.dateFormat = @"yyyyMMddHHmmss";
    NSString *datestr = [dateF stringFromDate:date];
   NSDictionary *postDic =  @{@"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
      @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
      @"m_flag":@"0",
      @"m_content":data,
      @"m_filepix":@".jpg",
      @"m_imagetime":datestr};

    [HttpRequestTools  requestUNUserInfoWithData:postDic                                      methodName:@"IOSUPDATENC" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
             
                NSString *imageURl = [Ocean_UserInfo sharedOcean_UserInfo].m_touxiang;
                
                [[SDImageCache sharedImageCache]removeImageForKey:imageURl withCompletion:nil];
                
                
                NSString *m_touxName = [NSString stringWithFormat:@"%@x.jpg",[Ocean_UserInfo sharedOcean_UserInfo].m_uid];
                
                NSURL *url = [NSURL URLWithString:imageURl];
                
                NSArray *subArr = [imageURl componentsSeparatedByString:@"/"];
                NSString *laststring = [subArr lastObject];
                NSURL *pathUrl = url;
                if (laststring.length) {
                    pathUrl  = [url URLByDeletingLastPathComponent];
                }
                
                NSString *m_touxiangPath = [[pathUrl absoluteString] stringByAppendingPathComponent:m_touxName];
                
                if (m_touxiangPath.length) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:m_touxiangPath forKey:@"m_touxiang"];
                }
                
                
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.tableView reloadData];
    }];

}


//修改姓名
- (void)showAlertView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"昵称" preferredStyle:UIAlertControllerStyleAlert];
    __block UITextField *tf = [[UITextField alloc] init];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        tf = textField;
        tf.text = [Ocean_UserInfo sharedOcean_UserInfo].m_nickname;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MJWeakSelf;
        NSDictionary *dic = @{
                              @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                              @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                              @"m_flag":@"1",
                              @"m_content":tf.text,
                              @"m_filepix":@"",
                              @"m_imagetime":@""
                              };
        
        
        [HttpRequestTools requestUserInfoWithData:dic methodName:@"UPDATENC" completion:^(id respInfo, NSError *error) {
            if (!error) {
                if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:tf.text forKey:@"m_nickname"];
                }else {
                    [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
                }
            }else {
                [MBProgressHUD showErrorMessage:@"服务器异常!"];
            }
            
            [weakSelf.tableView reloadData];
        }];
        
        
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}




@end
