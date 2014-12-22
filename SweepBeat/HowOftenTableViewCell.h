//
//  HowOftenTableViewCell.h
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/19/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowOftenTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *discountImage;
@property (strong, nonatomic) IBOutlet UIImageView *tickmarkImage;

@end
