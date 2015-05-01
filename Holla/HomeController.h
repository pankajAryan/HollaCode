//
//  HomeController.h
//  Holla
//
//  Created by Ashish Singal on 16/03/15.
//  Copyright (c) 2015 Ashish Singal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMNetworkClient.h"

#import "DMCircularScrollView.h"


@interface HomeController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,APIInvokerDelegate>
{
    IBOutlet UICollectionViewCell* cc_dj;
    IBOutlet UICollectionView* cc_event;

    __weak IBOutlet UIPageControl *pageControl;
    DMCircularScrollView* threePageScrollView;
    NSArray *threePageScroller_Views;

}

@end
