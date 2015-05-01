//
//  RootViewController.m
//  Holla
//
//  Created by Ashish Singal on 16/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "RootViewController.h"

#import "ClubViewController.h"
#import "ContainerViewController.h"
#import "HConstants.h"
#import "UtilityClass.h"

@interface RootViewController ()

@property (nonatomic, weak) ContainerViewController *containerViewController;


@end

@implementation RootViewController
@synthesize view_evenDetailMenu,view_forEventClubDetail,button_home;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [arrowView setHidden:YES];
    [searchView setHidden:YES];
    [searchView setBackgroundColor:[UIColor clearColor]];
    
    UIColor *color = [UIColor lightTextColor];
    txt_searchTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search By location" attributes:@{NSForegroundColorAttributeName: color}];
    
    lbl_searchedText.text = @"DELHI";
    
    [view_evenDetailMenu setHidden:YES];
    [view_forEventClubDetail setHidden:YES];
    [filerView setHidden:YES];
    
    NSArray* clubArray = [[NSArray alloc] initWithObjects:@"zinghura",@"Ting Tong",@"Dongrilla",@"Monkey Trap",@"Azura",@"Bora Boar",@"Cabera",@"Fish Tank",@"Gazilla Tortilla",@"Hill Pe Dance",@"Sitare June",@"Taco Jazzy",@"Woo kit",@"Zoro", nil];
    [self createStarClubView:clubArray];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{

}

-(void)viewDidAppear:(BOOL)animated
{


}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - BUTTON ACTIONS
-(IBAction)searchButtonCrossAction:(id)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        [searchView setHidden:YES];
        [btn_search setHidden:NO];
        [btn_menu setHidden:NO];

        [btn_search setSelected:NO];
        [lbl_searchedText setHidden:NO];
        
//        [lbl_searchedText setText:txt_searchTextfield.text];
        lbl_searchedText.text = @"DELHI";

    }];
    
}

-(IBAction)HomeButtonAction:(id)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        [arrowView setHidden:YES];
    }];
    
    [self.containerViewController showViewControllerWitdId:HomeControllerId containerView:containerView];
    
    
    [UIView animateWithDuration:2.0 animations:^{
        [button_home setBackgroundImage:[UIImage imageNamed:@"HollaLogo"] forState:UIControlStateNormal];
        [button_home setBackgroundImage:[UIImage imageNamed:@"HollaLogo"] forState:UIControlStateSelected];

    }];
    
    [button_home setFrame:CGRectMake(2, 22, 75, 30)];


}


-(IBAction)ClubButtonAction:(id)sender
{

    [UIView animateWithDuration:0.4 animations:^{
        [arrowView setHidden:NO];
        [arrowView setFrame:CGRectMake(0, arrowView.frame.origin.y, arrowView.frame.size.width, arrowView.frame.size.height)];
    }];
    
    [self.containerViewController showViewControllerWitdId:SegueIdentifierFirst  containerView:containerView];

}

-(IBAction)MusicButtonAction:(id)sender
{

    [UIView animateWithDuration:0.4 animations:^{
        [arrowView setHidden:NO];
        [arrowView setFrame:CGRectMake(84, arrowView.frame.origin.y, arrowView.frame.size.width, arrowView.frame.size.height)];
    }];
    
    [self.containerViewController showViewControllerWitdId:SegueIdentifierSecond  containerView:containerView];


}
-(IBAction)EventButtonAction:(id)sender
{

    [UIView animateWithDuration:0.4 animations:^{
        [arrowView setHidden:NO];
        [arrowView setFrame:CGRectMake(167, arrowView.frame.origin.y, arrowView.frame.size.width, arrowView.frame.size.height)];
    }];

    [self.containerViewController showViewControllerWitdId:SegueIdentifierThird  containerView:containerView];

}
-(IBAction)OfferButtonAction:(id)sender
{

    [UIView animateWithDuration:0.4 animations:^{
        [arrowView setHidden:NO];
        [arrowView setFrame:CGRectMake(246, arrowView.frame.origin.y, arrowView.frame.size.width, arrowView.frame.size.height)];
    }];
    
    [self.containerViewController showViewControllerWitdId:SegueIdentifierFourth  containerView:containerView];
}

-(IBAction)searchButtonClicked:(id)sender
{
    if ([sender isSelected])
    {
        [btn_search setHidden:NO];
        [btn_menu setHidden:NO];

        [lbl_searchedText setHidden:NO];
        [searchView setHidden:YES];
        [sender setSelected:NO];
    }
    else
    {
        [btn_search setHidden:YES];
        [btn_menu setHidden:YES];

        [lbl_searchedText setHidden:YES];
        [searchView setHidden:NO];
        [sender setSelected:YES];
    }
}
-(IBAction)menuButtonClicked:(id)sender
{
    if ([sender isSelected]) {
        [sender setSelected:NO];
    }
    else
        [sender setSelected:YES];
    
    [self.view bringSubviewToFront:filerView];
    [filerView setHidden:NO];
    
    
}
///////===
-(IBAction)mostpopular:(id)sender
{
    if ([sender isSelected]) {
        [lbl_mostpopular setTextColor:[UIColor whiteColor]];
        [sender setSelected:NO];
    }
    else
    {
        [lbl_mostpopular setTextColor:[UIColor yellowColor]];
        [sender setSelected:YES];
    }
}

