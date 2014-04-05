//
//  TBISaveViewController.m
//  Locartor
//
//  Created by Nicolás Jaremek on 05/04/14.
//  Copyright (c) 2014 thebitisland. All rights reserved.
//

#import "TBISaveViewController.h"

@interface TBISaveViewController ()

@end

@implementation TBISaveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = NSLocalizedString(@"saveTitle", nil);

    }
    return self;
}

- (id) initWithLocation:(CLLocation *)location nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _location = location;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"location: %@",self.location);

    
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];


    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.navigationController.navigationBarHidden = NO;
    

    //[self.map setCenterCoordinate:self.location.coordinate animated:NO];
    
    self.map.delegate = self;
    self.map.userInteractionEnabled = NO;
    
    CLLocationCoordinate2D noLocation;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 800, 800);
    MKCoordinateRegion adjustedRegion = [self.map regionThatFits:viewRegion];
    
    [self.map setRegion:adjustedRegion animated:YES];

    [self.map showsUserLocation];

//    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItem target:self action:@selector(doneButtonTapped:)];
//    self.navigationItem.leftBarButtonItem = done;
    
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    self.map.centerCoordinate = self.location.coordinate;
    MKPointAnnotation *pa = [[MKPointAnnotation alloc] init];
    pa.coordinate = self.location.coordinate;
    

    
    [self.map removeAnnotations:self.map.annotations];
    
    [self.map addAnnotation:pa];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)save:(id)sender
{
    // Get the current date
    NSDate *pickerDate = [self.datePicker date];
    
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = pickerDate;
    localNotification.alertBody = @"This is a reminder to retrieve your car";
    localNotification.alertAction = @"Show me the item";
    localNotification.soundName = UILocalNotificationDefaultSoundName;

    NSTimeZone * currentTZ = [NSTimeZone localTimeZone];
    localNotification.timeZone = currentTZ;
    NSLog(@"local timezone. %@",currentTZ);
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    UIAlertView * dateSavedAlert = [[UIAlertView alloc] initWithTitle:@"Guardado!" message:@"La localización de su vehículo se ha guardado correctamente" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [dateSavedAlert show];
}

#pragma mark - Done BUtton
- (void)doneButtonTapped:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    static NSString *SFAnnotationIdentifier = @"SFAnnotationIdentifier";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:SFAnnotationIdentifier];
    if (!pinView)
    {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc]
                                            initWithAnnotation:annotation
                                            
                                            reuseIdentifier:SFAnnotationIdentifier] ;
        
        UIImage *flagImage = [UIImage imageNamed:@"marker.png"];
        
        // You may need to resize the image here.
        annotationView.image = flagImage;
        
        [annotationView setFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
        return annotationView;
    }
    else
    {
        pinView.annotation = annotation;
    }
    return pinView;
}



@end
