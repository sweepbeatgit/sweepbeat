//
//  WhenViewController.h
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/18/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhenViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *whenHourLabel;
@property (strong, nonatomic) IBOutlet UILabel *whenHourTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *whenPriceLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property NSString *whenHourString;
@property NSString *whenHourTextString;


@end