-(void)createStarClubView:(NSArray*)clubArray
{

    NSLog(@"Club Array [%@]",clubArray);
    
    for (int i = 0; i< [clubArray count]; i++) {
        
        int y_starbutton = 230+i*22;
        
        UIButton* starClubButtonSelection = [[UIButton alloc] initWithFrame:CGRectMake(20, y_starbutton, 20, 20)];
        [starClubButtonSelection setImage:[UIImage imageNamed:@"FILTER-UNCHECKED"] forState:UIControlStateNormal];
        [starClubButtonSelection setImage:[UIImage imageNamed:@"FILTER-CHECKED"] forState:UIControlStateSelected];
        [starClubButtonSelection setTag:i];
        [starClubButtonSelection setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
        [starClubButtonSelection addTarget:self action:@selector(starClubButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [scroll_filter addSubview:starClubButtonSelection];
        
        UILabel* label_starClub = [[UILabel alloc] initWithFrame:CGRectMake(50, y_starbutton
                                                                            , 150, 20)];
        [label_starClub setTextColor:[UIColor whiteColor]];
        [label_starClub setText:[clubArray objectAtIndex:i]];
        [label_starClub setFont:[UIFont fontWithName:@"Helvetica Neue" size:10.0]];
        [scroll_filter addSubview:label_starClub];

        
        [button_myBookmarks setFrame:CGRectMake(button_myBookmarks.frame.origin.x, y_starbutton+25, button_myBookmarks.frame.size.width,button_myBookmarks.frame.size.height )];

        [button_aboutUs setFrame:CGRectMake(button_aboutUs.frame.origin.x, button_myBookmarks.frame.origin.y+35, button_aboutUs.frame.size.width, button_aboutUs.frame.size.height)];

        [button_TermsCondition setFrame:CGRectMake(button_TermsCondition.frame.origin.x, button_aboutUs.frame.origin.y+35, button_TermsCondition.frame.size.width, button_TermsCondition.frame.size.height)];
        
        [scroll_filter setContentSize:CGSizeMake(scroll_filter.frame.size.width, button_TermsCondition.frame.origin.y+button_TermsCondition.frame.size.height+20)];


    }
}
-(void)starClubButtonAction:(id)sender
{
    NSLog(@"Sender Tag [%ld]",(long)[sender tag]);
    if ([sender isSelected])
    {
        [sender setSelected:NO];
    }
    else
    {
        [sender setSelected:YES];
    }

}

-(IBAction)highestbookmark:(id)sender
{
    if ([sender isSelected]) {
        [lbl_highestbookmark setTextColor:[UIColor whiteColor]];
        [sender setSelected:NO];
    }
    else
    {
        [lbl_highestbookmark setTextColor:[UIColor yellowColor]];
        [sender setSelected:YES];
    }
    
}
-(IBAction)freeentry:(id)sender
{
    if ([sender isSelected]) {
        [lbl_freeEntry setTextColor:[UIColor whiteColor]];
        [sender setSelected:NO];
    }
    else
    {
        [lbl_freeEntry setTextColor:[UIColor yellowColor]];
        [sender setSelected:YES];
    }
    
}
-(IBAction)specialoffers:(id)sender
{
    if ([sender isSelected]) {
        [lbl_specialOffers setTextColor:[UIColor whiteColor]];
        [sender setSelected:NO];
    }
    else
    {
        [lbl_specialOffers setTextColor:[UIColor yellowColor]];
        [sender setSelected:YES];
    }
    
}



-(IBAction)kmButtonAction:(id)sender
{
    
    [button_2km setSelected:NO];
    [button_5km setSelected:NO];
    [button_10km setSelected:NO];
    [button_20km setSelected:NO];
    [button_50km setSelected:NO];
    
    UIButton* kmButton = (UIButton*)sender;
    
    if ([sender isSelected]) {
        [sender setSelected:NO];
    }
    else
        [sender setSelected:YES];
    
    [kmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [kmButton setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    
}

///////===

-(IBAction)hideFilter:(id)sender
{
    
    [btn_menu setSelected:NO];
    [self.view sendSubviewToBack:filerView];
    [filerView setHidden:YES];

}

-(IBAction)menuImageCloseButton:(id)sender
{
    [self.view_evenDetailMenu sendSubviewToBack:view_evenDetailMenu];
    [view_evenDetailMenu setHidden:YES];
}
-(IBAction)EventCloseButton:(id)sender
{
    [self.view sendSubviewToBack:view_forEventClubDetail];
    [view_forEventClubDetail setHidden:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        self.containerViewController = segue.destinationViewController;
    }
}

-(IBAction)callToClub:(id)sender
{
}
-(IBAction)selectState:(id)sender
{
    IQActionSheetPickerView *picker;
        picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Select City" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        [picker setTag:4];
        picker.delegate=self;
        [picker setTitlesForComponenets:[NSArray arrayWithObjects:
                                         @"DELHI",@"GURGAON",@"NOIDA", nil]];
   // [picker showInView:self.view];
    
    //[self.view bringSubviewToFront:picker];

   
}
#pragma mark - PICKER VIEW DELEGATE
- (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray*)titles
{
    DLog(@"Picker Array = %@",titles);
    
    if([titles count]==1)
    {
        
        switch (pickerView.tag) {
            case 4:
            {
                lbl_searchedText.text = [titles objectAtIndex:0];
            }
                break;
            default:
                break;
        }
        
    }
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
