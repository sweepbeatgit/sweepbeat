//
//  WhenViewController.m
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/18/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import "WhenViewController.h"
#import "CleanOptionsViewController.h"
#import "AppDelegate.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha: 1.0]

@interface WhenViewController ()

@property (strong, nonatomic) IBOutlet UILabel *whenLabel;

@end

@implementation WhenViewController

float hrs;

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
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xffffff);
    [self.navigationController setNavigationBarHidden:NO];
    // Back Button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xC90117)];
    UIFont *nanumGothic3 = [UIFont fontWithName:@"NanumGothic" size:17.0];
    UIFont *nanumGothic4 = [UIFont fontWithName:@"NanumGothic" size:22.0];
    [self.whenHourLabel setFont:nanumGothic3];
    [self.whenHourTextLabel setFont:nanumGothic3];
    [self.whenPriceLabel setFont:nanumGothic4];
    
    
    _whenHourLabel.text = _whenHourString;
    _whenHourTextLabel.text = @"hours";
    hrs = [_whenHourString floatValue];
    [_whenPriceLabel setText:[NSString stringWithFormat:@"$%.2f", hrs * 35]];
    UIFont *nanumGothicBold = [UIFont fontWithName:@"NanumGothicBold" size:17.0];
    _whenLabel.font = nanumGothicBold;
    [_whenLabel setTextColor:UIColorFromRGB(0x8a8a8a)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSDate *myDate = _datePicker.date;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *order = appDelegate.orderDict;
    [order setValue:myDate forKey:@"Date"];
    NSLog(@"%@", order);
    CleanOptionsViewController *destVc = [segue destinationViewController];
    destVc.cleanOptionsHourString = _whenHourLabel.text;
    // Pass the selected object to the new view controller.
}


@end
