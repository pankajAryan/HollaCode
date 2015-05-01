//
//  OfferDetailViewController.m
//  Holla
//
//  Created by Ashish Singal on 26/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import "OfferDetailViewController.h"
#import "RootViewController.h"
#import "UtilityClass.h"

@interface OfferDetailViewController ()

@end

@implementation OfferDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Do any additional setup after loading the view.
    
    myCollapseClick.CollapseClickDelegate = self;
    [myCollapseClick reloadCollapseClick];
    
    // If you want a cell open on load, run this method:
    // [myCollapseClick openCollapseClickCellAtIndex:1 animated:NO];
    
    [main_scroll setContentSize:CGSizeMake(320, 700)];
    
    NSLog(@"Contentsize {%f}",myCollapseClick.contentSize.height);
    myCollapseClick.scrollEnabled = NO;



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
    switch (index) {
        case 0:
            return @"Lounge";
            break;
        case 1:
            return @"Exapate Nights";
            break;
        case 2:
            return @"Karaoke";
            break;
        case 3:
            return @"Rock Band - USA";
            break;
        case 4:
            return @"International DJs";
            break;
        case 5:
            return @"Live Musics";
            break;
        case 6:
            return @"Qawali nights";
            break;
            
        default:
            return @"No Program";
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


-(UIColor *)colorForTitleArrowAtIndex:(int)index {
    return [UIColor grayColor];
}

-(void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open
{

    NSLog(@"%d and it's open:%@", index, (open ? @"YES" : @"NO"));
    
    NSLog(@"Contentsize height{%f}",myCollapseClick.frame.size.height);
    
    NSLog(@"Contentsize open{%f}",myCollapseClick.contentSize.height);
    
    [myCollapseClick setFrame:CGRectMake(myCollapseClick.frame.origin.x, myCollapseClick.frame.origin.y, myCollapseClick.frame.size.width, myCollapseClick.contentSize.height)];
    
    [menuView setFrame:CGRectMake(menuView.frame.origin.x, myCollapseClick.frame.size.height+190, menuView.frame.size.width, menuView.frame.size.height)];
    
    [main_scroll setContentSize:CGSizeMake(320, menuView.frame.origin.y + 230)];

}

#pragma mark - BUTTON IMAGES
-(IBAction)menuButtonAction:(id)sender
{
    NSArray* viewControllers = [self.navigationController viewControllers];
    DLog(@"viewControllers [%@]",viewControllers);
    DLog(@"parentViewController [%@]",self.parentViewController);
    
    RootViewController* rootVc = (RootViewController*)[viewControllers objectAtIndex:1];
    [rootVc.view bringSubviewToFront:rootVc.view_evenDetailMenu];
    [rootVc.view_evenDetailMenu setHidden:NO];
    
}
-(IBAction)callToClub:(id)sender
{
    [UtilityClass callToHelpCenterWithNumber:@""];
}


@end
