//
//  Ocean_CardView.h
//  NJOceanHeart
//
//  Created by qiushi on 2017/8/23.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ocean_CardView : UIImageView
+(instancetype)initWithBackImageName:(NSString *)backImageName
                               Frame:(CGRect)rect
                            TopImage:(NSString *)topImageName
                           IconImage:(NSString *)iconName
                         bottomImage:(NSString *)bottomName
                       cardNameImage:(NSString *)cardName;

@end
