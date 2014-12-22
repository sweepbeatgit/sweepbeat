//
//  ExtrasViewController.m
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/19/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import "ExtrasViewController.h"
#import "ContactViewController.h"
#import "AppDelegate.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha: 1.0]

@interface ExtrasViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *extrasLabel;
@property NSMutableSet *optionsSet;
@end
@implementation ExtrasViewController


float price;
float inithour;
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
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xffffff);
    [self.navigationController setNavigationBarHidden:NO];
//    [self.navigationController.navigationBar
//     setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xc4c4c4)}];
    self.optionsSet = [[NSMutableSet alloc]init];
    self.tableView.allowsMultipleSelection = YES;
    // Back Button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xC90117)];
    self.options = @[@"Inside Cabinets", @"Inside Fridge", @"Inside Oven", @"Laundry Wash & Dry", @"Interior Windows"];
//    self.tableView.layer.borderColor = [[UIColor colorWithRed:218/255.0f green:73/255.0f blue:73/255.0f alpha:1]CGColor];
//    self.tableView.layer.borderWidth = 1.5;
//    self.tableView.layer.cornerRadius = 5.0;
    
    UIFont *nanumGothic4 = [UIFont fontWithName:@"NanumGothic" size:22.0];
    UIFont *nanumGothic3 = [UIFont fontWithName:@"NanumGothic" size:17.0];
    UIFont *nanumGothicBold = [UIFont fontWithName:@"NanumGothicBold" size:17.0];
    [_extrasLabel setFont:nanumGothicBold];
    [_extrasLabel setTextColor:UIColorFromRGB(0x8a8a8a)];
    [self.hoursLabel setFont:nanumGothic3];
    [self.hoursTextLabel setFont:nanumGothic3];
    [self.priceLabel setFont:nanumGothic4];
    
    
    _hoursLabel.text = _hoursString;
    _hoursTextLabel.text = @"hours";
    hrs = [_hoursString floatValue];
    [_priceLabel setText:[NSString stringWithFormat:@"$%.2f", hrs * 35]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateHourLabel
{
    [_hoursLabel setText:[NSString stringWithFormat:@"%.2f", hrs]];
    [_priceLabel setText:[NSString stringWithFormat:@"$%.2f", hrs * 35]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExtrasTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIFont *nanumGothic = [UIFont fontWithName:@"NanumGothic" size:15.0];
    cell.extraOptionsLabel.font = nanumGothic;
    cell.extraOptionsLabel.text = [self.options objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        cell.extraOptionsIcons.image = [UIImage imageNamed:@"icon-cabinet"];
    }
    if (indexPath.row == 1) {
        cell.extraOptionsIcons.image = [UIImage imageNamed:@"icon-fridge"];
    }
    if (indexPath.row == 2) {
        cell.extraOptionsIcons.image = [UIImage imageNamed:@"icon-oven"];
    }
    if (indexPath.row == 3) {
        cell.extraOptionsIcons.image = [UIImage imageNamed:@"icon-laundry"];
    }
    if (indexPath.row == 4) {
        cell.extraOptionsIcons.image = [UIImage imageNamed:@"icon-window"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExtrasTableViewCell *cell = (ExtrasTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.extraOptionsIcons.hidden = YES;
        cell.extraOptionsImageView.hidden = NO;
        cell.extraOptionsImageView.image = [UIImage imageNamed:@"tickmark.png"];
    }
    if (indexPath.row == 1) {
        cell.extraOptionsIcons.hidden = YES;
        cell.extraOptionsImageView.hidden = NO;
        cell.extraOptionsImageView.image = [UIImage imageNamed:@"tickmark.png"];
    }
    if (indexPath.row == 2) {
        cell.extraOptionsIcons.hidden = YES;
        cell.extraOptionsImageView.hidden = NO;
        cell.extraOptionsImageView.image = [UIImage imageNamed:@"tickmark.png"];
    }
    if (indexPath.row == 3) {
        cell.extraOptionsIcons.hidden = YES;
        cell.extraOptionsImageView.hidden = NO;
        cell.extraOptionsImageView.image = [UIImage imageNamed:@"tickmark.png"];
    }
    if (indexPath.row == 4) {
        cell.extraOptionsIcons.hidden = YES;
        cell.extraOptionsImageView.hidden = NO;
        cell.extraOptionsImageView.image = [UIImage imageNamed:@"tickmark.png"];
    }
    hrs = hrs + 0.5;
    [self.optionsSet addObject:[self.options objectAtIndex:indexPath.row]];
    [self updateHourLabel];

}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExtrasTableViewCell *cell = (ExtrasTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.extraOptionsIcons.image = [UIImage imageNamed:@"icon-cabinet"];
        cell.extraOptionsImageView.hidden = YES;
        cell.extraOptionsIcons.hidden = NO;
    }
    if (indexPath.row == 1) {
        cell.extraOptionsIcons.image = [UIImage imageNamed:@"icon-fridge"];
        cell.extraOptionsImageView.hidden = YES;
        cell.extraOptionsIcons.hidden = NO;
    }
    if (indexPath.row == 2) {
        cell.extraOptionsIcons.image = [UIImage imageNamed:@"icon-oven"];
        cell.extraOptionsImageView.hidden = YES;
        cell.extraOptionsIcons.hidden = NO;
    }
    if (indexPath.row == 3) {
        cell.extraOptionsIcons.image = [UIImage imageNamed:@"icon-laundry"];
        cell.extraOptionsImageView.hidden = YES;
        cell.extraOptionsIcons.hidden = NO;
    }
    if (indexPath.row == 4) {
        cell.extraOptionsIcons.image = [UIImage imageNamed:@"icon-window"];
        cell.extraOptionsImageView.hidden = YES;
        cell.extraOptionsIcons.hidden = NO;
    }
    [tableView cellForRowAtIndexPath:indexPath].accessoryView = UITableViewCellAccessoryNone;
    [self.optionsSet removeObject:[self.options objectAtIndex:indexPath.row]];
    hrs = hrs - 0.5;
    [self updateHourLabel];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ContactViewController *destVc = [segue destinationViewController];
    destVc.contactHourString = _hoursLabel.text;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *order = appDelegate.orderDict;
    [order setValue:self.optionsSet forKey:@"Extras"];
    NSLog(@"%@", order);
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
