//
//  CleanOptionsTableViewCell.m
//  SweepBeat
//
//  Created by Arjun Madgavkar on 10/6/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import "CleanOptionsTableViewCell.h"

@implementation CleanOptionsTableViewCell

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
