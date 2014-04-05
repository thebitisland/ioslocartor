//
//  TBIMapViewController.h
//  Locartor
//
//  Created by Manu on 05/04/14.
//  Copyright (c) 2014 thebitisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface TBIMapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>


@property (weak,nonatomic) IBOutlet UIButton * saveButton;
@property (weak,nonatomic) IBOutlet UIButton * retrieveButton;

@property (weak, nonatomic) IBOutlet MKMapView * map;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,readwrite) CLLocationCoordinate2D currentLocation;
@property (nonatomic, retain) CLLocation *lastLocation;

@end
