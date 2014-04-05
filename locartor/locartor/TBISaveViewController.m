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
    
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];


    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.navigationController.navigationBarHidden = NO;
    
    
    self.map.delegate = self;
    self.map.userInteractionEnabled = NO;
    
    CLLocationCoordinate2D noLocation;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 1000, 1000);
    MKCoordinateRegion adjustedRegion = [self.map regionThatFits:viewRegion];
    
    [self.map setRegion:adjustedRegion animated:YES];

    [self.map showsUserLocation];
    [self adaptViews];

    
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


#pragma mark - Views Configuration

- (void) adaptViews
{
    CGFloat halfScreen = [UIScreen mainScreen].bounds.size.width/2.0f;
    CGFloat height = 42.0f;
    CGFloat buttonsVerticalOffset = [UIScreen mainScreen].bounds.size.height-height;
    
    //    [_map setFrame:CGRectMake(0.0f, 0.0f,  [UIScreen mainScreen].bounds.size.width, buttonsVerticalOffset)];
    [_scrollView setFrame:[UIScreen mainScreen].bounds ];
    [_saveLocation setFrame:CGRectMake(halfScreen, buttonsVerticalOffset,  halfScreen, height)];
    [_shareButton setFrame:CGRectMake(0.0f, buttonsVerticalOffset,  halfScreen, height)];
    
    
    
}




@end
