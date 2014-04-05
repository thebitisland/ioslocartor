//
//  TBISaveViewController.h
//  Locartor
//
//  Created by Nicolás Jaremek on 05/04/14.
//  Copyright (c) 2014 thebitisland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TBISaveViewController : UIViewController <UINavigationControllerDelegate,MKMapViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *saveLocation;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet MKMapView * map;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,readwrite) CLLocationCoordinate2D currentLocation;
@property (nonatomic, retain) CLLocation *location;




- (IBAction)save:(id)sender;

- (id) initWithLocation:(CLLocation *)location nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@end
