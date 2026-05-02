//
//  Ocean_InfoDetailController.m
//  NJOceanHeart
//
//  Created by 陈志伟 on 17/7/3.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_InfoDetailController.h"

#import "Ocean_InfoDetailCell.h"

#import "XDDatePickerView.h"
#import "Ocean_InfoHeadCell.h"
#import "ChooseHeadImageTool.h"

@interface Ocean_InfoDetailController ()<UITableViewDelegate,UITableViewDataSource,XDDatePickerViewDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,weak) XDDatePickerView *dateView;

@end

@implementation Ocean_InfoDetailController

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    
    [self.view addSubview:self.tableView];
    
    [[Ocean_UserInfo sharedOcean_UserInfo] judgeObjectPropertyNull];
    
    self.bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.hidden = YES;
    self.bgView.alpha = 0.3;
    [self.view addSubview:self.bgView];
    
    XDDatePickerView *dateView = [[XDDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300)];
    dateView.isCurrentAuto = NO;
    dateView.isHour = NO;
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    [self.view addSubview:dateView];
    self.dateView = dateView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else {
        return 11;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        Ocean_InfoHeadCell *cell = [Ocean_InfoHeadCell cellWithTableView:tableView];
        cell.cardImage = [Ocean_UserInfo sharedOcean_UserInfo].m_headpic;
        return cell;
    }else {
        Ocean_InfoDetailCell *cell = [Ocean_InfoDetailCell cellWithTableView:tableView];
        cell.type = indexPath.row;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }else {
        return 100.f*screen_Width/750.f + 1;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        [ChooseHeadImageTool chooseImageFormLibOrAlbum:self Edit:YES andDelegate:self];
        
    }else {
        if (indexPath.row == 0) {
            //修改姓名
            [self showAlertViewWithTitie:@"姓名" withFlag:@"1" withValue:[Ocean_UserInfo sharedOcean_UserInfo].m_name];
            
        }else if (indexPath.row == 1) {
            //修改性别
            [self selectUserSex];
            
        }else if (indexPath.row == 2) {
            
            //出生日期
            self.bgView.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
                [self.dateView show];
            }];
            
        }else if (indexPath.row == 3) {
            [MBProgressHUD showTipMessageInView:@"不可更改!"];
        }else if (indexPath.row == 4) {
            [MBProgressHUD showTipMessageInView:@"不可更改!"];
        }else if (indexPath.row == 5) {
            
            //婚姻状况
            [self showAlertWithMarriage];
            
        }else if (indexPath.row == 6) {
            
            //教育程度
            [self showAlertWithEducation];
            
        }else if (indexPath.row == 7) {
            
            //住宅状况
            [self showAlertWithHouse];
            
        }else if (indexPath.row == 8) {
            //住宅地址
            [self showAlertViewWithTitie:@"住宅地址" withFlag:@"9" withValue:[Ocean_UserInfo sharedOcean_UserInfo].m_houseaddress];
        }else if (indexPath.row == 9) {
            [MBProgressHUD showTipMessageInView:@"不可更改!"];
        }else {
            [self showAlertViewWithTitie:@"邮箱" withFlag:@"11" withValue:[Ocean_UserInfo sharedOcean_UserInfo].m_qq_email];
        }
    }
    
    
    
}

-(void)Ocean_imagePickerControllerdidFinishPickingImageData:(NSData *)imageData{
    
    [self editHeadImage:imageData];
    
}


-(void)editHeadImage:(NSData*)data{
    
    MJWeakSelf;
    NSDictionary *postDic =  @{@"m_uid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                               @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                               @"m_flag":@"0",
                               @"m_headpic":data,
                               @"m_filepix":@".jpg",
                               @"m_zcardpic":@"",
                               @"m_fcardpic":@""
                               };
    
    [HttpRequestTools  requestUNUserInfoWithData:postDic    methodName:@"IOSUPDATEPICTURE" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                
                NSString *imageURl = [Ocean_UserInfo sharedOcean_UserInfo].m_headpic;
                
                [[SDImageCache sharedImageCache]removeImageForKey:imageURl withCompletion:nil];
                
                NSString *m_headName = [NSString stringWithFormat:@"%@t.jpg",[Ocean_UserInfo sharedOcean_UserInfo].m_uid];
                NSURL *url = [NSURL URLWithString:imageURl];
                NSURL *pathUrl=  [url URLByDeletingLastPathComponent];
                NSString *m_headPath = [[pathUrl absoluteString] stringByAppendingPathComponent:m_headName];
                
                if (m_headPath.length) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:m_headPath forKey:@"m_headpic"];
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


//姓名、地址
- (void)showAlertViewWithTitie:(NSString *)title withFlag:(NSString *)flag withValue:(NSString *)value {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    __block UITextField *tf = [[UITextField alloc] init];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        tf = textField;
        tf.text = value;
    }];
    MJWeakSelf;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf EDIT_UpdateUserinfoWithFlag:flag withText:tf.text];
        
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

