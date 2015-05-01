//
//  OfferDetailViewController.h
//  Holla
//
//  Created by Ashish Singal on 26/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"

@interface OfferDetailViewController : UIViewController<CollapseClickDelegate>
{

    IBOutlet UIView *test1View;
    IBOutlet UIView *test2View;
    IBOutlet UIView *test3View;
    IBOutlet UIView *test4View;
    IBOutlet UIView *test5View;
    IBOutlet UIView *test6View;
    IBOutlet UIView *test7View;
    
    __weak IBOutlet CollapseClick *myCollapseClick;
    
    IBOutlet UIScrollView *main_scroll;
    IBOutlet UIView *menuView;


}
@end
