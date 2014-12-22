//
//  HowOftenTableViewCell.m
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/19/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import "HowOftenTableViewCell.h"

@implementation HowOftenTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
