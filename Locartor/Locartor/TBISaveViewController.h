//
//  TBISaveViewController.h
//  Locartor
//
//  Created by Nicolás Jaremek on 05/04/14.
//  Copyright (c) 2014 thebitisland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBISaveViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *saveLocation;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
- (IBAction)save:(id)sender;
@end
