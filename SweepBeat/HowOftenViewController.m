//
//  HowOftenViewController.m
//  SweepBeat
//
//  Created by Arjun Madgavkar on 8/18/14.
//  Copyright (c) 2014 NYC Labs. All rights reserved.
//

#import "HowOftenViewController.h"
#import "HowOftenTableViewCell.h"
#import "AppDelegate.h"
#import "AddressViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha: 1.0]

@interface HowOftenViewController ()
@property (strong, nonatomic) IBOutlet UILabel *howOftenLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSString *howoften;

@end

@implementation HowOftenViewController

double hrs;

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
    _howoften = @"Once";
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xffffff);
    [self.navigationController setNavigationBarHidden:NO];
    // Back Button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xC90117)];
    discountOptions = @[@"Once", @"Every Week", @"Every 2 Weeks", @"Every 4 Weeks"];
//    self.tableView.layer.borderColor = [[UIColor colorWithRed:218/255.0f green:73/255.0f blue:73/255.0f alpha:1]CGColor];
//    self.tableView.layer.borderWidth = 1.5;
//    self.tableView.layer.cornerRadius = 5.0;
    
    UIFont *nanumGothic3 = [UIFont fontWithName:@"NanumGothic" size:17.0];
    UIFont *nanumGothic4 = [UIFont fontWithName:@"NanumGothic" size:22.0];
    UIFont *nanumGothicBold = [UIFont fontWithName:@"NanumGothicBold" size:17.0];
    [_howOftenLabel setFont:nanumGothicBold];
    [_howOftenLabel setTextColor:UIColorFromRGB(0x8a8a8a)];
    [self.howOftenHourTextLabel setFont:nanumGothic3];
    [self.howOftenHourLabel setFont:nanumGothic3];
    [self.howOftenPriceLabel setFont:nanumGothic4];
    
    _howOftenHourLabel.text = _howOftenHourString;
    _howOftenHourTextLabel.text = @"hours";
    hrs = [_howOftenHourString doubleValue];
    [_howOftenPriceLabel setText:[NSString stringWithFormat:@"$%.2f", hrs*35]];
   
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
    return discountOptions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HowOftenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HowOftenCell"];
    UIFont *nanumGothic = [UIFont fontWithName:@"NanumGothic" size:15.0];
    cell.textLabel.font = nanumGothic;
    cell.percentageLabel.text = [discountOptions objectAtIndex:indexPath.row];
    
   // UIFont *nanumGothicBold = [UIFont fontWithName:@"NanumGothicBold" size:15.0];
    cell.percentageLabel.font = nanumGothic;

    
    if (indexPath.row == 0) {
        cell.percentageLabel.text = @"Once";
        //cell.tickmarkImage.image = [UIImage imageNamed:@"tickmark.png"];
    }
    if (indexPath.row == 1) {
        cell.percentageLabel.text = @"Every Week";
        cell.discountImage.image = [UIImage imageNamed:@"iconPOR25.png"];
    }
    if (indexPath.row == 2) {
        cell.percentageLabel.text = @"Every 2 Weeks";
        cell.discountImage.image = [UIImage imageNamed:@"iconPOR20.png"];
    }
    if (indexPath.row == 3) {
        cell.percentageLabel.text = @"Every 4 Weeks";
        cell.discountImage.image = [UIImage imageNamed:@"iconPOR15.png"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    HowOftenTableViewCell *cell = (HowOftenTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//    UIImageView *checkMarkView = [[UIImageView alloc] initWithImage:image];
//    [tableView cellForRowAtIndexPath:indexPath].accessoryView = checkMarkView;
  
    if (indexPath.row == 0) {
        cell.tickmarkImage.image = [UIImage imageNamed:@"tickmark.png"];
        cell.discountImage.hidden = YES;
        cell.tickmarkImage.hidden = NO;
        [self oneTime];
    }
    else if (indexPath.row == 1) {
        cell.tickmarkImage.image = [UIImage imageNamed:@"tickmark.png"];
        cell.discountImage.hidden = YES;
        cell.tickmarkImage.hidden = NO;
        [self everyWeek];
    }
    else if (indexPath.row == 2) {
        cell.tickmarkImage.image = [UIImage imageNamed:@"tickmark.png"];
        cell.discountImage.hidden = YES;
        cell.tickmarkImage.hidden = NO;
        [self everyTwoWeeks];
    }
    else if (indexPath.row == 3) {
        cell.tickmarkImage.image = [UIImage imageNamed:@"tickmark.png"];
        cell.discountImage.hidden = YES;
        cell.tickmarkImage.hidden = NO;
        [self everyFourWeeks];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HowOftenTableViewCell *cell = (HowOftenTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        //cell.discountImage.image = [UIImage imageNamed:@"tickmark.png"];
        cell.discountImage.hidden = NO;
        cell.tickmarkImage.hidden = YES;
        [self oneTime];
    }
    else if (indexPath.row == 1) {
        cell.discountImage.image = [UIImage imageNamed:@"iconPOR25.png"];
        cell.discountImage.hidden = NO;
        cell.tickmarkImage.hidden = YES;
        [self everyWeek];
    }
    else if (indexPath.row == 2) {
        cell.discountImage.image = [UIImage imageNamed:@"iconPOR20.png"];
        cell.discountImage.hidden = NO;
        cell.tickmarkImage.hidden = YES;
        [self everyTwoWeeks];
    }
    else if (indexPath.row == 3) {
        cell.discountImage.image = [UIImage imageNamed:@"iconPOR15.png"];
        cell.discountImage.hidden = NO;
        cell.tickmarkImage.hidden = YES;
        [self everyFourWeeks];
    }
}

-(void) oneTime
{
    _howoften = @"Once";
    double totalPrice = hrs*35;
    [_howOftenPriceLabel setText:[NSString stringWithFormat:@"$%.2f", totalPrice]];
}

-(void) everyWeek
{
    _howoften = @"Every week";
    double price = (hrs*35);
    double totalPrice = price - (price*.25);
    [_howOftenPriceLabel setText:[NSString stringWithFormat:@"$%.2f", totalPrice]];
}

-(void) everyTwoWeeks
{
    _howoften = @"Every 2 weeks";
    double price = (hrs*35);
    double totalPrice = price - (price*.20);
    [_howOftenPriceLabel setText:[NSString stringWithFormat:@"$%.2f", totalPrice]];
}

-(void) everyFourWeeks
{
    _howoften = @"Every 4 weeks";
    double price = (hrs*35);
    double totalPrice = price - (price*.15);
    [_howOftenPriceLabel setText:[NSString stringWithFormat:@"$%.2f", totalPrice]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *order = appDelegate.orderDict;
    [order setValue:_howoften forKey:@"HowOften"];
    NSLog(@"%@", order);
    AddressViewController *destVc = [segue destinationViewController];
    destVc.addressHourString = _howOftenHourLabel.text;
}


@end
