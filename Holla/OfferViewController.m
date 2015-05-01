//
//  OfferViewController.m
//  Holla
//
//  Created by Ashish Singal on 26/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "OfferViewController.h"
#import "OfferDetailViewController.h"
#import "ContainerViewController.h"
#import "RootViewController.h"
#import "UtilityClass.h"


@interface OfferViewController ()
{    
    NSDictionary* dict_clubs;
    NSArray* array_sectionTitles;
    NSArray *clubIndexTitles;


}
@end

@implementation OfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    dict_clubs = @{
                   @"A" : @[@"Azura"],
                   @"B" : @[@"Bora Boar", @"Black Swan"],
                   @"C" : @[@"Cabera"],
                   @"D" : @[@"Doremon Pub"],
                   @"E" : @[@"Elephanta Caves"],
                   @"G" : @[@"Gazilla Tortilla"],
                   @"H" : @[@"Hikri"],
                   @"K" : @[@"Korono"],
                   @"L" : @[@"Las Masti"],
                   @"M" : @[@"Money Maze"],
                   @"P" : @[@"Party Pepper"],
                   @"R" : @[@"Rose Dome"],
                   @"S" : @[@"Sitare June"],
                   @"T" : @[@"Taco Jazzy"],
                   @"W" : @[@"Wombat Zone"],
                   @"#" : @[@"39"]
                   };
    
    array_sectionTitles = [[dict_clubs allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    clubIndexTitles = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
    [AMNetworkClient instance].delegate = self;

    if (DUMMYDATA) {
        NSDictionary* dict_HomeDetail = [[NSDictionary alloc] initWithObjectsAndKeys:
                                         [UtilityClass getDeviceUDID],@"deviceId",
                                         @"22",@"curr_lat",
                                         @"72",@"curr_Long",@"2",@"cityId",
                                         nil];
        
        [UtilityClass showSpinnerWithMessage:@"Fetching Data.." :self];
        [[AMNetworkClient instance] fetchOffers:dict_HomeDetail];
    }



}
-(void)viewDidAppear:(BOOL)animated
{
    NSArray* viewControllers = [self.navigationController viewControllers];
    DLog(@"viewControllers [%@]",viewControllers);
    DLog(@"parentViewController [%@]",self.parentViewController);
    
    RootViewController* rootVc = (RootViewController*)[viewControllers objectAtIndex:1];
    [rootVc.button_home setBackgroundImage:[UIImage imageNamed:@"homeImageSelected"] forState:UIControlStateNormal];
    [rootVc.button_home setBackgroundImage:[UIImage imageNamed:@"homeImageSelected"] forState:UIControlStateSelected];
    
    [rootVc.button_home setFrame:CGRectMake(2, 22, 30, 30)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [array_sectionTitles objectAtIndex:section];
    NSArray *sectionAnimals = [dict_clubs objectForKey:sectionTitle];
    return [sectionAnimals count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"offercellIdentifier"];
    
    
    
    // Configure the cell...
    NSString *sectionTitle = [array_sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionAnimals = [dict_clubs objectForKey:sectionTitle];
    NSString *animal = [sectionAnimals objectAtIndex:indexPath.row];
    
    UILabel *lblClub_name =(UILabel *)[cell viewWithTag:21];
    [lblClub_name setText:animal];
    
    
    //cell.textLabel.text = animal;
    
    
    
    return cell;

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OfferDetailViewController* offerD = (OfferDetailViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"OfferdetailId"];
    
    NSArray* viewControllers = [self.navigationController viewControllers];
    DLog(@"viewControllers [%@]",viewControllers);
    DLog(@"parentViewController [%@]",self.parentViewController);
    ContainerViewController* ct_vc = (ContainerViewController*)self.parentViewController;
    
    [ct_vc swapFromViewController:[ct_vc.childViewControllers objectAtIndex:0] toViewController:offerD];
}

//section titles
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    tableView.sectionIndexColor = [UIColor whiteColor];
    return clubIndexTitles;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [array_sectionTitles count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [array_sectionTitles objectAtIndex:section];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor colorWithRed:203.0/255.0 green:29.0/255.0 blue:27.0/255.0 alpha:0.8];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [array_sectionTitles indexOfObject:title];
}
-(void)GetOffersListRequestFinished:(id)JSON{
    
    NSLog(@"GetMusciCategoriesRequestFinished Finish Response %@",JSON);
    [UtilityClass hideSpinner];
    
    if ([[JSON objectForKey:@"errorCode"] intValue] == 0) {
        
    }
}
-(void)GetOffersListFailed:(id)Errorresponses
{
    NSLog(@"GetMusciCategoriesFailed %@",Errorresponses);
    [UtilityClass hideSpinner];
}

@end
