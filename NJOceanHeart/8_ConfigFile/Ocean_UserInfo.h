//
//  Ocean_UserInfo.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/17.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ocean_UserInfo : NSObject

singleton_h(Ocean_UserInfo)

@property (nonatomic,assign) BOOL isLogin;

@property (nonatomic, strong) NSString *m_householdregister;

@property (nonatomic,strong) NSString * udid;

@property (nonatomic, strong) NSString *m_spreadcode;

@property (nonatomic, strong) NSString *m_name;

@property (nonatomic, strong) NSString *m_comtel;

@property (nonatomic, strong) NSString *m_house;

@property (nonatomic, strong) NSString *m_bankname;

@property (nonatomic, strong) NSString *m_nationality;

@property (nonatomic, strong) NSString *m_housetel;

@property (nonatomic, strong) NSString *m_comnature;

@property (nonatomic, strong) NSString *ERRORCODE;

@property (nonatomic, strong) NSString *m_department;

@property (nonatomic, strong) NSString *m_checkflag;

@property (nonatomic, strong) NSString *m_houseaddress;

@property (nonatomic, strong) NSString *m_qq;

@property (nonatomic, strong) NSString *m_cardid;

@property (nonatomic, strong) NSString *m_licenseplate;

@property (nonatomic, strong) NSString *m_edulevel;

@property (nonatomic, strong) NSString *m_bankno;

@property (nonatomic, strong) NSString *m_cardtime;

@property (nonatomic, strong) NSString *m_lockbalance;

@property (nonatomic, strong) NSString *m_username;

@property (nonatomic, strong) NSString *m_wechat;

@property (nonatomic, strong) NSString *m_istop;

@property (nonatomic, strong) NSString *m_cardno;

@property (nonatomic, strong) NSString *m_tradetype;

@property (nonatomic, strong) NSString *m_housecode;

@property (nonatomic, strong) NSString *m_session;

@property (nonatomic, strong) NSString *m_headpic;

@property (nonatomic, strong) NSString *m_sex;

@property (nonatomic, strong) NSString *m_jobname;

@property (nonatomic, strong) NSString *m_company;

@property (nonatomic, strong) NSString *m_fcardpic;

@property (nonatomic, strong) NSString *m_cardtype;

@property (nonatomic, strong) NSString *m_zcardpic;

@property (nonatomic, strong) NSString *m_nickname;

@property (nonatomic, strong) NSString *m_birthday;

@property (nonatomic, strong) NSString *m_worklife;

@property (nonatomic, strong) NSString *m_balance;

@property (nonatomic, strong) NSString *m_marriage;

@property (nonatomic, strong) NSString *m_comcode;

@property (nonatomic, strong) NSString *m_comaddress;

@property (nonatomic, strong) NSString *m_uid;

@property (nonatomic, strong) NSString *m_yearsalary;

@property (nonatomic, strong) NSString *m_touxiang;

@property (nonatomic, strong) NSString *m_cardname;

@property (nonatomic, strong) NSString *m_issuing;

@property (nonatomic, strong) NSString *m_tworklife;

@property (nonatomic, strong) NSString *m_token;

@property (nonatomic, strong) NSString *m_cardcode;

@property (nonatomic, strong) NSString *m_imagetime;

@property (nonatomic, strong) NSString *m_phone;

@property (nonatomic,strong) NSString * m_cardPrice;

@property (nonatomic,strong) NSString * m_qq_email;

@property (nonatomic,strong) NSString * m_registPhone;

//登陆获取数据,存储在钥匙串中;
-(void)setInfoData;
//获取钥匙串数据,并赋值对象;
-(void)initInfoData;
//单个属性,设置并更新到钥匙串中;
-(void)saveValue:(NSString *)value forKey:(NSString *)key;
//删除钥匙串中保存的数据
-(void)removeKeyChain;

@end
