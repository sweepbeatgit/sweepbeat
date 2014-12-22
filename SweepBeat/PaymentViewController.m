//
//  PaymentViewController.m
//  SweepBeat
//
//  Created by Chirag Chauhan on 8/20/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import "PaymentViewController.h"
#import "Stripe.h"
#import "PTKView.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface PaymentViewController ()<PTKViewDelegate>
//@property (strong, nonatomic) STPCard* stripeCard;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
//@property IBOutlet PKView* stripeView;
@property(weak, nonatomic) PTKView *paymentView;

@end

@implementation PaymentViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Checkout";
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // Setup save button
//    NSString *title = [NSString stringWithFormat:@"Pay $%@", self.amount];
    //NSString *title = [NSString stringWithFormat:@"Pay"];
//    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    
//    _saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _saveButton.frame = CGRectMake(40, 260, 255, 90);
//    //[_saveButton setTitle:@"Pay Cleaner!" forState:UIControlStateNormal];
//    [_saveButton setBackgroundImage:[UIImage imageNamed:@"iconpaynow.png"] forState:UIControlStateNormal];
//    [self.view addSubview:_saveButton];
//    [_saveButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
//    //[_saveButton setBackgroundImage:[UIImage imageNamed:@"iconpaymentsaved.png"] forState:UIControlStateSelected];

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    _saveButton.enabled = NO;
    self.navigationItem.leftBarButtonItem = cancelButton;
//    self.navigationItem.rightBarButtonItem = saveButton;
    
    // Setup checkout
    PTKView *paymentView = [[PTKView alloc] initWithFrame:CGRectMake(15, 20, 290, 55)];
    paymentView.delegate = self;
    self.paymentView = paymentView;
    [self.view addSubview:paymentView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)paymentView:(PTKView *)paymentView withCard:(PTKCard *)card isValid:(BOOL)valid {
    NSLog(@"asdas");
    // Enable save button if the Checkout is valid
//    self.navigationItem.rightBarButtonItem.enabled = valid;
    _saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _saveButton.frame = CGRectMake(40, 260, 255, 90);
    //[_saveButton setTitle:@"Pay Cleaner!" forState:UIControlStateNormal];
    [_saveButton setBackgroundImage:[UIImage imageNamed:@"iconpaynow.png"] forState:UIControlStateNormal];
    [self.view addSubview:_saveButton];
    [_saveButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    //[_saveButton setBackgroundImage:[UIImage imageNamed:@"iconpaymentsaved.png"] forState:UIControlStateSelected];
    self.saveButton.enabled = valid;
}

- (void)cancel:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

//- (void)payButtonPressed:(id)sender {
//    [_saveButton setTitle:@"Payment Saved!" forState:UIControlStateNormal];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)save:(id)sender {
//    STPCard *card = [[STPCard alloc] init];
//    card.number = self.paymentView.card.number;
//    card.expMonth = self.paymentView.card.expMonth;
//    card.expYear = self.paymentView.card.expYear;
//    card.cvc = self.paymentView.card.cvc;
//    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
//        if (error) {
//
//        }
//        else {
//            [self createBackendChargeWithToken:token];
//        }
//    }];
//}

- (IBAction)save:(id)sender {
    if (![self.paymentView isValid]) {
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    STPCard *card = [[STPCard alloc] init];
    card.number = self.paymentView.card.number;
    card.expMonth = self.paymentView.card.expMonth;
    card.expYear = self.paymentView.card.expYear;
    card.cvc = self.paymentView.card.cvc;
    [Stripe createTokenWithCard:card
                     completion:^(STPToken *token, NSError *error) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         if (error) {
                             [self hasError:error];
                         } else {
                             [self hasToken:token];
                         }
                     }];
}

- (void)hasError:(NSError *)error {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                                      message:[error localizedDescription]
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                            otherButtonTitles:nil];
    [message show];
}

- (void)hasToken:(STPToken *)token {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //WRITE THE ACTUAL AMOUNT VARIABLE FROM PREVIOUS SCREEN
    NSDictionary *chargeParams = @{
                                   @"token": token.tokenId,
                                   @"currency": @"usd",
                                   @"amount": @"1000", // <-- add paymentNumber variable here this is in cents (i.e. $10)
                                   };
   
    
    // This passes the token off to our payment backend, which will then actually complete charging the card using your account's
    [PFCloud callFunctionInBackground:@"charge"
                       withParameters:chargeParams
                                block:^(id object, NSError *error) {
                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                    if (error) {
                                        [self hasError:error];
                                        return;
                                    }
                                    [self.presentingViewController dismissViewControllerAnimated:YES
                                                                                      completion:^{
                                                                                          [[[UIAlertView alloc] initWithTitle:@"Payment Succeeded"
                                                                                                                      message:nil
                                                                                                                     delegate:nil
                                                                                                            cancelButtonTitle:nil
                                                                                                            otherButtonTitles:@"OK", nil] show];
                                                                                      }];
                                    
                                    
                                }];
}


@end
