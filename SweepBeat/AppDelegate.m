//
//  AppDelegate.m
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/18/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Stripe.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha: 1.0]
NSString * const StripePublishableKey = @"pk_test_jq8HNMY6sIVxf9WQ6xocAqOi";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [Parse setApplicationId:@"ZinPoNNQ3DjpqhtPrx1qrwvXcym39tlK1H3x3iBN"
                  clientKey:@"G5DfAsNJN92f0nyG87eOuWegd8HoNPbOoAMeeUxL"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xC90117)];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
    self.orderDict = [[NSMutableDictionary alloc]init];
    //[[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    
    UIColor *color = [UIColor blackColor];
   // UIFont *nanumGothic = [UIFont fontWithName:@"NanumGothic" size:25.0];
    UIFont *newFont = [UIFont fontWithName:@"Levenim MT" size:20.0];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName: color, NSFontAttributeName : newFont}];
    
    [Stripe setDefaultPublishableKey:StripePublishableKey];
    
    return YES;
}


							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Handle the user leaving the app while the Facebook login dialog is being shown
    // For example: when the user presses the iOS "home" button while the login dialog is active
   // [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
