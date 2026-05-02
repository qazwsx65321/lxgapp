//
//  FTImageInputView.m
//  X19.HundredSchoolForum
//
//  Created by 史伟文 on 16/12/23.
//  Copyright © 2016年 NanJing. All rights reserved.
//

#import "FTImageInputView.h"
#import "FTImageInputCell.h"
#import "ZLPhoto.h"
#import "ZLCameraViewController.h"
#import "UIImage+Transcoding.h"

@interface FTImageInputView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIActionSheetDelegate, ZLPhotoPickerBrowserViewControllerDelegate, ZLPhotoPickerBrowserViewControllerDataSource>


@property (nonatomic, strong)UIViewController *rootViewController;


@end

@implementation FTImageInputView

#pragma mark - variable getter and setter method
- (NSMutableArray *)images{
    if (!_images) {
        
        _images = [NSMutableArray array];
    }
    return _images;
}

- (UIViewController *)rootViewController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)setImageCount:(NSInteger)imageCount
{
    _imageCount = imageCount;
    self.leftCount = self.imageCount;
}

- (void)setLeftCount:(NSInteger)leftCount
{
    _leftCount = leftCount;
}

- (NSMutableArray *)imageDatas
{
    if (!_imageDatas) {
        _imageDatas = [NSMutableArray array];
    }
    return _imageDatas;
}

- (NSMutableArray *)imagePix
{
    if (!_imagePix) {
        _imagePix = [NSMutableArray array];
    }
    return _imagePix;
}

- (NSMutableArray *)imageFullDatas
{
    if (!_imageFullDatas) {
        _imageFullDatas = [NSMutableArray array];
    }
    return _imageFullDatas;
}
- (NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}


#pragma mark - initialize method
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(50, 50);
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[FTImageInputCell class] forCellWithReuseIdentifier:@"FTImageInputCell"];
        [self addSubview:collectionView];
        self.collectionView = collectionView;
    }
    return self;
}





#pragma mark - layout method
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

#pragma mark - collection view delegate and data source method
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.images.count < self.imageCount) {
        return self.images.count+1;
    } else {
        return self.images.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FTImageInputCell *cell = [FTImageInputCell cellWithIndexPath:indexPath collectionView:collectionView];
    if (indexPath.item == self.images.count) {
        cell.imageView.image = [UIImage imageNamed:@"shangchuan_img"];
    } else {
        NSObject *obj = self.images[indexPath.item];
        if ([obj isKindOfClass:[ZLPhotoAssets class]]) {
            ZLPhotoAssets *asset = self.images[indexPath.item];
            cell.imageView.image = asset.thumbImage;
        }else{
            NSString *url = self.images[indexPath.item];
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        }
      
    }
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item < self.images.count) {
        ZLPhotoPickerBrowserViewController *imageBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
        imageBrowser.delegate = self;
        imageBrowser.dataSource = self;
        imageBrowser.currentIndexPath = indexPath;
        [self.rootViewController presentViewController:imageBrowser animated:YES completion:nil];
    } else {
        
        if (indexPath.item == self.images.count) {
            if (self.images.count >= self.imageCount) {
                [self showAlertView:[NSString stringWithFormat:@"您最多只能上传%zd张照片",self.imageCount]];
                return;
            } else {
                [self selectPhotos];
            }
        }
    }
}

#pragma mark - photo browser data source and delegate method
- (NSInteger)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    return self.images.count;
}

- (ZLPhotoPickerBrowserPhoto *)photoBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    id imageObj = [self.images objectAtIndex:indexPath.item];
    ZLPhotoPickerBrowserPhoto *photo = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:imageObj];
    // 包装下imageObj 成 ZLPhotoPickerBrowserPhoto 传给数据源
    FTImageInputCell *cell = (FTImageInputCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    // 缩略图
    if ([imageObj isKindOfClass:[ZLPhotoAssets class]]) {
        photo.asset = imageObj;
    }
    photo.toView = cell.imageView;
    photo.thumbImage = cell.imageView.image;
    return photo;
}

#pragma mark - camera and album method
//进入相机
-(void)openCamera
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        ZLCameraViewController *camreaVc = [[ZLCameraViewController alloc] init];
        camreaVc.maxCount = self.leftCount;
        [[self topViewController] presentViewController:camreaVc animated:YES completion:nil];
        // 拍照回调
        camreaVc.callback = ^(NSArray *assets){
            self.leftCount = self.imageCount - assets.count;
            for (NSUInteger i = 0; i < assets.count; i ++) {
                ZLCamera *cameraImage = assets[i];
                [self.images addObject:cameraImage];
                [self.imageArr addObject:[cameraImage photoImage]];
                [self.imageDatas addObject:[[cameraImage photoImage] imageToBase64Data]];
                [self.imagePix addObject:@"jpg"];
                NSString *imageFullData = [NSString stringWithFormat:@"%@;jpg",[[cameraImage photoImage] imageToBase64Data]];
                [self.imageFullDatas addObject:imageFullData];
            }
            [self.collectionView reloadData];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"checkImageFinish" object:self];
            
            
        };
    } else {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开相册
-(void)enterAlbum
{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.status = PickerViewShowStatusGroup;
    pickerVc.maxCount = self.leftCount;
    [[self topViewController] presentViewController:pickerVc animated:YES completion:nil];
    // 选取相册的回调
    pickerVc.callBack = ^(NSArray *assets){
        self.leftCount = self.imageCount - assets.count;
        for (NSUInteger i = 0; i < assets.count; i ++) {
            ZLPhotoAssets *photoImage = assets[i];
            [self.images addObject:photoImage];
            [self.imageDatas addObject:[[photoImage originImage] imageToData]];
            [self.imageArr addObject:[photoImage originImage]];
            [self.imagePix addObject:@".jpg"];
            NSString *imageFullData = [NSString stringWithFormat:@"%@;jpg",[[photoImage originImage] imageToBase64Data]];
            [self.imageFullDatas addObject:imageFullData];
            
            
        }
        [_delegate imageInputViewDidSelectButton:[self.imageFullDatas copy]];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"checkImageFinish" object:self];
        
        [self.collectionView reloadData];
    };
}

#pragma mark - action sheet and alert view delegate method
- (void)selectPhotos {
    
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"从相机拍摄",@"从相册获取",nil];
    
    [myActionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            //打开照相机拍照
            [self openCamera];
        }
            break;
        case 1:
        {
            //打开本地相册
            [self enterAlbum];
        }
            break;
    }
}

- (void)showAlertView:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alertView show];
}

- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:self.window.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


@end
