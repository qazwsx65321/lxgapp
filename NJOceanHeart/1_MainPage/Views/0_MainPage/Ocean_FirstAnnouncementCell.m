//
//  Ocean_FirstAnnouncement wCell.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/6/19.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_FirstAnnouncementCell.h"
#import "autoScrollUpAndDown.h"
#import "Ocean_FIRSTPAGESHOWModel.h"
#import "OLImage.h"
#import "OLImageView.h"
@interface Ocean_FirstAnnouncementCell()<autoScrollUpAndDownDelegate>

@property(nonatomic,weak)autoScrollUpAndDown *p_autoScroll;
@property (nonatomic,strong) OLImageView *p_Aimv;
@property(nonatomic,weak)UIImageView *p_imageV;

@end
#define imageX   10
#define imageW   19
@implementation Ocean_FirstAnnouncementCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        OLImageView *Aimv = [[OLImageView alloc] initWithImage:[OLImage imageNamed:@"XDGonggao.gif"]];
        [Aimv setUserInteractionEnabled:YES];
        [self.contentView addSubview:Aimv];
        self.p_Aimv =Aimv;
        
//        UIImageView *imageV = [[UIImageView alloc]init];
//        NSString *path =  ProjectListPath(@"gonggao",@"gif");
////        [self.p_imageV sd_setAnimationImagesWithURLs:@[[NSURL URLWithString:path]]];
//        UIImage *image = [UIImage sd_animatedGIFWithData:[[NSData alloc]initWithContentsOfFile:path]];
//        imageV.image = image;
//        self.p_imageV = imageV;
//        [self.contentView addSubview:imageV];
        
        autoScrollUpAndDown * scrollUpDown = [[autoScrollUpAndDown alloc]initWithFrame:CGRectMake(0, screen_Width/2.0, screen_Width -imageX-imageW-49, 39)];
        scrollUpDown.delegate = self;
        self.p_autoScroll = scrollUpDown;
        [self.contentView addSubview:scrollUpDown];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setP_noticationArr:(NSArray *)p_noticationArr{
    
    if (_p_noticationArr != p_noticationArr) {
        _p_noticationArr = p_noticationArr;
        self.p_autoScroll.m_infoArr = p_noticationArr;
    }
}



-(void)layoutSubviews{
    [super layoutSubviews];
    self.p_Aimv.x = imageX;
    self.p_Aimv.height = 30;
    self.p_Aimv.width =self.p_Aimv.height *200/64;
    self.p_Aimv.y = (self.height - self.p_Aimv.height)/2.0;
    
    self.p_autoScroll.x = CGRectGetMaxX(self.p_Aimv.frame)+10;
    self.p_autoScroll.width = self.width - self.p_autoScroll.x - 10;
    self.p_autoScroll.height = self.height;
    self.p_autoScroll.centerY = self.p_Aimv.centerY;
    
}

-(void)TapView:(autoScrollUpAndDown *)view andChoosenum:(NSInteger )num{
    
    if (self.p_noticationArr.count) {
        announcementModel*model = self.p_noticationArr[num];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ScorllerInfoArr" object:model];
    }
    
    
}


@end
