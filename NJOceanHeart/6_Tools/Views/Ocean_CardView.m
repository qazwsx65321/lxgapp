//
//  Ocean_CardView.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/23.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_CardView.h"

@implementation Ocean_CardView

+(instancetype)initWithBackImageName:(NSString *)backImageName Frame:(CGRect)rect TopImage:(NSString *)topImageName IconImage:(NSString *)iconName bottomImage:(NSString *)bottomName cardNameImage:(NSString *)cardName{
    
    NSString * iamgePath = [[NSBundle mainBundle]pathForResource:@"OceanCardImage" ofType:@"bundle"];
    Ocean_CardView * cardView = [[self alloc]initWithImage:[UIImage imageWithContentsOfFile:[iamgePath stringByAppendingPathComponent:backImageName]]];
    cardView.frame = rect;
    //上部图片
    CGFloat topW = cardView.width *588/638;
    CGFloat topH = topW *283/2152;
    CGFloat topY = cardView.height *10/400;
    CGFloat topX = (cardView.width -topW)/2;
    UIImageView *topImage = [self creatImageView:topImageName andRect:CGRectMake(topX, topY, topW, topH) andBackView:cardView];
    [cardView addSubview:topImage];

    //头像图片
    CGFloat IconW = cardView.height *90/245;
    CGFloat IconH = IconW;
    CGFloat IconY = (cardView.height  -IconH)/2;
    CGFloat IconX = cardView.width *29/357;
    UIImageView *IconImage = [self creatImageView:iconName andRect:CGRectMake(IconX, IconY, IconW, IconH) andBackView:cardView];
    [cardView addSubview:IconImage];
    [IconImage sd_setImageWithURL:[NSURL URLWithString:iconName]];
    

    //下部图片
    CGFloat bottomW = cardView.width *187/357;
    CGFloat bottomH = bottomW *189/1233;
    CGFloat bottomY = cardView.height - bottomH -cardView.height *9/245;
    CGFloat bottomX = (cardView.width -bottomW)/2;
    UIImageView *bottomImage = [self creatImageView:bottomName andRect:CGRectMake(bottomX, bottomY, bottomW, bottomH) andBackView:cardView];
    [cardView addSubview:bottomImage];
    
    //中间文字
    CGFloat cardW = cardView.width *80/357;
    CGFloat cardH = bottomW *30/80;
    CGFloat cardY = (cardView.height -cardH)/2;
    CGFloat cardX = cardView.width -cardW - cardView.width *70/357;
    UIImageView *cardImage = [self creatImageView:cardName andRect:CGRectMake(cardX, cardY, cardW, cardH) andBackView:cardView];
    [cardView addSubview:cardImage];
        return cardView;
}

+(UIImageView *)creatImageView:(NSString *)imageName andRect:(CGRect)frame andBackView:(UIView *)backView{
    
    NSString * iamgePath = [[NSBundle mainBundle]pathForResource:@"OceanCardImage" ofType:@"bundle"];
    UIImageView *imageV =[[UIImageView alloc]initWithImage:[UIImage imageWithContentsOfFile:[iamgePath stringByAppendingPathComponent:imageName]]];
    imageV.frame = frame;
    return imageV;
}


@end
