//
//  ClubDetailViewController.m
//  Holla
//
//  Created by Ashish Singal on 25/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "ClubDetailViewController.h"
#import "CollapseClick.h"
#import "RootViewController.h"
#import "UtilityClass.h"
#import "CMFGalleryCell.h"
#import "HConstants.h"
#import "UIImageView+AFNetworking.h"


@interface ClubDetailViewController ()
{
    IBOutlet UICollectionView* collectionView;
    NSArray* weekProgramArray;
    
    NSString* sundayString;// = @"NO event this day";
    NSString* mondayString;//= @"NO event this day";
    NSString* tuesdayString;//= @"NO event this day";
    NSString* wednesdayString;//= @"NO event this day";
    NSString* thursdayString;//= @"NO event this day";
    NSString* fridayString;//= @"NO event this day";
    NSString* saturdayString;//= @"NO event this day";

}
@end

@implementation ClubDetailViewController

@synthesize dict_selectedClub;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    myCollapseClick.CollapseClickDelegate = self;
    //[myCollapseClick reloadCollapseClick];
    
    // If you want a cell open on load, run this method:
   // [myCollapseClick openCollapseClickCellAtIndex:1 animated:NO];
    
    [main_scroll setContentSize:CGSizeMake(320, 700)];
    
    NSLog(@"Contentsize {%f}",myCollapseClick.contentSize.height);
    myCollapseClick.scrollEnabled = NO;
    
    
    [AMNetworkClient instance].delegate = self;
    
    if (DUMMYDATA) {
        NSDictionary* dict_HomeDetail = [[NSDictionary alloc] initWithObjectsAndKeys:
                                         [dict_selectedClub objectForKey:@"clubId"],@"clubId",
                                         [UtilityClass getDeviceUDID],@"deviceId",

                                         nil];
        
        [UtilityClass showSpinnerWithMessage:@"Fetching Data.." :self];
        [[AMNetworkClient instance] fetchClubDetail:dict_HomeDetail];
    }

    
    NSLog(@"Selected Club [%@]",dict_selectedClub);
    weekProgramArray = [NSArray new];
    
     sundayString = @"NO event this day";
     mondayString= @"NO event this day";
    tuesdayString= @"NO event this day";
    wednesdayString= @"NO event this day";
     thursdayString= @"NO event this day";
    fridayString= @"NO event this day";
     saturdayString= @"NO event this day";

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
#pragma mark - Collapse Click Delegate
// Required Methods
-(int)numberOfCellsForCollapseClick {
    return 7;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index {
    
  
    /*
    {
        eventDay = Monday;
        eventDescription = "whole night party with free drink and DJ";
        eventId = 1;
        eventName = "Party nights";
        eventStartDate = "24-03-2015";
        eventStartTime = "9:00 PM";
        eventType = Regular;
    },
*/
    
    
    switch (index) {
        case 0:
            return sundayString;
            break;
        case 1:
            return saturdayString;
            break;
        case 2:
            return fridayString;
            break;

        case 3:
            return thursdayString;
            break;
        case 4:
            return wednesdayString;
            break;
        case 5:
            return tuesdayString;
            break;
        case 6:
            return mondayString;
            break;
            
        default:
            return @"No event this day";
            break;
    }
}

-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index {
    switch (index) {
        case 0:
            return test1View;
            break;
        case 1:
            return test2View;
            break;
        case 2:
            return test3View;
            break;
        case 3:
            return test4View;
            break;
        case 4:
            return test5View;
            break;
        case 5:
            return test6View;
            break;
        case 6:
            return test7View;
            break;
            
        default:
            return test3View;
            break;
    }
    
}


// Optional Methods
/*
 -(UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index {
 return [UIColor colorWithRed:223/255.0f green:47/255.0f blue:51/255.0f alpha:1.0];
 }
 
 
 -(UIColor *)colorForTitleLabelAtIndex:(int)index {
 return [UIColor colorWithWhite:1.0 alpha:0.85];
 }
 */
-(UIColor *)colorForTitleArrowAtIndex:(int)index {
    return [UIColor grayColor];
}


-(void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open {
    NSLog(@"%d and it's open:%@", index, (open ? @"YES" : @"NO"));

    NSLog(@"Contentsize height{%f}",myCollapseClick.frame.size.height);

    NSLog(@"Contentsize open{%f}",myCollapseClick.contentSize.height);
    
    [myCollapseClick setFrame:CGRectMake(myCollapseClick.frame.origin.x, myCollapseClick.frame.origin.y, myCollapseClick.frame.size.width, myCollapseClick.contentSize.height)];

    [menuView setFrame:CGRectMake(menuView.frame.origin.x, myCollapseClick.frame.size.height+190, menuView.frame.size.width, menuView.frame.size.height)];
    
    [main_scroll setContentSize:CGSizeMake(320, menuView.frame.origin.y + 230)];


}


#pragma mark - TextField Delegate for Demo
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)fetchClubImage :(NSString*)ImageURL :(UIImageView*)imageViewForClub
{
    [UtilityClass showSpinnerWithMessage:@"fetching data..." :self];
    NSURL *url = [NSURL URLWithString:ImageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    DLog(@"Image URL [%@]",ImageURL);
    
    [imageViewForClub setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        imageViewForClub.image = image;
        
        [UtilityClass hideSpinner];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
        UIImage* defaultImage = [UIImage imageNamed:@"default-club"];
        [UtilityClass hideSpinner];
        
    }];
}

#pragma mark - BUTTON IMAGES
-(IBAction)menuButtonAction:(id)sender
{
    NSArray* viewControllers = [self.navigationController viewControllers];
    DLog(@"viewControllers [%@]",viewControllers);
    DLog(@"parentViewController [%@]",self.parentViewController);
    
    RootViewController* rootVc = (RootViewController*)[viewControllers objectAtIndex:1];
    [rootVc.view bringSubviewToFront:rootVc.view_evenDetailMenu];
    
    [UIView animateWithDuration:0.6 animations:^{
        [rootVc.view_evenDetailMenu setHidden:NO];
    }];
}
-(IBAction)callToClub:(id)sender
{
    [UtilityClass callToHelpCenterWithNumber:@""];
}

-(void)GetClubDetailRequestFinished:(id)JSON{
    
    
    /*
     
     errorCode = 0;
     errorMessage = Success;
     object =     {
     clubEvents =         (
     {
     eventDay = Monday;
     eventDescription = "whole night party with free drink and DJ";
     eventId = 1;
     eventName = "Party nights";
     eventStartDate = "24-03-2015";
     eventStartTime = "9:00 PM";
     eventType = Regular;
     },
     {
     eventDay = "every day";
     eventDescription = "Sonu nigam live music";
     eventId = 2;
     eventName = Music;
     eventStartDate = "30-03-2015";
     eventStartTime = "8:00 PM";
     eventType = Regular;
     }
     );
     clubFullAddress = "515 MGF Mall NH 58 MG Metro Station Gurgaon";
     clubImgUrl = "http://128.199.99.127/hollaserver/clubimage/1/club.png";
     images =         (
     {
     imageName = "http://128.199.99.127/hollaserver/clubimage/1/club.png";
     imageUrl = logo;
     },
     {
     imageName = "http://128.199.99.127/hollaserver/clubimage/1/m1.jpg";
     imageUrl = menu;
     },
     {
     imageName = "http://128.199.99.127/hollaserver/clubimage/1/m2.jpg";
     imageUrl = menu;
     },
     {
     imageName = "testimg/test.png";
     imageUrl = offer;
     }
     );
     };
     }

     //image name and logo url value changed.
     //if there is no url please provide something unique.
     //send clubName
     //send start and endtimedate
     // there will be no event like everyday
     */
    
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
    NSLog(@"GetClubRequestFinished Finish Response %@",JSON);
    [UtilityClass hideSpinner];
    
    if ([[JSON objectForKey:@"errorCode"] intValue] == 0) {
        
        NSDictionary* responseDict = [JSON objectForKey:@"object"];
        
        if ([[JSON objectForKey:@"object"] objectForKey:@"clubEvents"] != [NSNull null]) {
            weekProgramArray = [[JSON objectForKey:@"object"] objectForKey:@"clubEvents"];
        }
        
        
        [self fetchClubImage:[responseDict objectForKey:@"clubImgUrl"] :clubImage];
        
        [clubName setText:[dict_selectedClub objectForKey:@"clubName"]];
        [clubAddress setText:[responseDict objectForKey:@"clubFullAddress"]];
        [clubTimings setText:[NSString stringWithFormat:@"Hours: %@-%@",[dict_selectedClub objectForKey:@"clubStartTime"],[dict_selectedClub objectForKey:@"clubClosingTime"]]];
        [clubAmount setText:[dict_selectedClub objectForKey:@"approxCost"]];
        [clubCondition setText:@"NA"];
        [clubDistance setText:[dict_selectedClub objectForKey:@"clubsDistanceFromCurrLoc"]];
        [clubDuration setText:@"NA"];//[dict_selectedClub objectForKey:@"clubsDistanceFromCurrLoc"]];
        [clubBookmark setText:@"NA"];//[dict_selectedClub objectForKey:@"clubsDistanceFromCurrLoc"]];
        [clubLikeButton setTitle:@"NA" forState:UIControlStateNormal];//[dict_selectedClub objectForKey:@"clubsDistanceFromCurrLoc"]];
        [clubAboutUs setText:[dict_selectedClub objectForKey:@"aboutClub"]];

        
        
        __weak IBOutlet UIButton *menuButton1;
        
        __weak IBOutlet UILabel *labelMenu1;
        
        __weak IBOutlet UIButton *menuButton2;
        
        __weak IBOutlet UILabel *labelMenu2;
        
        __weak IBOutlet UIButton *menuButton3;
        
        __weak IBOutlet UILabel *labelMenu3;
        
        __weak IBOutlet UIButton *menuButtonMultiple;
        
        __weak IBOutlet UILabel *labelMenuMultiple;
        
        for (int i =0; i<[weekProgramArray count]; i++) {
            if ([[[weekProgramArray objectAtIndex:i] objectForKey:@"eventDay"] isEqualToString:@"Sunday"]) {
                sundayString = [[weekProgramArray objectAtIndex:i] objectForKey:@"eventName"];
            }
            else if ([[[weekProgramArray objectAtIndex:i] objectForKey:@"eventDay"] isEqualToString:@"Monday"])
            {
                mondayString = [[weekProgramArray objectAtIndex:i] objectForKey:@"eventName"];
                
            }
            else if ([[[weekProgramArray objectAtIndex:i] objectForKey:@"eventDay"] isEqualToString:@"Tuesday"])
            {
                tuesdayString = [[weekProgramArray objectAtIndex:i] objectForKey:@"eventName"];
                
            }
            else if ([[[weekProgramArray objectAtIndex:i] objectForKey:@"eventDay"] isEqualToString:@"Wednesday"])
            {
                wednesdayString = [[weekProgramArray objectAtIndex:i] objectForKey:@"eventName"];
                
            }
            else if ([[[weekProgramArray objectAtIndex:i] objectForKey:@"eventDay"] isEqualToString:@"Thursday"])
            {
                thursdayString = [[weekProgramArray objectAtIndex:i] objectForKey:@"eventName"];
                
            }
            else if ([[[weekProgramArray objectAtIndex:i] objectForKey:@"eventDay"] isEqualToString:@"Friday"])
            {
                fridayString = [[weekProgramArray objectAtIndex:i] objectForKey:@"eventName"];
                
            }
            else if ([[[weekProgramArray objectAtIndex:i] objectForKey:@"eventDay"] isEqualToString:@"Saturday"])
            {
                saturdayString = [[weekProgramArray objectAtIndex:i] objectForKey:@"eventName"];
                
            }
            else
            {
                
            }
        }

        
        [myCollapseClick reloadCollapseClick];
    }
}
-(void)GetClubDetailFailed:(id)Errorresponses{
    
    NSLog(@"GetHomeFailed %@",Errorresponses);
    [UtilityClass hideSpinner];
    
    
}

@end
