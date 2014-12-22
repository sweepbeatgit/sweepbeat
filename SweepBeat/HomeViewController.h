//
//  HomeViewController.h
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/18/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface HomeViewController : UIViewController

@property (nonatomic, strong) PFGeoPoint *userCurrentLocation;

@end
