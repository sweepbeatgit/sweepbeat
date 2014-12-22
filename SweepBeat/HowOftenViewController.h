//
//  HowOftenViewController.h
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/18/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowOftenViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *discountOptions;
}

@property (strong, nonatomic) IBOutlet UILabel *howOftenHourLabel;
@property (strong, nonatomic) IBOutlet UILabel *howOftenHourTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *howOftenPriceLabel;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property NSString *howOftenHourString;
@property NSString *howOftenHourTextString;



@end
