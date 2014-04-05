//
//  TBIMapViewController.m
//  Locartor
//
//  Created by Manu on 05/04/14.
//  Copyright (c) 2014 thebitisland. All rights reserved.
//

#import "TBIMapViewController.h"

@interface TBIMapViewController ()

@end

@implementation TBIMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        _retrieveButton.titleLabel.text = NSLocalizedString(@"retrieve", nil);
        _saveButton.titleLabel.text = NSLocalizedString(@"save", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;

    [self adaptViews];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    self.map.delegate = self;
    [self.map setUserInteractionEnabled:YES];
    self.map.showsUserLocation = YES;
    
    CLLocationCoordinate2D noLocation;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 800, 800);
    MKCoordinateRegion adjustedRegion = [self.map regionThatFits:viewRegion];
    
    [self.map setRegion:adjustedRegion animated:YES];

    self.edgesForExtendedLayout = UIRectEdgeNone;


    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.lastLocation = [self.locationManager location];

    if (!self.lastLocation) {
        self.lastLocation = newLocation;
    }

    
    CLLocationCoordinate2D coordinate =  CLLocationCoordinate2DMake(self.lastLocation.coordinate.latitude, self.lastLocation.coordinate.longitude);
    [self.map setCenterCoordinate:coordinate animated:NO];
    
    
    if (newLocation.coordinate.latitude != self.lastLocation.coordinate.latitude &&
        newLocation.coordinate.longitude != self.lastLocation.coordinate.longitude) {
        self.lastLocation = newLocation;
        NSLog(@"New location: %f, %f",
              self.lastLocation.coordinate.latitude,
              self.lastLocation.coordinate.longitude);
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)locationUpdate:(CLLocation *)location
{
    [self.map setCenterCoordinate:location.coordinate];
    
    if ([self.map showsUserLocation] == NO)
    {
        [self.map setShowsUserLocation:YES];
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}

#pragma mark - Views Configuration

- (void) adaptViews
{
    CGFloat halfScreen = [UIScreen mainScreen].bounds.size.width/2.0f;
    CGFloat height = 42.0f;
    CGFloat buttonsVerticalOffset = [UIScreen mainScreen].bounds.size.height-height;
    
//    [_map setFrame:CGRectMake(0.0f, 0.0f,  [UIScreen mainScreen].bounds.size.width, buttonsVerticalOffset)];
    
    [_saveButton setFrame:CGRectMake(halfScreen, buttonsVerticalOffset,  halfScreen, height)];
    [_retrieveButton setFrame:CGRectMake(0.0f, buttonsVerticalOffset,  halfScreen, height)];



}

#pragma mark - Actions
- (IBAction)saveLocation:(id)sender
{
    TBISaveViewController * saveVC = [[TBISaveViewController alloc] initWithLocation:self.lastLocation nibName:nil bundle:nil];
    
    NSLog(@"location: %@",self.lastLocation);
    
    [self.navigationController pushViewController:saveVC animated:YES];
}


- (void)doneButtonTapped:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
    
@end
