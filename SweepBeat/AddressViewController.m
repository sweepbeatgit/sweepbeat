//
//  AddressViewController.m
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/18/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import "AddressViewController.h"
#import "PaymentViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha: 1.0]

@interface AddressViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextField *apartmentTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UILabel *incorrectPhone;
@property (strong, nonatomic) IBOutlet UILabel *missingApt;
@property (strong, nonatomic) IBOutlet UILabel *missingAddress;
@property (strong, nonatomic) IBOutlet UILabel *missingName;
@property (strong, nonatomic) IBOutlet UILabel *contactLabel;

@end

@implementation AddressViewController

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
    UIFont *nanumGothicTextField = [UIFont fontWithName:@"NanumGothic" size:15.0];
    [_nameTextField setFont:nanumGothicTextField];
    [_addressTextField setFont:nanumGothicTextField];
    [_apartmentTextField setFont:nanumGothicTextField];
    [_phoneTextField setFont:nanumGothicTextField];
    
    UIFont *nanumGothic4 = [UIFont fontWithName:@"NanumGothic" size:22.0];
    UIFont *nanumGothicBold = [UIFont fontWithName:@"NanumGothicBold" size:17.0];
    UIFont *nanumGothic3 = [UIFont fontWithName:@"NanumGothic" size:17.0];
    
    
    [_contactLabel setFont:nanumGothicBold];
    [_contactLabel setTextColor:UIColorFromRGB(0x8a8a8a)];
    [self.addressHourTextLabel setFont:nanumGothic3];
    [self.addressHourLabel setFont:nanumGothic3];
    [self.addressPriceLabel setFont:nanumGothic4];
    
    
    _addressHourLabel.text = _addressHourString;
    _addressHourTextLabel.text = @"hours";
    hrs = [_addressHourString floatValue];
    [_addressPriceLabel setText:[NSString stringWithFormat:@"$%.2f", hrs * 35]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_phoneTextField isFirstResponder] && [touch view] != _phoneTextField) {
        [_phoneTextField resignFirstResponder];
    }
    if ([_nameTextField isFirstResponder] && [touch view] != _nameTextField) {
        [_nameTextField resignFirstResponder];
    }
    if ([_addressTextField isFirstResponder] && [touch view] != _addressTextField) {
        [_addressTextField resignFirstResponder];
    }
    if ([_apartmentTextField isFirstResponder] && [touch view] != _apartmentTextField) {
        [_apartmentTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (IBAction)nextbuttonPressed:(id)sender {

    if (_phoneTextField.text.length > 9 && _phoneTextField.text.length < 12 && _addressTextField.text.length > 0 && _apartmentTextField.text.length > 0 && _nameTextField.text.length > 0)
    {
            NSString *fullName = _nameTextField.text;
            NSString *address = _addressTextField.text;
            NSString *aptNumber = _apartmentTextField.text;
            NSString *phoneNumber = _phoneTextField.text;
        
            //NSString *paymentNumber = _addressPriceLabel.text;
        //CONVERT THIS STRING TO A DOUBLE/INTEGER
        
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSMutableDictionary *order = appDelegate.orderDict;
            [order setValue:fullName forKey:@"Name"];
            [order setValue:address forKey:@"Address"];
            [order setValue:aptNumber forKey:@"ApartmentNumber"];
            [order setValue:phoneNumber forKey:@"PhoneNumber"];
        // MAKE paymentNumber VARIABLE WHICH == THE PAYMENT THAT A CUSTOMER IS GOING TO PAY
        // AND THEN UNCOMMENT BELOW
        // [order setValue:paymentNumber forKey:@"CustomerPayment"];
        
        
            NSLog(@"%@", order);
        
        PFObject *orderObject = [PFObject objectWithClassName:@"Customers"];
        orderObject[@"name"] = order[@"Name"];
        orderObject[@"address"] = order[@"Address"];
        orderObject[@"zipCode"] = order[@"Zipcode"];
        orderObject[@"aptNumber"] = order[@"ApartmentNumber"];
        orderObject[@"serviceDate"] = order[@"Date"];
        orderObject[@"Email"] = order[@"EmailAddress"];
        orderObject[@"phoneNumber"] = order[@"PhoneNumber"];
        orderObject[@"bedrooms"] = order[@"Bedroom"];
        orderObject[@"bathrooms"] = order[@"Bathroom"];
        [orderObject saveInBackground];
            PaymentViewController *paymentView = [[PaymentViewController alloc] init];
            [self presentViewController:paymentView animated:YES completion:nil];
        
//        [PFCloud callFunctionInBackground:@"send" withParameters:@{@"fullName":fullName, @"address":address, @"zipCode":orderObject[@"zipCode"], @"aptNumber":aptNumber, @"serviceDate":order[@"Date"], @"Email":order[@"EmailAddress"], @"phoneNumber":phoneNumber, @"bedrooms":order[@"Bedroom"], @"bathrooms":order[@"Bathroom"]} block:^(NSString *result, NSError *error) {
//            if (!error) {
//                
//            }
//        }];
        
    }
    
    if (_phoneTextField.text.length < 9 || _phoneTextField.text.length > 12)
        {
        _incorrectPhone.hidden = false;
    } else {
            _incorrectPhone.hidden = true;
        }
    if (_addressTextField.text.length == 0) {
            _missingAddress.hidden = false;
    } else {
        _missingAddress.hidden = true;
    }
    if (_apartmentTextField.text.length == 0) {
            _missingApt.hidden = false;
    } else {
        _missingApt.hidden = true;
    }
    if (_nameTextField.text.length == 0) {
            _missingName.hidden = false;
    } else {
        _missingName.hidden = true;
    }
 
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
}


@end
