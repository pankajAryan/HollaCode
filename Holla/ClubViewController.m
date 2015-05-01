//
//  ClubViewController.m
//  Holla
//
//  Created by Ashish Singal on 16/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "ClubViewController.h"
#import "ClubDetailViewController.h"
#import "ContainerViewController.h"
#import "RootViewController.h"

#import "AMNetworkClient.h"
#import "HConstants.h"

#import "UtilityClass.h"

@interface ClubViewController ()
{

    NSDictionary* dict_clubs;
    NSArray* array_sectionTitles;
    NSArray *clubIndexTitles;
    
    NSArray* ClubListArray;

}

@end

@implementation ClubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
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
     */
    
    [AMNetworkClient instance].delegate = self;
    
    if (DUMMYDATA) {
        NSDictionary* dict_HomeDetail = [[NSDictionary alloc] initWithObjectsAndKeys:@"70.2",@"curr_lat",
                                        @"70.2",@"curr_Long",
                                         @"2",@"cityId",
                                         [UtilityClass getDeviceUDID],@"deviceId",

                                        nil];

        [UtilityClass showSpinnerWithMessage:@"Fetching Data.." :self];
        [[AMNetworkClient instance] fetchClubList:dict_HomeDetail];
    }
    
    ClubListArray = [[NSArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clucbcellIdentifier"];
    
    
    // Configure the cell...
    NSString *sectionTitle = [array_sectionTitles objectAtIndex:indexPath.section];
    NSArray *arrayOfSections = [dict_clubs objectForKey:sectionTitle];
    
    
    NSDictionary *SectionClub = [ClubListArray objectAtIndex:indexPath.row];
    
    
    /*
     aboutClub = "Best clubs in city where you can enjoy drink dj dance etc";
     approxCost = 2000;
     clubClosingTime = "11:30 PM";
     clubContact = 9810802581;
     clubId = 1;
     clubLat = "28.56";
     clubLikes = 7;
     clubLocation = "Gabbar , Gurgaon";
     clubLong = "77.2";
     clubName = GABBAR;
     clubStartTime = "10:00 AM";
     clubsDistanceFromCurrLoc = "4651.61";
     fabCount = 1;
     userFabFlag = N;
     */
    //missing bookmark key & value,
    //distance in time and km.
    //bookmark count and favorite count should be string
    //duration is not been given
    
    UILabel *clubName =(UILabel *)[cell viewWithTag:21];
    UILabel *clubLocation =(UILabel *)[cell viewWithTag:22];
    UILabel *timings =(UILabel *)[cell viewWithTag:23];
    UILabel *approxCost =(UILabel *)[cell viewWithTag:24];
    UILabel *approxCostText =(UILabel *)[cell viewWithTag:25];
    UIButton *fabCount =(UIButton *)[cell viewWithTag:26];

    
    [clubName setText:[SectionClub objectForKey:@"clubName"]];
    [clubLocation setText:[SectionClub objectForKey:@"clubLocation"]];
    [timings setText:[NSString stringWithFormat:@"Hours: %@-%@",[SectionClub objectForKey:@"clubStartTime"],[SectionClub objectForKey:@"clubClosingTime"]]];
    [approxCost setText:[SectionClub objectForKey:@"approxCost"]];
    [approxCostText setText:[SectionClub objectForKey:@"approxCostText"]];
    
    NSString* favCount = @"NA";//[NSString stringWithFormat:@"%ld",[SectionClub objectForKey:@"fabCount"]];
    [fabCount setTitle:favCount forState:UIControlStateNormal];

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClubDetailViewController* clubD = (ClubDetailViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ClubdetailId"];
    clubD.dict_selectedClub = [ClubListArray objectAtIndex:indexPath.row];
    
    NSArray* viewControllers = [self.navigationController viewControllers];
    ContainerViewController* ct_vc = (ContainerViewController*)self.parentViewController;
    
    [ct_vc swapFromViewController:[ct_vc.childViewControllers objectAtIndex:0] toViewController:clubD];
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
    [header.textLabel setTextColor:[UIColor colorWithRed:251.0/255.0 green:251.0/255.0 blue:251.0/255.0 alpha:1.0]];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [array_sectionTitles indexOfObject:title];
}
/*
 
 {
 errorCode = 0;
 errorMessage = Success;
 object =     {
 djs =         (
 {
 aboutDj = "Good musician , play gutar,drum etc";
 djCatg = "music masti and dj";
 djId = 1;
 djImgUrl = "img_url";
 djName = XYZ;
 fabCount = 1;
 likeCount = 1;
 userFabFlag = N;
 },
 {
 aboutDj = "A singer. sing song";
 djCatg = "song,punjabi";
 djId = 2;
 djImgUrl = "img_url";
 djName = ABC;
 fabCount = 0;
 likeCount = 1;
 userFabFlag = N;
 }
 );
 events =         (
 );
 };
 }

 */
-(void)GetClubRequestFinished:(id)JSON{
    
    NSLog(@"GetClubRequestFinished Finish Response %@",JSON);
    [UtilityClass hideSpinner];
    
    NSMutableArray* KeyArray = [[NSMutableArray alloc] init];

    if ([[JSON objectForKey:@"errorCode"] intValue] == 0) {
        ClubListArray = [JSON objectForKey:@"object"];
        
        
        for (int i =0 ; i < [ClubListArray count]; i++) {

            NSString* clubName = [[ClubListArray objectAtIndex:i] objectForKey:@"clubName"];
            NSString* strFirstCharacter = [clubName substringToIndex:1];
            
            if (![KeyArray containsObject:strFirstCharacter]) {
                [KeyArray addObject:strFirstCharacter];
            }
        }
        
        NSMutableDictionary* FinalDict = [NSMutableDictionary new];
        
        for (int i =0 ; i < [KeyArray count]; i++) {
            
            NSString* alphabetKey = [KeyArray objectAtIndex:i];
            NSMutableArray* clubArrayWithSpecificKey = [NSMutableArray new];

            for (int j = 0; j<[ClubListArray count]; j++) {
                
                NSString* clubName = [[ClubListArray objectAtIndex:i] objectForKey:@"clubName"];
                if ([clubName hasPrefix:alphabetKey]) {
                    [clubArrayWithSpecificKey addObject:clubName];
                }
            }
            
            [FinalDict setValue:clubArrayWithSpecificKey forKey:alphabetKey];
        }
        
        NSLog(@"Final Dict [%@]",FinalDict);
        
        /*
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
         */
        dict_clubs = FinalDict;
        
        array_sectionTitles = [[dict_clubs allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        clubIndexTitles = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
        
        [tableClubList reloadData];


    }
}
-(void)GetClubFailed:(id)Errorresponses{
    
    NSLog(@"GetHomeFailed %@",Errorresponses);
    [UtilityClass hideSpinner];

    
}

@end
