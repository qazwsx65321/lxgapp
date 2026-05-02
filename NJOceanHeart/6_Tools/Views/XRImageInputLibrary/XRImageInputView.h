//
//  XRImageInputView.h
//  AssertLibraryDemo
//
//  Created by 史伟文 on 15/12/1.
//  Copyright (c) 2015年 XuanRuiTechnology. All rights reserved.
//

/*
 
 基本使用方法
 1.创建：
 XRImageInputView *imageInputView = [[XRImageInputView alloc] init];
 imageInputView.frame = ...;
 imageInputView.imageCount = ...;
 [self.view addSubview:imageInputView];
 
 2.获取图片数据
 imageInputView.imageDatas
 
 */

#import <UIKit/UIKit.h>

@class XRImageInputView;

@protocol XRImageInputViewDelegate <NSObject>

- (void)imageInputViewDidSelectButton:(NSArray *)imageInputView;

@end

@interface XRImageInputView : UIView
@property(nonatomic,weak)id <XRImageInputViewDelegate> delegate;
/** 传入数据：设置最大能够选择的图片数量，必须传入 */
@property (nonatomic, assign)NSInteger imageCount;
@property (nonatomic, weak)UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *images;
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