//性别
- (void)selectUserSex {
    MJWeakSelf;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"性别" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"2" withText:@"M"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"2" withText:@"F"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

//婚姻状况
- (void)showAlertWithMarriage {
    
    MJWeakSelf;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"婚姻状况" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"未婚" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"6" withText:@"S"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"已婚" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"6" withText:@"M"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"6" withText:@"O"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//教育程度
- (void)showAlertWithEducation {
    
    MJWeakSelf;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"教育程度" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"硕士或以上" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"7" withText:@"M"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"本科" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"7" withText:@"U"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"大专" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"7" withText:@"P"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"高中/中专" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"7" withText:@"H"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"初中或以下" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"7" withText:@"S"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}


//住宅状况
- (void)showAlertWithHouse {
    
    MJWeakSelf;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"住宅状况" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"自有无按揭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"8" withText:@"S"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"按揭住宅" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"8" withText:@"M"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"单位分配" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"8" withText:@"Q"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"租房" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"8" withText:@"R"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"与父母同住" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"8" withText:@"L"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf EDIT_UpdateUserinfoWithFlag:@"8" withText:@"O"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)EDIT_UpdateUserinfoWithFlag:(NSString *)flag withText:(NSString *)text {
    
    MJWeakSelf;
    NSDictionary *dic = @{
                          @"m_bid":[Ocean_UserInfo sharedOcean_UserInfo].m_uid,
                          @"m_session":[Ocean_UserInfo sharedOcean_UserInfo].m_session,
                          @"m_type":flag,   // 1姓名，2性别，3出生日期，4证件类型（不使用） 5.证件号码（不使用），6.婚姻状况，7.教育程度，8住宅情况，9住宅地址，10手机号（不使用），11，QQ邮箱（不使用），12.单位名称，13.职务
                          @"m_value":text,
                          };
    
    
    [HttpRequestTools requestUserInfoWithData:dic methodName:@"UPDATEUSERINFO" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([@"0000" isEqualToString:respInfo[@"ERRORCODE"]]) {
                if ([@"0" isEqualToString:flag]) {
                    
                }else if ([@"1" isEqualToString:flag]) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:text forKey:@"m_name"];
                }else if ([@"2" isEqualToString:flag]) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:text forKey:@"m_sex"];
                }else if ([@"3" isEqualToString:flag]) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:text forKey:@"m_birthday"];
                }else if ([@"4" isEqualToString:flag]) {
                    
                }else if ([@"5" isEqualToString:flag]) {
                    
                }else if ([@"6" isEqualToString:flag]) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:text forKey:@"m_marriage"];
                }else if ([@"7" isEqualToString:flag]) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:text forKey:@"m_edulevel"];
                }else if ([@"8" isEqualToString:flag]) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:text forKey:@"m_house"];
                }else if ([@"9" isEqualToString:flag]) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:text forKey:@"m_houseaddress"];
                }else if ([@"10" isEqualToString:flag]) {
                    
                }else if ([@"11" isEqualToString:flag]) {
                    [[Ocean_UserInfo sharedOcean_UserInfo] saveValue:text forKey:@"m_qq_email"];
                }else {
                    
                }
            }else {
                [MBProgressHUD showErrorMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else {
            [MBProgressHUD showErrorMessage:@"服务器异常!"];
        }
        
        [weakSelf.tableView reloadData];
    }];
    
}


#pragma mark - XDDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {

    [self EDIT_UpdateUserinfoWithFlag:@"3" withText:timer];
    
    
    self.bgView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
    
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    self.bgView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
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
