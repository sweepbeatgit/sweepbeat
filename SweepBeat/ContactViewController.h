//
//  ContactViewController.h
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/18/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *contactHourLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactHourTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactPriceLabel;

@property NSString *contactHourString;
@property NSString *contactHourTextString;

@end
