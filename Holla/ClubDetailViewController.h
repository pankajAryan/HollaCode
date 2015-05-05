//
//  ClubDetailViewController.h
//  Holla
//
//  Created by Ashish Singal on 25/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"
#import "AMNetworkClient.h"

@interface ClubDetailViewController : UIViewController<CollapseClickDelegate,UICollectionViewDelegate,UICollectionViewDelegate,APIInvokerDelegate>
{

    IBOutlet UIView *test1View;
    IBOutlet UIView *test2View;
    IBOutlet UIView *test3View;
    IBOutlet UIView *test4View;
    IBOutlet UIView *test5View;
    IBOutlet UIView *test6View;
    IBOutlet UIView *test7View;

    IBOutlet UIScrollView *main_scroll;
    IBOutlet UIView *menuView;

    __weak IBOutlet CollapseClick *myCollapseClick;
    
    
    //data filling components
    
    __weak IBOutlet UIImageView *clubImage;
    __weak IBOutlet UILabel *clubName;

    __weak IBOutlet UILabel *clubAddress;
    __weak IBOutlet UILabel *clubTimings;
    __weak IBOutlet UILabel *clubAmount;
    __weak IBOutlet UILabel *clubCondition;
    __weak IBOutlet UILabel *clubDistance;
    
    __weak IBOutlet UILabel *clubDuration;
    __weak IBOutlet UILabel *clubBookmark;
    __weak IBOutlet UIButton *clubLikeButton;
    
    __weak IBOutlet UILabel *clubAboutUs;
    
    __weak IBOutlet UIButton *menuButton1;
    
    __weak IBOutlet UILabel *labelMenu1;
    
    __weak IBOutlet UIButton *menuButton2;
    
    __weak IBOutlet UILabel *labelMenu2;
    
    __weak IBOutlet UIButton *menuButton3;
    
    __weak IBOutlet UILabel *labelMenu3;
    
    __weak IBOutlet UIButton *menuButtonMultiple;
    
    __weak IBOutlet UILabel *labelMenuMultiple;
    //data filling components

    
}

@property (nonatomic,retain) NSDictionary* dict_selectedClub;

@end
