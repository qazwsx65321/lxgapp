//
//  ServiceLocationController.m
//  X15.YiXiuDa
//
//  Created by GXJ on 16/10/17.
//  Copyright © 2016年 XuanRuiTechnology. All rights reserved.
//

#import "ServiceLocationController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import<BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Map/BMKAnnotationView.h>
//#import "CustomLocationController.h"
@interface ServiceLocationController ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKMapViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,BMKPoiSearchDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)BMKMapView *mapView;
@property(nonatomic,strong)BMKLocationService *locService;
@property(nonatomic,strong)	BMKGeoCodeSearch* geocodesearch;
@property(nonatomic,strong)BMKPointAnnotation *pointView;
@property(nonatomic,strong)NSArray *AddressArr;
@property(nonatomic,weak)UITableView *p_tabelView;
@property(nonatomic,strong)BMKPoiSearch*searchServer;
@property(nonatomic,weak)UIImageView *p_imageView;
@property(nonatomic,strong)UILabel *iconView;
@property(nonatomic,strong)BMKUserLocation *myLocation;
@property (nonatomic,strong) BMKAddressComponent * p_addressComponent;

@end

@implementation ServiceLocationController


-(UILabel *)iconView{
    if (!_iconView) {
        _iconView = [[UILabel alloc]init];
        _iconView.height = 20;
        _iconView.y = self.p_imageView.y-_iconView.height-2;
        _iconView.font = [UIFont systemFontOfSize:12];
        _iconView.textColor = RGB(187, 188, 189);
        _iconView.layer.cornerRadius = 4;
        _iconView.layer.masksToBounds =YES;
        _iconView.textAlignment = NSTextAlignmentCenter;
        _iconView.backgroundColor= [[UIColor blackColor] colorWithAlphaComponent:0.75];
        [_mapView addSubview:self.iconView];

    }
    return _iconView;
}

-(BMKPoiSearch *)searchServer{
    if (!_searchServer) {
        _searchServer = [[BMKPoiSearch alloc]init];
        _searchServer.delegate = self;
    }
    return _searchServer;
}

-(NSArray *)AddressArr{
    if (!_AddressArr) {
        _AddressArr = [NSArray array];
        
    }
    return _AddressArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"选取地址";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
        
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0,0, self.view.width, (self.view.height-64)/2)];
    
    UIImageView *imageview = [[UIImageView alloc]init];
    
    imageview.width = 18;
    imageview.height = 30;
    imageview.x = (_mapView.width-imageview.width)/2;
    imageview.y = (_mapView.height-imageview.height)/2-imageview.height/2;
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"point"];
    [_mapView addSubview:imageview];
    
    BMKCoordinateRegion region ;//表示范围的结构体
    region.center =  CLLocationCoordinate2DMake(32.0150760000,118.7739430000);//中心点
    //纬度范围
    [_mapView setRegion:region animated:YES];
    self.p_imageView = imageview;
    [self.view addSubview:_mapView];
    
    //下面的列表
    UITableView *tabel = [[UITableView alloc]init];
    tabel.frame = self.view.bounds;
    tabel.y = CGRectGetMaxY(_mapView.frame);
    tabel.height = self.view.height -tabel.y;
    tabel.delegate = self;
    tabel.dataSource = self;
    self.p_tabelView = tabel;
    [self.view addSubview:tabel];
    

    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.AddressArr.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellsign = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellsign];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellsign];
    }
    
    BMKPoiInfo *info = self.AddressArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"map-pin"];
    cell.textLabel.text = info.name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = info.address;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}
