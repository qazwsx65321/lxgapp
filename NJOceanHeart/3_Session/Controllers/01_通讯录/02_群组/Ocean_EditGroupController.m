//
//  Ocean_EditGroupController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/8/17.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_EditGroupController.h"

#import "ChooseHeadImageTool.h"

#import "Ocean_GroupController.h"

@interface Ocean_EditGroupController ()<UIImagePickerControllerDelegate>

{
    NSData *imgData;
}

@property (nonatomic,strong) UIButton *picButton;
@property (nonatomic,strong) UITextField *nameTextFiled;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIButton *commitButton;

@end

@implementation Ocean_EditGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑群资料";
    
    self.view.backgroundColor = [UIColor lightlightGrayColor];
    
    self.picButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.picButton setBackgroundImage:[UIImage imageNamed:@"user_photo_up"] forState:UIControlStateNormal];
    self.picButton.frame = CGRectMake((screen_Width - 100/320.f*screen_Width)/2.f, 100, 100/320.f*screen_Width, 100/320.f*screen_Width);
    [self.picButton addTarget:self action:@selector(selectPic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.picButton];
    
    self.nameTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(30, self.picButton.bottom + 50, screen_Width - 60, 30)];
    self.nameTextFiled.placeholder = @"填写群名称(2~10个字)";
    self.nameTextFiled.textColor = [UIColor lightGrayColor];
    self.nameTextFiled.textAlignment = NSTextAlignmentCenter;
    self.nameTextFiled.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.nameTextFiled];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(30, self.nameTextFiled.bottom, screen_Width - 60, 1)];
    self.line.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
    [self.view addSubview:self.line];
    
    self.commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commitButton.frame = CGRectMake(20, screen_Height - 60/480.f*screen_Height, screen_Width - 40, 40/480.f*screen_Height);
    self.commitButton.backgroundColor = [UIColor colorWithHexString:Navi_Background_Color];
    [self.commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.commitButton addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commitButton];
    
}

- (void)commitClick {
    if (!imgData) {
        [MBProgressHUD showWarnMessage:@"请选择头像!"];
        return;
    }
    
    if (!self.nameTextFiled.text.length) {
        [MBProgressHUD showWarnMessage:@"请填写群名称!"];
        return;
    }
    
    [self CreateGroup];
}

- (void)selectPic {
    [ChooseHeadImageTool chooseImageFormLibOrAlbum:self Edit:YES andDelegate:self];
}

-(void)Ocean_imagePickerControllerdidFinishPickingImageData:(NSData *)imageData{
    
    [self.picButton setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    
//    [self editHeadImage:imageData];
    
//    NSData *photoData = [imageData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    
//    imgData = [photoData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    imgData = imageData;
    
}


- (void)CreateGroup {
    
    NSDictionary *dic = @{
                          @"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_sign":@"0",
                          @"m_name":self.nameTextFiled.text,
                          @"m_headpic":imgData,
                          @"m_filepix":@".jpg",
                          @"m_tid":@"",
                          @"m_uids":self.idsArray
                          };
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"IOSCREATEGROUP" completion:^(id respInfo, NSError *error) {
        if (!error) {
            
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                
                UIViewController *contr = self.navigationController.childViewControllers[1];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddGroupSuccess" object:nil];
                [self.navigationController popToViewController:contr animated:YES];
            }else {
                [MBProgressHUD showInfoMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
            
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
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
