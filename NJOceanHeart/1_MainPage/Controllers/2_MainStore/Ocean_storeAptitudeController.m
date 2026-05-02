//
//  Ocean_ storeAptitudeController.m
//  NJOceanHeart
//
//  Created by qiushi on 2017/7/28.
//  Copyright © 2017年 Xuanr. All rights reserved.
//

#import "Ocean_storeAptitudeController.h"
#import "Ocean_ImageViewCell.h"
#import "Ocean_MainStoreShopModel.h"
#import "Ocean_RevicedImageTool.h"
@interface Ocean_storeAptitudeController ()<Ocean_RevicedImageToolDelegate>

//@property (nonatomic,strong) Ocean_RevicedImageTool * tool;

@property (nonatomic,strong) NSArray * p_picArr;

@end

@implementation Ocean_storeAptitudeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.infomodel judgeObjectPropertyNull];
//    self.infomodel.m_threelicense = @"http://show.xuanrui68.com/XuanR_HyZxSoftWare_Server/userpic/08161625409530.png";
//    self.infomodel.m_license = @"http://show.xuanrui68.com/XuanR_HyZxSoftWare_Server/userpic/08162123352030.jpg";
//    self.infomodel.m_orgcode = @"http://show.xuanrui68.com/XuanR_HyZxSoftWare_Server/userpic/1741321F5B64465389506D209D2C6519x.png";
//    self.infomodel.m_taxreg = @"http://imgsrc.baidu.com/image/c0%3Dshijue1%2C0%2C0%2C294%2C40/sign=ea57f833b91bb0519b29bb6b5e13b0c1/f9198618367adab409cdef5281d4b31c8701e486.jpg";
    self.tableView.tableHeaderView = [self headView];
    if ([@"2" isEqualToString:self.infomodel.m_certype]) {
        //三合一
        
        Ocean_RevicedImageTool *tool =  [[Ocean_RevicedImageTool alloc]initWithUrl:self.infomodel.m_threelicense];
        tool.delegate = self;
        self.p_picArr = @[tool];
    }else{
        //三个
        Ocean_RevicedImageTool *tool1 =  [[Ocean_RevicedImageTool alloc]initWithUrl:self.infomodel.m_license];
        tool1.delegate = self;
        Ocean_RevicedImageTool *tool2 =  [[Ocean_RevicedImageTool alloc]initWithUrl:self.infomodel.m_orgcode];
        tool2.delegate = self;

        Ocean_RevicedImageTool *tool3 =  [[Ocean_RevicedImageTool alloc]initWithUrl:self.infomodel.m_taxreg];
        tool3.delegate = self;
        self.p_picArr = @[tool1,tool2,tool3];
    }

    self.tableView.tableFooterView = [UIView new];
  
    
}

-(void)RevicedImageReloadPreView{


    [self.tableView reloadData];
    
}


-(UIView *)headView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 40)];
    UILabel *titlabel = [[UILabel alloc]initWithFrame:CGRectMake(10,0, screen_Width-20, 40)];
    titlabel.font = [UIFont systemFontOfSize:15];
    titlabel.text = @"商家从业资质";
    titlabel.textColor = [UIColor lightGrayColor];
    [headView addSubview:titlabel];
    return headView;
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.p_picArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Ocean_ImageViewCell *cell = [Ocean_ImageViewCell cellWithTableView:tableView andImageInsets:UIEdgeInsetsMake(0, 10, 15, 10)];
    Ocean_RevicedImageTool*tool = self.p_picArr[indexPath.row];
    cell.imageView.image = tool.image;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    Ocean_RevicedImageTool*tool = self.p_picArr[indexPath.row];
    CGFloat W = tool.image.size.width;
    CGFloat H = tool.image.size.height;
    CGFloat CellH = 80;
    if (W>0) {
        CellH = ((screen_Width - 20) *H/W) + 15;
    }
    return CellH;
}


@end
