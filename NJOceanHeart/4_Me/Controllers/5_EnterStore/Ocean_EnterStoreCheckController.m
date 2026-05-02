//
//  Ocean_EnterStoreCheckController.m
//  NJOceanHeart
//
//  Created by 陈恺雄 on 2017/8/9.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_EnterStoreCheckController.h"
#import "Ocean_Ocean_EnterStoreCheckModel.h"
@interface Ocean_EnterStoreCheckController ()<UISearchBarDelegate>
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UILabel *idcardLabel;
@property (nonatomic, strong)UILabel *shopLabel;
@property (nonatomic, strong)UILabel *resultLabel;
@property (nonatomic, strong)UILabel *classLabel;

@property (nonatomic, strong)UISearchBar *searchBarr;
@property (nonatomic, strong)Ocean_Ocean_EnterStoreCheckModel *model;

@end

@implementation Ocean_EnterStoreCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightlightGrayColor];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 15, 15);
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"main_search"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

    _searchBarr = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 36)];
    _searchBarr.delegate = self;
    _searchBarr.frame = CGRectMake(0, 0, 100, 36);
    self.navigationItem.titleView = _searchBarr;
    
    [self initView];
    
}
- (void)search{
    [self searchBarSearchButtonClicked:_searchBarr];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSDictionary *dict = @{@"m_phone":searchBar.text
                           };
    [HttpRequestTools requestUserInfoWithData:dict methodName:@"GETSHOPINFO" completion:^(id respInfo, NSError *error) {
        if (!error) {
            _model = [Ocean_Ocean_EnterStoreCheckModel mj_objectWithKeyValues:respInfo];
            if ([respInfo[@"ERRORCODE"] isEqualToString:@"0000"]) {
                _nameLabel.text = [NSString stringWithFormat:@"%@%@",_nameLabel.text,_model.m_name];
                _phoneLabel.text =  [NSString stringWithFormat:@"%@%@",_phoneLabel.text,_model.m_phone];
                _idcardLabel.text = [NSString stringWithFormat:@"%@%@",_idcardLabel.text,_model.m_cardno];
                _shopLabel.text = [NSString stringWithFormat:@"%@%@",_shopLabel.text,_model.m_shopname];
                _classLabel.text = [NSString stringWithFormat:@"%@%@",_classLabel.text,_model.m_gbcname];

                NSString *str1 = @"查询结果:";
                NSString *str2 = @"";
                if ([_model.m_checkflag isEqualToString:@"Y"]) {
                    str2 = @"通过";
                } else if ([_model.m_checkflag isEqualToString:@"N"]) {
                    str2 = @"不通过";
                } else if ([_model.m_checkflag isEqualToString:@"O"]) {
                    str2 = @"待审核";
                } else if ([_model.m_checkflag isEqualToString:@"W"]) {
                    str2 = @"待支付";
                }
                NSString *str3 = _model.m_reson?_model.m_reson:@"";
                NSString *str4 = [NSString stringWithFormat:@"%@ %@ %@",str1,str2,str3];
                NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:str4];
                [result addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, str1.length)];
                [result addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(str1.length, str2.length)];
                [result addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(str2.length, str3.length)];
                _resultLabel.attributedText = result;
            }
            else {
                [MBProgressHUD showInfoMessage:respInfo[@"ERRORDESTRIPTION"]];
            }
        } else {
            [MBProgressHUD showInfoMessage:respInfo[@"ERRORDESTRIPTION"]];
        }
    }];
}
- (void)initView{
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 5;
    [self.view addSubview:_backView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"姓名:";
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor lightGrayColor];
    [_backView addSubview:_nameLabel];
    
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.text = @"电话:";
    _phoneLabel.textAlignment = NSTextAlignmentLeft;
    _phoneLabel.textColor = [UIColor lightGrayColor];
    [_backView addSubview:_phoneLabel];
    
    _idcardLabel = [[UILabel alloc] init];
    _idcardLabel.text = @"身份证:";
    _idcardLabel.textAlignment = NSTextAlignmentLeft;
    _idcardLabel.textColor = [UIColor lightGrayColor];
    [_backView addSubview:_idcardLabel];
    
    _shopLabel = [[UILabel alloc] init];
    _shopLabel.text = @"商铺名称:";
    _shopLabel.textAlignment = NSTextAlignmentLeft;
    _shopLabel.textColor = [UIColor lightGrayColor];
    [_backView addSubview:_shopLabel];
    
    
    _classLabel = [[UILabel alloc] init];
    _classLabel.text = @"商铺分类:";
    _classLabel.textAlignment = NSTextAlignmentLeft;
    _classLabel.textColor = [UIColor lightGrayColor];
    [_backView addSubview:_classLabel];
    
    _resultLabel = [[UILabel alloc] init];
    _resultLabel.text = @"查询结果:";
    _resultLabel.textAlignment = NSTextAlignmentLeft;
    _resultLabel.textColor = [UIColor blueColor];
    [_backView addSubview:_resultLabel];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).with.offset(15);
        make.right.mas_equalTo(self.view).with.offset(-15);
        make.top.mas_equalTo(self.view).with.offset(70);
        make.height.mas_equalTo(360);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backView).with.offset(15);
        make.top.mas_equalTo(_backView).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backView).with.offset(150);
        make.top.mas_equalTo(_backView).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    [_idcardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left);
        make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(300, 30));
    }];
    
    [_shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left);
        make.top.mas_equalTo(_idcardLabel.mas_bottom).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(300, 30));
    }];
    
    
    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left);
        make.top.mas_equalTo(_shopLabel.mas_bottom).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(300, 30));
    }];
    
    
    
    [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left);
        make.top.mas_equalTo(_classLabel.mas_bottom).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(300, 30));
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_searchBarr resignFirstResponder];
}
@end
