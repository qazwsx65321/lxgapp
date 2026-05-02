//
//  Ocean_SmallToolsController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/22.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_SmallToolsController.h"
#import "KX9FirstPageFectureCommendCell.h"

#import "Ocean_TrainTicketInquiryVC.h"
#import "Ocean_DrivingDeductionInquiryVC.h"
#import "Ocean_IDCardInquiryVC.h"
#import "Ocean_XihuaDictionaryVC.h"
#import "Ocean_NewsLinkVC.h"
#import "Ocean_DishonestInquiryVC.h"
#import "Ocean_IntelligentQuestionAnswerVC.h"
#import "Ocean_DukeDreamVC.h"
#import "Ocean_ExpressInquiryVC.h"
#import "Ocean_IPAddressInquiryVC.h"
#import "Ocean_PhoneAttributionInquiryVC.h"

@interface Ocean_SmallToolsController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,weak) UICollectionView * p_collectionView;
@property (nonatomic,strong) NSArray * p_infoArr;
@property (nonatomic,strong) NSDictionary * p_config;
@property (nonatomic,strong) NSArray *miniprogramArray;
@end

@implementation Ocean_SmallToolsController

- (NSArray *)miniprogramArray {
    if (!_miniprogramArray) {
        _miniprogramArray = [NSArray array];
        _miniprogramArray = @[
                              NSClassFromString(@"Ocean_TrainTicketInquiryVC"),
                              NSClassFromString(@"Ocean_DrivingDeductionInquiryVC"),
                              NSClassFromString(@"Ocean_IDCardInquiryVC"),
                              NSClassFromString(@"Ocean_XihuaDictionaryVC"),
                              NSClassFromString(@"Ocean_NewsLinkVC"),
                              NSClassFromString(@"Ocean_DishonestInquiryVC"),
                              NSClassFromString(@"Ocean_IntelligentQuestionAnswerVC"),
                              NSClassFromString(@"Ocean_DukeDreamVC"),
                              NSClassFromString(@"Ocean_ExpressInquiryVC"),
                              NSClassFromString(@"Ocean_IPAddressInquiryVC"),
                              NSClassFromString(@"Ocean_PhoneAttributionInquiryVC")
                              ];
    }
    return _miniprogramArray;
}

-(NSDictionary *)p_config{
    if (!_p_config) {
        _p_config = [NSDictionary dictionaryWithContentsOfFile:ProjectListPath(@"AppletRequestConfig",@"plist")];
    }
    return _p_config;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"实用工具";
    

    UICollectionViewFlowLayout *Flayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat W = screen_Width/3.f;
    CGFloat H = W * 215.f/175.f;
    Flayout.itemSize = CGSizeMake(W, H);
    Flayout.minimumInteritemSpacing = 0;
    Flayout.minimumLineSpacing = 0;
    UICollectionView *collectonView =[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:Flayout];
    self.p_collectionView = collectonView;
    collectonView.delegate = self;
    collectonView.backgroundColor =[UIColor whiteColor];
    collectonView.dataSource =self;
    [collectonView registerClass:[KX9FirstPageFectureCommendCell class] forCellWithReuseIdentifier:@"KX9FirstPageFectureCommendCell"];
    [self.view addSubview:collectonView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self USINGTOOLSLIST];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return  self.p_infoArr.count;
    
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KX9FirstPageFectureCommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KX9FirstPageFectureCommendCell" forIndexPath:indexPath];
    cell.model = self.p_infoArr[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击工具按钮
    
    if (indexPath.item == 0) {
        [MBProgressHUD showInfoMessage:@"此功能正在开发中，敬请期待~"];
    }else {
        
        UIViewController *controller = [self.miniprogramArray[indexPath.item - 1] new];
        KX9FirstPageProductModel *model = self.p_infoArr[indexPath.item];
        [controller setValue:model forKeyPath:@"model"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}
-(void)USINGTOOLSLIST{

    MJWeakSelf;
    [HttpRequestTools  requestUNUserInfoWithData:nil methodName:@"USINGTOOLSLIST" completion:^(id respInfo, NSError *error) {
        if (!error) {
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                weakSelf.p_infoArr = [KX9FirstPageProductModel mj_objectArrayWithKeyValuesArray:respInfo[@"m_list"]];
                
            }else{
                [MBProgressHUD showTipMessageInView:respInfo[@"ERRORDESTRIPTION"]];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"网路问题..."];
        }
        [weakSelf.p_collectionView reloadData];
    }];


}



@end
