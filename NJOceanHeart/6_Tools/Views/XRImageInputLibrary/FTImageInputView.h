//
//  FTImageInputView.h
//  X19.HundredSchoolForum
//
//  Created by 史伟文 on 16/12/23.
//  Copyright © 2016年 NanJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FTImageInputViewDelegate <NSObject>

- (void)imageInputViewDidSelectButton:(NSArray *)imageInputView;

@end

@interface FTImageInputView : UIView

@property(nonatomic,weak)id <FTImageInputViewDelegate> delegate;

@property (nonatomic, strong)NSMutableArray *images;
@property (nonatomic, assign)NSInteger leftCount;


/** 传入数据：设置最大能够选择的图片数量，必须传入 */
@property (nonatomic, assign)NSInteger imageCount;
@property (nonatomic, weak)UICollectionView *collectionView;

// 方式一：图片和后缀分开获取
/** 获取数据：图片数据数组（base64编码后） */
@property (nonatomic, strong)NSMutableArray *imageDatas;
/** 获取数据：图片格式数组 */
@property (nonatomic, strong)NSMutableArray *imagePix;

// 方式二：图片和后缀在一起（例如："16548949856165165;png","26599984665;jpg","4649846519489;jpg"）
@property (nonatomic, strong)NSMutableArray *imageFullDatas;

//方式三：直接获取图片
@property (nonatomic, strong)NSMutableArray *imageArr;

@end
