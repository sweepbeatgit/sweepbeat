//
//  AddressViewController.h
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/18/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController <UITextFieldDelegate>
- (IBAction)nextbuttonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *addressPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressHourLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressHourTextLabel;

@property NSString *addressHourString;
@property NSString *addressHourTextString;

@end