#pragma mark -选择cell跳转到前一页，并标记。
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.AddressArr);
    
    if (tableView.y >200) {
        BMKPoiInfo *poi =  self.AddressArr[indexPath.row];
        
        NSString *address = [NSString stringWithFormat:@"%@ %@ %@",self.p_addressComponent.province,self.p_addressComponent.city,self.p_addressComponent.district];
        
        [self.delegate selectLocation:poi.pt andTitle:poi.name andAddress:address];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        self.p_tabelView.y = CGRectGetMaxY(_mapView.frame);
        [self.view endEditing:YES];
        BMKPoiInfo *poiInfo =self.AddressArr[indexPath.row];
        BMKCoordinateRegion region ;//表示范围的结构体
        region.center =  poiInfo.pt;//中心点
        region.span.latitudeDelta = 0.003;//经度范围（设置为0.1表示显示范围为0.2的纬度范围
        region.span.longitudeDelta = 0.003;
        [_mapView setRegion:region animated:YES];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _geocodesearch.delegate = self;
    _mapView.delegate = self;
    // 此处记得不用的时候需要置nil，否则影响内存的释放
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _geocodesearch.delegate = nil; // 不用时，置nil
    _mapView.delegate = nil;
    _searchServer.delegate = nil;
}
#pragma mark -反地理编码查询回调方法
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    self.AddressArr = nil;
    
    if (error==0) {
        self.iconView.hidden = NO;
        self.AddressArr = result.poiList;
        self.p_addressComponent = result.addressDetail;
        if (result.poiList.count) {
            BMKPoiInfo *pointInfo =  [result.poiList firstObject];
            self.iconView.text = pointInfo.name;
            [self.iconView sizeToFit];
            self.iconView.width +=5;
            self.iconView.x = (_mapView.width - self.iconView.width)/2;
        }
    }else{
        self.iconView.hidden = YES;
        NSLog(@"搜索失败");
        
    }
    [self.p_tabelView reloadData];
    
}


#pragma mark -地位信息
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    
    [_mapView updateLocationData:userLocation];
    
    BMKCoordinateRegion region ;//表示范围的结构体
    self.myLocation = userLocation;
    region.center =  userLocation.location.coordinate;//中心点
    region.span.latitudeDelta = 0.003;//经度范围（设置为0.1表示显示范围为0.2的纬度范围
    region.span.longitudeDelta = 0.003;
    [_mapView setRegion:region animated:YES];
    _mapView.showsUserLocation = YES;
    
    
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isRotateAngleValid = true;//跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示
    [_mapView updateLocationViewWithParam:displayParam];
    
    
    BMKReverseGeoCodeOption *ReverseGeo = [[BMKReverseGeoCodeOption alloc]init];
    ReverseGeo.reverseGeoPoint = userLocation.location.coordinate;
    [_geocodesearch reverseGeoCode:ReverseGeo];
    
    
    
    [self.locService stopUserLocationService];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:NO];
}


//-(void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
//    BMKReverseGeoCodeOption *ReverseGeo = [[BMKReverseGeoCodeOption alloc]init];
//    ReverseGeo.reverseGeoPoint = coordinate;
//    BOOL flag = [_geocodesearch reverseGeoCode:ReverseGeo];
//    if(flag)
//    {
//        NSLog(@"反geo检索发送成功");
//    }
//    else
//    {
//        NSLog(@"反geo检索发送失败");
//    }
//
//    self.pointView.coordinate = coordinate;
//    [_mapView addAnnotation:self.pointView];
//
//}
#pragma mark -搜索结果回调
//- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode{
//    self.AddressArr = nil;
//    for(BMKPoiInfo *poiInfo in poiResult.poiInfoList)
//    {
//        
//        NSDictionary *dic = @{@"title":poiInfo.name,
//                              @"detail":poiInfo.address,
//                              @"point":poiInfo};
//        [self.AddressArr addObject:dic];
//    }
//    [self.p_tabelView reloadData];
//}






- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    CGPoint point = self.p_imageView.origin;
    point.y = self.p_imageView.origin.y+self.p_imageView.height;
    CLLocationCoordinate2D coordinate = [mapView convertPoint:point toCoordinateFromView:_mapView];
    BMKReverseGeoCodeOption *ReverseGeo = [[BMKReverseGeoCodeOption alloc]init];
    ReverseGeo.reverseGeoPoint = coordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:ReverseGeo];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
        self.iconView.hidden = NO;
    }
    else
    {
        NSLog(@"反geo检索发送失败");
        self.iconView.hidden = YES;
    }
}
- (void)mapStatusDidChanged:(BMKMapView *)mapView{
    self.iconView.hidden = YES;
}

-(void)doaction:(NSNotification *)notification{
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    
    return YES;
}

@end
