//
//  CleanOptionsViewController.m
//  SweepBeat
//
//  Created by Arjun Madgavkar on 9/26/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import "CleanOptionsViewController.h"
#import "CleanOptionsTableViewCell.h"
#import "HowOftenViewController.h"
#import "AppDelegate.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha: 1.0]

@interface CleanOptionsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *wouldYouLikeToLabel;
@property (weak, nonatomic) NSString *options;

@end

@implementation CleanOptionsViewController

float hrs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _options = @"Keep Clean";
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    UIFont *nanumGothic4 = [UIFont fontWithName:@"NanumGothic" size:22.0];
  //  UIFont *nanumGothic2 = [UIFont fontWithName:@"NanumGothic" size:15.0];
    UIFont *nanumGothic3 = [UIFont fontWithName:@"NanumGothic" size:17.0];
    [self.cleanOptionsHourTextLabel setFont:nanumGothic3];
    [self.cleanOptionsHourLabel setFont:nanumGothic3];
    [self.cleanOptionsPriceLabel setFont:nanumGothic4];
    
    self.cleanOptions = @[@"Keep It Clean", @"Get It Clean", @"Deep Clean"];
    // Back Button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xC90117)];
    _cleanOptionsHourLabel.text = _cleanOptionsHourString;
    _cleanOptionsHourTextLabel.text = @"hours";
    hrs = [_cleanOptionsHourString floatValue];
    [_cleanOptionsPriceLabel setText:[NSString stringWithFormat:@"$%.2f", hrs * 35]];
    UIFont *nanumGothicBold = [UIFont fontWithName:@"NanumGothicBold" size:17.0];
    [_wouldYouLikeToLabel setFont:nanumGothicBold];
    [_wouldYouLikeToLabel setTextColor:UIColorFromRGB(0x8a8a8a)];
    [self.myTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                  animated:NO
                            scrollPosition:UITableViewScrollPositionTop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.cleanOptions.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CleanOptionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIFont *nanumGothic = [UIFont fontWithName:@"NanumGothic" size:15.0];
    cell.cleanOptionLabel.font = nanumGothic;
    cell.cleanOptionLabel.text = [self.cleanOptions objectAtIndex:indexPath.row];
    
    UIFont *nanumGothicBold = [UIFont fontWithName:@"NanumGothicBold" size:15.0];
    cell.addTime.font = nanumGothicBold;
    [cell.addTime setTextColor:[UIColor greenColor]];
    
    if (indexPath.row == 0) {
        cell.addTime.text = @"(+0 hours)";
        cell.tickmarkImageView.image = [UIImage imageNamed:@"tickmark.png"];
        cell.iconImageView.hidden = YES;
    }
    if (indexPath.row == 1) {
        cell.addTime.text = @"(+1 hour)";
        cell.iconImageView.image = [UIImage imageNamed:@"get-it-clean.png"];
    }
    if (indexPath.row == 2) {
        cell.addTime.text = @"(+2 hours)";
        cell.iconImageView.image = [UIImage imageNamed:@"deep-clean.png"];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    CleanOptionsTableViewCell *cell = (CleanOptionsTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.iconImageView.hidden = YES;
        cell.tickmarkImageView.hidden = NO;
        cell.tickmarkImageView.image = [UIImage imageNamed:@"tickmark.png"];
        [self keepClean];
    }
    if (indexPath.row == 1) {
        cell.iconImageView.hidden = YES;
        cell.tickmarkImageView.hidden = NO;

        cell.tickmarkImageView.image = [UIImage imageNamed:@"tickmark.png"];
        [self getClean];
    }
    if (indexPath.row == 2) {
        cell.iconImageView.hidden = YES;
        cell.tickmarkImageView.hidden = NO;
        cell.tickmarkImageView.image = [UIImage imageNamed:@"tickmark.png"];
        [self deepClean];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CleanOptionsTableViewCell *cell = (CleanOptionsTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [tableView cellForRowAtIndexPath:indexPath].accessoryView = UITableViewCellAccessoryNone;
    if (indexPath.row == 0) {
        //cell.addTime.hidden = NO;
        cell.iconImageView.hidden = NO;
        cell.tickmarkImageView.hidden = YES;
        cell.iconImageView.image = [UIImage imageNamed:@"keep-it-clean.png"];
    }
    if (indexPath.row == 1) {
        //cell.addTime.hidden = NO;
        cell.iconImageView.hidden = NO;
        cell.tickmarkImageView.hidden = YES;
        cell.iconImageView.image = [UIImage imageNamed:@"get-it-clean.png"];
    }
    if (indexPath.row == 2) {
        //cell.addTime.hidden = NO;
        cell.iconImageView.hidden = NO;
        cell.tickmarkImageView.hidden = YES;
        cell.iconImageView.image = [UIImage imageNamed:@"deep-clean.png"];
    }
}

-(void) keepClean
{
    _options = @"Keep Clean";
    double price = hrs;
    double totalPrice = price*35;
    [_cleanOptionsPriceLabel setText:[NSString stringWithFormat:@"$%.2f", totalPrice]];
    [self updateKeepCleanHourLabel];
}

-(void) getClean
{
    _options = @"Get Clean";
    double price = (hrs + 1);
    double totalPrice = price*35;
    [_cleanOptionsPriceLabel setText:[NSString stringWithFormat:@"$%.2f", totalPrice]];
    [self updateGetCleanHourLabel];
}

-(void) deepClean
{
    _options = @"Deep Clean";
    double price = (hrs + 2);
    double totalPrice = price*35;
    [_cleanOptionsPriceLabel setText:[NSString stringWithFormat:@"$%.2f", totalPrice]];
    [self updateDeepCleanHourLabel];
}

-(void) updateKeepCleanHourLabel
{
    double hours = hrs;
    [_cleanOptionsHourLabel setText:[NSString stringWithFormat:@"%.2f", hours]];
}

-(void) updateGetCleanHourLabel
{
    double hours = hrs + 1;
    [_cleanOptionsHourLabel setText:[NSString stringWithFormat:@"%.2f", hours]];
}

-(void) updateDeepCleanHourLabel
{
    double hours = hrs + 2;
    [_cleanOptionsHourLabel setText:[NSString stringWithFormat:@"%.2f", hours]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *order = appDelegate.orderDict;
    [order setValue:_options forKey:@"CleanOptions"];
    NSLog(@"%@", order);
    HowOftenViewController *destVc = [segue destinationViewController];
    destVc.howOftenHourString = _cleanOptionsHourLabel.text;
}


@end
