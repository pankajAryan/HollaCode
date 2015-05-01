//
//  MusicViewController.m
//  Holla
//
//  Created by Ashish Singal on 19/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "MusicViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MusicDetailViewController.h"
#import "ContainerViewController.h"
#import "RootViewController.h"


#import "UtilityClass.h"
#import "HConstants.h"

@interface MusicViewController ()
{

    
    
    NSArray* array_musicName;
    
    NSArray* musicArray;
    
    IBOutlet UITableView* tableMusic;



}

@end

@implementation MusicViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //array_musicName = [[NSArray alloc] initWithObjects:@"ALTERNATE",@"CLASSICAL",@"BOLLYWOOD",@"BLUES",@"EDM",@"HIP-HOP/RAP",@"INDIE-POP", nil];
    
    [AMNetworkClient instance].delegate = self;
    
    if (DUMMYDATA) {
        NSDictionary* dict_HomeDetail = [[NSDictionary alloc] initWithObjectsAndKeys:
                                         [UtilityClass getDeviceUDID],@"deviceId",
                                         nil];
        
        [UtilityClass showSpinnerWithMessage:@"Fetching Data.." :self];
        [[AMNetworkClient instance] fetchMusicCategories:dict_HomeDetail];
    }

    musicArray = [NSMutableArray new];
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [musicArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  /*
    catgId = 1;
    catgLikes = 0;
    catgName = ALTERNATIVE;
    fabCount = 0;
    fabFlag = N;
*/
    //musiclist: catglike and fabcount should be string

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clucbcellIdentifier"];
    
    UILabel *lbl_musicTitle =(UILabel *)[cell viewWithTag:21];
    UIButton *fabCount =(UIButton *)[cell viewWithTag:22];
    UILabel *lbl_bookmark =(UILabel *)[cell viewWithTag:23];

    
    NSDictionary* musicCaDict = [NSDictionary new];
    musicCaDict = [musicArray objectAtIndex:indexPath.row];
    
    
    [lbl_musicTitle setText:[musicCaDict objectForKey:@"catgName"]];
    [lbl_bookmark setText:[musicCaDict objectForKey:@"fabCount"]];
    [fabCount setTitle:[musicCaDict objectForKey:@"catgLikes"] forState:UIControlStateNormal];
    

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MusicDetailViewController* musicD = (MusicDetailViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"MusicdetailId"];
    
    [musicD setDict_selectedID:[musicArray objectAtIndex:indexPath.row]];
    
    NSArray* viewControllers = [self.navigationController viewControllers];
    DLog(@"viewControllers [%@]",viewControllers);
    DLog(@"parentViewController [%@]",self.parentViewController);
    ContainerViewController* ct_vc = (ContainerViewController*)self.parentViewController;
    
    [ct_vc swapFromViewController:[ct_vc.childViewControllers objectAtIndex:0] toViewController:musicD];

}
-(void)GetMusciCategoriesRequestFinished:(id)JSON
{
    
    NSLog(@"GetMusciCategoriesRequestFinished Finish Response %@",JSON);
    [UtilityClass hideSpinner];
    
    if ([[JSON objectForKey:@"errorCode"] intValue] == 0) {
        musicArray = [JSON objectForKey:@"object"];
        
        [tableMusic reloadData];
    }
}
-(void)GetMusciCategoriesFailed:(id)Errorresponses
{
    NSLog(@"GetMusciCategoriesFailed %@",Errorresponses);
    [UtilityClass hideSpinner];
}

@end
