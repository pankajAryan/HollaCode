//
//  EventViewController.m
//  Holla
//
//  Created by Ashish Singal on 26/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "EventViewController.h"

#import "UIViewController+ALPopupViewController.h"
#import "RootViewController.h"
#import "UtilityClass.h"

#import "HConstants.h"

@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [AMNetworkClient instance].delegate = self;
    
    if (DUMMYDATA) {
        NSDictionary* dict_HomeDetail = [[NSDictionary alloc] initWithObjectsAndKeys:
                                         [UtilityClass getDeviceUDID],@"deviceId",
                                         @"2",@"cityId",
                                         nil];
        
        [UtilityClass showSpinnerWithMessage:@"Fetching Data.." :self];
        [[AMNetworkClient instance] fetchEvents:dict_HomeDetail];
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    self.view.userInteractionEnabled = YES;
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EVENTcellIdentifier"];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* viewControllers = [self.navigationController viewControllers];
    DLog(@"viewControllers [%@]",viewControllers);
    DLog(@"parentViewController [%@]",self.parentViewController);
    
    RootViewController* rootVc = (RootViewController*)[viewControllers objectAtIndex:1];
    [rootVc.view bringSubviewToFront:rootVc.view_forEventClubDetail];
    
    [UIView animateWithDuration:0.6 animations:^{
        [rootVc.view_forEventClubDetail setHidden:NO];
    }];


    return;

    
}
- (UIImage*)screenshot
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    image = [UIImage imageWithData:imageData];
    
    return image;
}
-(void)GetEventListRequestFinished:(id)JSON
{
    
    NSLog(@"GetMusciCategoriesRequestFinished Finish Response %@",JSON);
    [UtilityClass hideSpinner];
    
    if ([[JSON objectForKey:@"errorCode"] intValue] == 0) {
        
    }
}
-(void)GetEventListFailed:(id)Errorresponses
{
    NSLog(@"GetMusciCategoriesFailed %@",Errorresponses);
    [UtilityClass hideSpinner];
}


@end
