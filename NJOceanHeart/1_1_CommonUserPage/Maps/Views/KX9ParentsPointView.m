//
//  KX9ParentsPointView.m
//  Glad9TM
//
//  Created by qiushi on 2017/6/1.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "KX9ParentsPointView.h"
#import "KX9ParentsPointFlag.h"
@interface KX9ParentsAlterView:UIView

@property (nonatomic,weak) UIImageView * p_imageV;
@property (nonatomic,weak) UILabel * p_titleLb;
@property (nonatomic,weak) UILabel * p_contentLb;


@end

@implementation KX9ParentsAlterView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *back = [[UIImageView alloc]init];
        back.image = [UIImage imageNamed:@"dhk"];
        [self addSubview:back];
        self.p_imageV = back;
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.text = @"您的父母现在位置是:";
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.font = [UIFont systemFontOfSize:13];
        self.p_titleLb = titleLb;
        [self addSubview:titleLb];
    
        UILabel *contentLb = [[UILabel alloc]init];
        self.p_contentLb = contentLb;
        NSString *content = @"\"江苏省森林公园\"";
        contentLb.text = content;
        contentLb.textAlignment = NSTextAlignmentCenter;
        contentLb.font = [UIFont systemFontOfSize:13];
        contentLb.textColor = RGB(74, 186, 106);
        [self addSubview:contentLb];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.p_imageV.frame = self.bounds;
    self.p_titleLb.x = 0;
    self.p_titleLb.width = self.width;
    self.p_titleLb.height = 14;
    self.p_titleLb.y = 15;

    self.p_contentLb.x = 0;
    self.p_contentLb.width = self.width;
    self.p_contentLb.height = 14;
    self.p_contentLb.y =  self.p_titleLb.bottom +15;
}



@end


@interface KX9ParentsPointView()

@property (nonatomic,weak) UIImageView * p_carImageView;
@property (nonatomic,weak) UIButton * p_button;
@property (nonatomic,strong) KX9ParentsAlterView  * p_AlterView;


@end

@implementation KX9ParentsPointView


-(KX9ParentsAlterView *)p_AlterView{
    if (!_p_AlterView ) {
        _p_AlterView = [[KX9ParentsAlterView alloc]init];
    }
    return _p_AlterView;
}


- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *CarImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopdetail"]];
        [CarImageV sizeToFit];
        self.p_carImageView = CarImageV;
        [self addSubview:CarImageV];
     
        self.p_button.x = self.p_carImageView.right -2;
        self.p_button.bottom = self.p_carImageView.y+2;
        [self setBounds: CGRectUnion(self.p_carImageView.frame, self.p_button.frame)];
       
        KX9ParentsPointFlag *pointflag = (KX9ParentsPointFlag*)annotation;
        NSString *title = [NSString stringWithFormat:@"\"%@\"所在位置:",pointflag.name];
        NSString *content = [NSString stringWithFormat:@"\"%@\"",pointflag.address];

        
        self.p_AlterView.p_titleLb.text = title;
        self.p_AlterView.p_contentLb.text = content;
        CGSize size1 =[StringSizeModel sizeWithText:title font:[UIFont systemFontOfSize:13]];
        CGSize size2 =[StringSizeModel sizeWithText:content font:[UIFont systemFontOfSize:13]];
        CGFloat max = MAX(size1.width, size2.width);
        self.p_AlterView.size = CGSizeMake(max+20, 80);
        self.paopaoView =  [[BMKActionPaopaoView alloc]initWithCustomView:self.p_AlterView];
        self.calloutOffset = CGPointMake(self.p_AlterView.width/2-35+8, 5);
//        [self addSubview:cameraButton];
        
    }
    return self;
}


@end
