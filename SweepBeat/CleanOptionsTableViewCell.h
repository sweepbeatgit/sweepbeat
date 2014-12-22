//
//  CleanOptionsTableViewCell.h
//  SweepBeat
//
//  Created by Arjun Madgavkar on 10/6/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CleanOptionsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *addTime;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UIImageView *tickmarkImageView;
@property (strong, nonatomic) IBOutlet UILabel *cleanOptionLabel;

@end
