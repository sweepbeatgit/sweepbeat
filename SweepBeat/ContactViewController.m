//
//  ContactViewController.m
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/18/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import "ContactViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "WhenViewController.h"
#import <Parse/Parse.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha: 1.0]

@interface ContactViewController ()
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UILabel *invalidEmailLabel;

@end

@implementation ContactViewController

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
    UIFont *nanumGothic4 = [UIFont fontWithName:@"NanumGothic" size:22.0];
    UIFont *nanumGothic2 = [UIFont fontWithName:@"NanumGothic" size:15.0];
    UIFont *nanumGothic3 = [UIFont fontWithName:@"NanumGothic" size:17.0];
    [self.contactHourTextLabel setFont:nanumGothic3];
    [self.contactHourLabel setFont:nanumGothic3];
    [self.contactPriceLabel setFont:nanumGothic4];
    [_invalidEmailLabel setFont:nanumGothic2];
    
    
    _contactHourLabel.text = _contactHourString;
    _contactHourTextLabel.text = @"hours";
    hrs = [_contactHourString floatValue];
    [_contactPriceLabel setText:[NSString stringWithFormat:@"$%.2f", hrs * 35]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"pushToHowOften"]) {
        [self nextView];
    } else {
        _invalidEmailLabel.hidden = false;
    }
    return NO;
    
    return YES;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; 
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (IBAction)emailTextFieldReturn:(id)sender {
    
    [sender resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_emailTextField isFirstResponder] && [touch view] != _emailTextField) {
        [_emailTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self nextView];
    return YES;
}

- (void) nextView
{
    if ([self NSStringIsValidEmail:_emailTextField.text] == true) {
        _invalidEmailLabel.hidden = true;
        NSString *email = _emailTextField.text;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *order = appDelegate.orderDict;
        [order setValue:email forKey:@"EmailAddress"];
        NSLog(@"%@", order);
        [self performSegueWithIdentifier:@"pushToWhen" sender:nil];
    } else {
        _invalidEmailLabel.hidden = false;
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *email = _emailTextField.text;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *order = appDelegate.orderDict;
    [order setValue:email forKey:@"EmailAddress"];
    NSLog(@"%@", order);
    
    PFObject *emailObject = [PFObject objectWithClassName:@"CustomersEmails"];
    emailObject[@"zipCode"] = order[@"Zipcode"];
    emailObject[@"email"] = email;
    [emailObject saveInBackground];
    
    WhenViewController *destVc = [segue destinationViewController];
    destVc.whenHourString = _contactHourLabel.text;
    // Pass the selected object to the new view controller.

}


@end
