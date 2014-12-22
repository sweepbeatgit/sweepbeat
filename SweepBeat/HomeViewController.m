//
//  HomeViewController.m
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/18/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import "HomeViewController.h"
#import "WhatViewController.h"
#import "AppDelegate.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha: 1.0]

@interface HomeViewController ()
@property (strong, nonatomic) IBOutlet UILabel *zipCodeLabel;
@property (strong, nonatomic) IBOutlet UIButton *userLocationButton;
@property (strong, nonatomic) IBOutlet UITextField *zipCodeTextField;
-(IBAction)textFieldReturn:(id)sender;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (strong, nonatomic) IBOutlet UILabel *wrongZipCodeLabel;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            _latitude = geoPoint.latitude;
            _longitude = geoPoint.longitude;
            NSLog(@"got ems");
        }
    }];
    
    // Back Button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self setTitle:@"SweepBeat"];
    UIFont *nanumGothic = [UIFont fontWithName:@"NanumGothic" size:25.0];
    UIFont *nanumGothic2 = [UIFont fontWithName:@"NanumGothic" size:15.0];
    UIFont *nanumGothicBold = [UIFont fontWithName:@"NanumGothicBold" size:17.0];
//    [self.zipCodeTextField setText:@"Zip Code"];
//    [self.zipCodeTextField setTextColor:[UIColor grayColor]];
    [_zipCodeLabel setFont:nanumGothic];
    [_zipCodeTextField setFont:nanumGothicBold];
    [_wrongZipCodeLabel setFont:nanumGothic2];
    
   [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)userLocationButton:(id)sender {
    
    
    //CLLocationCoordinate2D myCoordinates = { 48.167222, 11.586111 };
    CLLocationCoordinate2D myCoordinates = { _latitude, _longitude };
    CLLocation *location = [[CLLocation alloc]initWithLatitude:myCoordinates.latitude longitude:myCoordinates.longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"%d Placemarks %@", placemarks.count, placemarks);
        CLPlacemark *place = [placemarks objectAtIndex:0];
        NSLog(@"Placemark %@", place);
        NSLog(@"Address Dictionary: %@", place.addressDictionary);
        NSLog(@"Zip key %@", place.postalCode);
        [_zipCodeTextField setText:place.postalCode];
        
    }];
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self nextView];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_zipCodeTextField isFirstResponder] && [touch view] != _zipCodeTextField) {
        [_zipCodeTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"pushToWhat"]) {
        [self nextView];
        return NO;
    }
    return YES;
}

- (void) nextView
{
    if (_zipCodeTextField.text.length == 5) {
        _wrongZipCodeLabel.hidden = true;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *order = appDelegate.orderDict;
        NSString *zipcode = _zipCodeTextField.text;
        [order setValue:zipcode forKey:@"Zipcode"];
        NSLog(@"%@", order);
        [self performSegueWithIdentifier:@"pushToWhat" sender:nil];
    } else {
        _wrongZipCodeLabel.hidden = false;
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
