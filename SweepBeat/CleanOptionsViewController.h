//
//  CleanOptionsViewController.h
//  SweepBeat
//
//  Created by Arjun Madgavkar on 9/26/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CleanOptionsViewController : UIViewController

@property (nonatomic,strong) NSArray *cleanOptions;
@property (strong, nonatomic) IBOutlet UILabel *cleanOptionsHourLabel;
@property (strong, nonatomic) IBOutlet UILabel *cleanOptionsHourTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *cleanOptionsPriceLabel;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property NSString *cleanOptionsHourString;
@property NSString *cleanOptionsHourTextString;

@end
