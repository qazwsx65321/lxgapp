//
//  XRPhotoView.m
//  XRElectricMall
//
//  Created by 史伟文 on 16/2/24.
//  Copyright © 2016年 XuanRuiTechnology. All rights reserved.
//

#define kPhotoWH 70
#define kPhotoMargin 10
#define kMaxCol(count) ((count==4)?2:3)

#import "XRPhotoView.h"
#import "ZLPhotoPickerBrowserViewController.h"

@interface XRPhotoView()<UIGestureRecognizerDelegate,ZLPhotoPickerBrowserViewControllerDataSource,ZLPhotoPickerBrowserViewControllerDelegate>

@property (nonatomic, assign)BOOL inter;
@property(nonatomic,strong)UIViewController *rootViewController;
@end


@implementation XRPhotoView

- (UIViewController *)rootViewController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}


- (instancetype)initWithUserInteraciton:(BOOL)inter
{
    self = [super init];
    if (self) {
        self.inter = inter;
    }
    return self;
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    NSInteger imageCount = images.count;
    
    int item = 0;
    while (self.subviews.count < images.count) {
        UIImageView *imageView = [[UIImageView alloc] init];
        if (self.inter == YES) {
            imageView.userInteractionEnabled = YES;
        } else {
            imageView.userInteractionEnabled = YES;
        }
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        imageView.tag = item + 1000;
        if (self.isBlowUp) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
            tap.delegate = self;
            [imageView addGestureRecognizer:tap];
        }
        item ++;
    }
    
    
    for (int i = 0; i < self.subviews.count; i ++) {
        UIImageView *imageView = self.subviews[i];
        if (i < imageCount) {
            imageView.hidden = NO;
            NSString *image = images[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"placehodelPic"]];
            
        } else {
            imageView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int imageCount = (int)self.images.count;
    int maxCol = kMaxCol(imageCount);
    for (int i = 0; i < imageCount; i ++) {
        UIImageView *imageView = self.subviews[i];
        
        int col = i % maxCol;
        imageView.x = col * (kPhotoWH + kPhotoMargin);
        
        int row = i / maxCol;
        imageView.y = row * (kPhotoWH + kPhotoMargin);
        imageView.width = kPhotoWH;
        imageView.height = kPhotoWH;
        
    }
}

+ (CGSize)sizeWithImageCount:(NSUInteger)count
{
    
    int maxCol = kMaxCol(count);
    
    int cols = count >= maxCol ? maxCol : (int)count;
    CGFloat photoW = cols * kPhotoWH + (cols - 1) * kPhotoMargin;
    
    int rows = (int)((count + maxCol - 1) / maxCol);
    CGFloat photoH = rows * kPhotoWH + (rows - 1) * kPhotoMargin;
    
    return CGSizeMake(photoW, photoH);
}

- (void)tapImage:(UIGestureRecognizer *)recog
{
        NSLog(@"%zd", recog.view.tag);
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[@"tag"] = @(recog.view.tag);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WECTapCircleImageNotification" object:nil userInfo:userInfo];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:recog.view.tag-1000 inSection:0];
    ZLPhotoPickerBrowserViewController *imageBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    imageBrowser.delegate = self;
    imageBrowser.dataSource = self;
    imageBrowser.currentIndexPath = path;
    [self.rootViewController presentViewController:imageBrowser animated:YES completion:nil];
     
    
}

-(NSInteger)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    return self.subviews.count;
}



- (ZLPhotoPickerBrowserPhoto *)photoBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    UIImageView *image = self.subviews[indexPath.item];
    //    id imageObj = [self.images objectAtIndex:indexPath.item];
    ZLPhotoPickerBrowserPhoto *photo = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:image.image];
    //    // 包装下imageObj 成 ZLPhotoPickerBrowserPhoto 传给数据源
    //    XRImageInputCell *cell = (XRImageInputCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    //    // 缩略图
    //    if ([imageObj isKindOfClass:[ZLPhotoAssets class]]) {
    //        photo.asset = imageObj;
    //    }
    photo.toView = self.subviews[indexPath.item];
    //    photo.thumbImage = cell.imageView.image;
    
    return photo;
}


@end
