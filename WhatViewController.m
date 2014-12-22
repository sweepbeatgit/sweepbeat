//
//  WhatViewController.m
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/18/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import "WhatViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "ExtrasViewController.h"
#import "AppDelegate.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha: 1.0]

@interface WhatViewController ()
@property (strong, nonatomic) IBOutlet UILabel *roomLabel;
@property (strong, nonatomic) IBOutlet UIButton *increaseBedroomButton;
@property (strong, nonatomic) IBOutlet UIButton *decreaseBedroomButton;
@property (strong, nonatomic) IBOutlet UIButton *increaseBathroomButton;
@property (strong, nonatomic) IBOutlet UIButton *decreaseBathroomButton;
@property (strong, nonatomic) IBOutlet UITextField *bedroomTextField;
@property (strong, nonatomic) IBOutlet UITextField *bathroomTextField;
@end

@implementation WhatViewController

int bedroomStartNumber = 1;
int bathroomStartNumber = 1;
float inithour = 2.0;


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
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.navigationController setNavigationBarHidden:NO];
//    [self.navigationController.navigationBar
//     setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xc4c4c4)}];
 
    // Back Button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xC90117)];
    UIFont *nanumGothic = [UIFont fontWithName:@"NanumGothic" size:22.0];
    UIFont *nanumGothic2 = [UIFont fontWithName:@"NanumGothic" size:15.0];
    UIFont *nanumGothic3 = [UIFont fontWithName:@"NanumGothic" size:17.0];
    UIFont *nanumGothicBold = [UIFont fontWithName:@"NanumGothicBold" size:17.0];
    [_roomLabel setFont:nanumGothicBold];
    [_roomLabel setTextColor:UIColorFromRGB(0x8a8a8a)];
    [self.bedroomTextField setFont:nanumGothic2];
    //[self.bedroomTextField setTextColor:UIColorFromRGB(0x8a8a8a)];
    [self.bathroomTextField setFont: nanumGothic2];
    //[self.bathroomTextField setTextColor:UIColorFromRGB(0x8a8a8a)];
    [self.hours setFont:nanumGothic3];
    [self.hourtext setFont:nanumGothic3];
    [self.priceLabel setFont:nanumGothic];
    [self.priceLabel setText:@"$70.00"];
    [self.hourtext setText:@"hours"];
    [self.hours setText:@"2.00"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


- (IBAction)increaseBedroomButton:(id)sender {
    bedroomStartNumber = bedroomStartNumber + 1;
    UIFont *nanumGothic = [UIFont fontWithName:@"NanumGothic" size:15.0];
    _bedroomTextField.font = nanumGothic;
    _bedroomTextField.text = [NSString stringWithFormat:@"%d bedrooms", bedroomStartNumber];
    [self updateHourLabel];
}

- (IBAction)decreaseBedroomButton:(id)sender {
    if( bedroomStartNumber > 0)
    {
        bedroomStartNumber = bedroomStartNumber - 1;
    }
        UIFont *nanumGothic = [UIFont fontWithName:@"NanumGothic" size:15.0];
        _bedroomTextField.font = nanumGothic;
        _bedroomTextField.text = [NSString stringWithFormat:@"%d bedrooms", bedroomStartNumber];
        [self updateHourLabel];
}

- (IBAction)increaseBathroomButton:(id)sender {
    bathroomStartNumber = bathroomStartNumber + 1;
    UIFont *nanumGothic = [UIFont fontWithName:@"NanumGothic" size:15.0];
    _bedroomTextField.font = nanumGothic;
    _bathroomTextField.text = [NSString stringWithFormat:@"%d bathrooms", bathroomStartNumber];
    [self updateHourLabel];
    NSLog(@"%d", bathroomStartNumber);
}

- (IBAction)decreaseBathroomButton:(id)sender {
    if( bathroomStartNumber > 0)
    {
        bathroomStartNumber = bathroomStartNumber - 1;
    }
        UIFont *nanumGothic = [UIFont fontWithName:@"NanumGothic" size:15.0];
        _bedroomTextField.font = nanumGothic;
        _bathroomTextField.text = [NSString stringWithFormat:@"%d bathrooms", bathroomStartNumber];
        [self updateHourLabel];
}

-(void) updateHourLabel
{
    float a = bathroomStartNumber;
    float b = bedroomStartNumber;
    NSLog(@"A1 : %.2f",a);
    NSLog(@"B1 : %.2f",b);
    
    if(a>1.0)
    {
        a = ((a-1)*0.5) + 1;
        NSLog(@"A2 : %.2f",a);
    }
    
    if(b>1.0)
    {
        b = ((b-1)*0.5) + 1;
        NSLog(@"B2 : %.2f",b);
    }
    
    inithour = a+b;

    
    [self.hours setText:[NSString stringWithFormat:@"%.2f", inithour]];
    [self.priceLabel setText:[NSString stringWithFormat:@"$%.2f", inithour * 35]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"pushToExtras"]) {
        NSString *bed = _bedroomTextField.text;
        NSArray *bedarray = [bed componentsSeparatedByString:@" "];
        NSString *bath = _bathroomTextField.text;
        NSArray *batharray = [bath componentsSeparatedByString:@" "];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *order = appDelegate.orderDict;
        [order setValue:bedarray[0] forKey:@"Bedroom"];
        [order setValue:batharray[0] forKey:@"Bathroom"];
        NSLog(@"%@", order);
        ExtrasViewController *destViewController = [segue destinationViewController];
        destViewController.hoursString = _hours.text;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
