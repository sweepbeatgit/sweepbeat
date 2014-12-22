//
//  ExtrasViewController.h
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/19/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExtrasTableViewCell.h"

@interface ExtrasViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *options;
@property (strong, nonatomic) IBOutlet UILabel *hoursLabel;
@property (strong, nonatomic) IBOutlet UILabel *hoursTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property NSString *hoursString;
@property NSString *hoursTextString;
@end
