//
//  StepViewController.m
//  Glad9TM
//
//  Created by 史伟文 on 2017/5/25.
//  Copyright © 2017年 NanJing. All rights reserved.
//

#import "StepViewController.h"
#import "KX9ParentsPointView.h"
#import "KX9ParentsPointFlag.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "CLLocation+TransLocationTool.h"
#import "Ocean_MainStoreShopModel.h"
@interface StepViewController ()<BMKMapViewDelegate>

@property (nonatomic,weak) BMKMapView * p_mapView;

@property (nonatomic,strong) UIImageView * p_paopaoView;

@property (nonatomic,strong) NSMutableArray * p_locationArr;


@property (nonatomic,weak) KX9ParentsPointView * p_choosePointView;

@end

@implementation StepViewController


-(NSMutableArray *)p_locationArr{
    if (!_p_locationArr) {
        _p_locationArr = [NSMutableArray array];
    }
    return _p_locationArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    mapView.delegate = self;
    self.p_mapView = mapView;

    [self.view addSubview: mapView];
    
    self.title = @"店铺地址";
    
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
    [navBtn setTitle:@"开始导航" forState:0];
    navBtn.x = 20;
    navBtn.backgroundColor = BackgroundColors(1);
    navBtn.width = self.view.width -2 *navBtn.x;
    navBtn.height = navBtn.width *35/200;
    navBtn.bottom = self.view.height - 30;
    [self.view addSubview:navBtn];
    [navBtn addTarget:self action:@selector(onDaoHang) forControlEvents:UIControlEventTouchUpInside];
    [self addLocation];
}

-(void)onDaoHang{
    CLLocation *location = [[[CLLocation alloc]initWithLatitude:[self.s_infomodel.m_lat doubleValue]  longitude:[self.s_infomodel.m_lng doubleValue]] locationMarsFromBaidu];
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:location.coordinate addressDictionary:nil]];
    toLocation.name =self.s_infomodel.m_compaddress;
    toLocation.phoneNumber = self.s_infomodel.m_corphone;
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                   MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.p_mapView viewWillAppear];
    self.p_mapView.delegate = self;
    
    
}


// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        KX9ParentsPointView *newAnnotationView = [[KX9ParentsPointView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        return newAnnotationView;
    }
    return nil;
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.p_mapView viewWillDisappear];
    self.p_mapView.delegate = nil;
}




-(void)addLocation{
    
    CLLocationCoordinate2D firstcoor = CLLocationCoordinate2DMake([self.s_infomodel.m_lat floatValue], [self.s_infomodel.m_lng  floatValue]);
    BMKCoordinateRegion reg;
    BMKCoordinateSpan span;
    span.latitudeDelta = 0.08;
    span.longitudeDelta = 0.08;
    reg.span = span;
    reg.center = firstcoor;
    [self.p_mapView setRegion:reg];
    KX9ParentsPointFlag* annotation = [[KX9ParentsPointFlag alloc]init];
    annotation.coordinate = firstcoor;
    annotation.name = self.s_infomodel.m_name;
    annotation.address = self.s_infomodel.m_compaddress;
    [self.p_mapView addAnnotations:@[annotation]];
}


@end
