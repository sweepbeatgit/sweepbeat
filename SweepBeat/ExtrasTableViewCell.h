//
//  ExtrasTableViewCell.h
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/19/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtrasTableViewCell : UITableViewCell

//@property(nonatomic, strong) UIImage *
@property (strong, nonatomic) IBOutlet UILabel *extraOptionsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *extraOptionsImageView;
@property (strong, nonatomic) IBOutlet UIImageView *extraOptionsIcons;

@end
