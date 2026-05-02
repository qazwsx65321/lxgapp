//
//  XRPhotoView.h
//  XRElectricMall
//
//  Created by 史伟文 on 16/2/24.
//  Copyright © 2016年 XuanRuiTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRPhotoView : UIView

@property (nonatomic, strong)NSArray *images;

@property (nonatomic,assign) BOOL isBlowUp;

- (instancetype)initWithUserInteraciton:(BOOL)inter;
+ (CGSize)sizeWithImageCount:(NSUInteger)count;

@end
